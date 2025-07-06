package com.legumlex.clientapp

import android.content.Context
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow

class SimpleAuthManager(private val context: Context) {
    
    private val _isLoggedIn = MutableStateFlow(false)
    val isLoggedIn: StateFlow<Boolean> = _isLoggedIn
    
    suspend fun login(email: String, password: String): Boolean {
        // Simple mock login - in real app, this would call API
        return if (email.isNotEmpty() && password.isNotEmpty()) {
            _isLoggedIn.value = true
            true
        } else {
            false
        }
    }
    
    fun logout() {
        _isLoggedIn.value = false
    }
}