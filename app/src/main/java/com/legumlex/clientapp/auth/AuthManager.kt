package com.legumlex.clientapp.auth

import android.content.Context
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.stringPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import com.legumlex.clientapp.services.ApiService
import com.legumlex.clientapp.models.User
import com.legumlex.clientapp.services.ApiResult
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.map
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken

val Context.dataStore: DataStore<Preferences> by preferencesDataStore(name = "auth_prefs")

class AuthManager(
    private val context: Context,
    private val api: ApiService
) {
    private val gson = Gson()
    companion object {
        private val TOKEN_KEY = stringPreferencesKey("auth_token")
        private val USER_KEY = stringPreferencesKey("user_data")
        private val REFRESH_TOKEN_KEY = stringPreferencesKey("refresh_token")
    }

    val isLoggedIn: Flow<Boolean> = context.dataStore.data.map { preferences ->
        preferences[TOKEN_KEY] != null
    }

    val currentUser: Flow<User?> = context.dataStore.data.map { preferences ->
        preferences[USER_KEY]?.let { userJson ->
            try {
                gson.fromJson(userJson, User::class.java)
            } catch (e: Exception) {
                null
            }
        }
    }

    suspend fun login(email: String, password: String): ApiResult<User> {
        return try {
            // For Perfex CRM, authentication is typically done with email and password
            // but API access uses tokens. For client portal, we'll simulate login
            val response = api.authenticate(
                mapOf(
                    "email" to email,
                    "password" to password
                )
            )
            
            if (response.isSuccessful) {
                val loginResponse = response.body()
                if (loginResponse != null) {
                    // Save auth data
                    context.dataStore.edit { preferences ->
                        preferences[TOKEN_KEY] = loginResponse.token
                        preferences[USER_KEY] = gson.toJson(loginResponse.user)
                        loginResponse.refreshToken?.let { refreshToken ->
                            preferences[REFRESH_TOKEN_KEY] = refreshToken
                        }
                    }
                    ApiResult.Success(loginResponse.user)
                } else {
                    ApiResult.Error("Invalid response from server")
                }
            } else {
                ApiResult.Error("Login failed: ${response.message()}")
            }
        } catch (e: Exception) {
            ApiResult.Error("Login failed: ${e.message}")
        }
    }

    suspend fun logout() {
        context.dataStore.edit { preferences ->
            preferences.clear()
        }
    }

    suspend fun getAuthToken(): String? {
        return context.dataStore.data.first()[TOKEN_KEY]
    }

    suspend fun validateToken(): ApiResult<User> {
        return try {
            val token = getAuthToken()
            if (token == null) {
                return ApiResult.Error("No authentication token available")
            }

            val response = api.getCurrentUser()
            
            if (response.isSuccessful) {
                val user = response.body()
                if (user != null) {
                    // Update user data in storage
                    context.dataStore.edit { preferences ->
                        preferences[USER_KEY] = gson.toJson(user)
                    }
                    ApiResult.Success(user)
                } else {
                    ApiResult.Error("Invalid user response")
                }
            } else {
                ApiResult.Error("Token validation failed: ${response.message()}")
            }
        } catch (e: Exception) {
            ApiResult.Error("Token validation failed: ${e.message}")
        }
    }
}

data class LoginResponse(
    val token: String,
    val user: User,
    val refreshToken: String? = null
)

data class RefreshTokenResponse(
    val token: String
)