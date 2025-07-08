package com.legumlex.clientapp.services

import android.content.Context
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.stringPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map

class TokenManager(private val context: Context) {
    
    companion object {
        private val Context.dataStore: DataStore<Preferences> by preferencesDataStore(name = "auth_preferences")
        private val AUTH_TOKEN_KEY = stringPreferencesKey("auth_token")
        private val USER_EMAIL_KEY = stringPreferencesKey("user_email")
        private val USER_ID_KEY = stringPreferencesKey("user_id")
        private val CONTACT_ID_KEY = stringPreferencesKey("contact_id")
    }
    
    // Save authentication token
    suspend fun saveAuthToken(token: String) {
        context.dataStore.edit { preferences ->
            preferences[AUTH_TOKEN_KEY] = token
        }
    }
    
    // Get authentication token
    fun getAuthToken(): Flow<String?> {
        return context.dataStore.data.map { preferences ->
            preferences[AUTH_TOKEN_KEY]
        }
    }
    
    // Save user info
    suspend fun saveUserInfo(email: String, userId: String) {
        context.dataStore.edit { preferences ->
            preferences[USER_EMAIL_KEY] = email
            preferences[USER_ID_KEY] = userId
        }
    }
    
    // Get user email
    fun getUserEmail(): Flow<String?> {
        return context.dataStore.data.map { preferences ->
            preferences[USER_EMAIL_KEY]
        }
    }
    
    // Get user ID
    fun getUserId(): Flow<String?> {
        return context.dataStore.data.map { preferences ->
            preferences[USER_ID_KEY]
        }
    }
    
    // Clear all authentication data
    suspend fun clearAuth() {
        context.dataStore.edit { preferences ->
            preferences.clear()
        }
    }
    
    // Check if user is logged in
    fun isLoggedIn(): Flow<Boolean> {
        return getAuthToken().map { token ->
            !token.isNullOrEmpty()
        }
    }
    
    // Additional methods for Customer API
    suspend fun saveToken(token: String) = saveAuthToken(token)
    fun getToken(): Flow<String?> = getAuthToken()
    
    suspend fun saveUserId(userId: String) {
        context.dataStore.edit { preferences ->
            preferences[USER_ID_KEY] = userId
        }
    }
    
    suspend fun saveContactId(contactId: String) {
        context.dataStore.edit { preferences ->
            preferences[CONTACT_ID_KEY] = contactId
        }
    }
    
    fun getContactId(): Flow<String?> {
        return context.dataStore.data.map { preferences ->
            preferences[CONTACT_ID_KEY]
        }
    }
    
    suspend fun clearToken() {
        context.dataStore.edit { preferences ->
            preferences.remove(AUTH_TOKEN_KEY)
        }
    }
    
    suspend fun clearUserId() {
        context.dataStore.edit { preferences ->
            preferences.remove(USER_ID_KEY)
        }
    }
    
    suspend fun clearContactId() {
        context.dataStore.edit { preferences ->
            preferences.remove(CONTACT_ID_KEY)
        }
    }
}