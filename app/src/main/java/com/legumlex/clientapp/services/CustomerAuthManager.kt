package com.legumlex.clientapp.services

import android.content.Context
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.launch

class CustomerAuthManager(private val context: Context) {
    
    private val tokenManager = TokenManager(context)
    private val customerRepository = CustomerRepository(context)
    
    private val _isLoggedIn = MutableStateFlow(false)
    val isLoggedIn: StateFlow<Boolean> = _isLoggedIn
    
    private val _error = MutableStateFlow<String?>(null)
    val error: StateFlow<String?> = _error
    
    init {
        // Check if user is already logged in
        checkLoginStatus()
    }
    
    private fun checkLoginStatus() {
        // Check if we have a valid token
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val token = tokenManager.getToken().first()
                _isLoggedIn.value = !token.isNullOrEmpty()
            } catch (e: Exception) {
                _isLoggedIn.value = false
            }
        }
    }
    
    suspend fun login(email: String, password: String): Boolean {
        return when (val result = customerRepository.login(email, password)) {
            is ApiResult.Success -> {
                _isLoggedIn.value = true
                _error.value = null
                true
            }
            is ApiResult.Error -> {
                _error.value = result.message
                _isLoggedIn.value = false
                false
            }
            ApiResult.Loading -> {
                false
            }
        }
    }
    
    suspend fun logout(): Boolean {
        return when (val result = customerRepository.logout()) {
            is ApiResult.Success -> {
                _isLoggedIn.value = false
                _error.value = null
                true
            }
            is ApiResult.Error -> {
                _error.value = result.message
                // Even if logout fails on server, clear local data
                tokenManager.clearToken()
                tokenManager.clearUserId()
                tokenManager.clearContactId()
                _isLoggedIn.value = false
                false
            }
            ApiResult.Loading -> {
                false
            }
        }
    }
    
    fun clearError() {
        _error.value = null
    }
    
    suspend fun getCurrentUserId(): String? {
        return try {
            tokenManager.getUserId().first()
        } catch (e: Exception) {
            null
        }
    }
    
    suspend fun getCurrentContactId(): String? {
        return try {
            tokenManager.getContactId().first()
        } catch (e: Exception) {
            null
        }
    }
}

