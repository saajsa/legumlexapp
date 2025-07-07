package com.legumlex.clientapp

import android.content.Context
import com.legumlex.clientapp.services.ApiClient
import com.legumlex.clientapp.services.TokenManager
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

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
        CoroutineScope(Dispatchers.Main).launch {
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
            
            // Test the API connection with cases endpoint to verify access
            val response = apiService.getCases()
            
            if (response.isSuccessful) {
                val cases = response.body() ?: emptyList()
                
                // For demo purposes, extract client info from first case if available
                val clientId = if (cases.isNotEmpty()) {
                    cases.first().clientId
                } else {
                    "1" // Default client ID
                }
                
                // Save the API token (already configured) and user info
                tokenManager.saveAuthToken(com.legumlex.clientapp.utils.ApiConfig.API_TOKEN)
                tokenManager.saveUserInfo(email, clientId)
                _isLoggedIn.value = true
                true
            } else {
                when (response.code()) {
                    401 -> _error.value = "Invalid credentials or API token"
                    403 -> _error.value = "Access denied"
                    404 -> _error.value = "Service not found - Please check API configuration"
                    else -> _error.value = "Login failed: ${response.message()}"
                }
                false
            }
            
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