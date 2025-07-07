package com.legumlex.clientapp

import android.content.Context
import com.legumlex.clientapp.services.ApiClient
import com.legumlex.clientapp.services.LoginRequest
import com.legumlex.clientapp.services.TokenManager
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.first

class SimpleAuthManager(private val context: Context) {
    
    private val tokenManager = TokenManager(context)
    private val apiService = ApiClient.getInstance()
    
    private val _isLoggedIn = MutableStateFlow(false)
    val isLoggedIn: StateFlow<Boolean> = _isLoggedIn
    
    private val _error = MutableStateFlow<String?>(null)
    val error: StateFlow<String?> = _error
    
    init {
        // Check if user is already logged in
        checkAuthStatus()
    }
    
    private fun checkAuthStatus() {
        kotlinx.coroutines.GlobalScope.launch {
            val isLoggedIn = tokenManager.isLoggedIn().first()
            _isLoggedIn.value = isLoggedIn
        }
    }
    
    suspend fun login(email: String, password: String): Boolean {
        return try {
            _error.value = null
            
            // Validate input
            if (email.isEmpty() || password.isEmpty()) {
                _error.value = "Please enter both email and password"
                return false
            }
            
            // For now, use simple validation until we have proper API auth
            // TODO: Replace with actual API call once Perfex auth endpoint is confirmed
            val isValidCredentials = email.isNotEmpty() && password.isNotEmpty()
            
            if (isValidCredentials) {
                // Save mock token and user info
                tokenManager.saveAuthToken("mock_token_${System.currentTimeMillis()}")
                tokenManager.saveUserInfo(email, "user_${System.currentTimeMillis()}")
                _isLoggedIn.value = true
                true
            } else {
                _error.value = "Invalid credentials"
                false
            }
            
            /* TODO: Implement real API authentication
            val response = apiService.authenticate(LoginRequest(email, password))
            if (response.isSuccessful && response.body()?.success == true) {
                val authResponse = response.body()!!
                tokenManager.saveAuthToken(authResponse.token!!)
                tokenManager.saveUserInfo(email, authResponse.user!!.id)
                _isLoggedIn.value = true
                true
            } else {
                _error.value = response.body()?.message ?: "Login failed"
                false
            }
            */
            
        } catch (e: Exception) {
            _error.value = "Network error: ${e.message}"
            false
        }
    }
    
    suspend fun logout() {
        tokenManager.clearAuth()
        _isLoggedIn.value = false
    }
    
    fun clearError() {
        _error.value = null
    }
}