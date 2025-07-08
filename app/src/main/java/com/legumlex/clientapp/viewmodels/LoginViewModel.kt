package com.legumlex.clientapp.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.legumlex.clientapp.services.CustomerAuthManager
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch

class LoginViewModel(
    private val authManager: CustomerAuthManager
) : ViewModel() {
    
    private val _email = MutableStateFlow("")
    val email: StateFlow<String> = _email
    
    private val _password = MutableStateFlow("")
    val password: StateFlow<String> = _password
    
    private val _isLoading = MutableStateFlow(false)
    val isLoading: StateFlow<Boolean> = _isLoading
    
    private val _error = MutableStateFlow<String?>(null)
    val error: StateFlow<String?> = _error
    
    fun updateEmail(newEmail: String) {
        _email.value = newEmail
    }
    
    fun updatePassword(newPassword: String) {
        _password.value = newPassword
    }
    
    fun login() {
        if (_email.value.isEmpty() || _password.value.isEmpty()) {
            _error.value = "Please enter both email and password"
            return
        }
        
        _isLoading.value = true
        _error.value = null
        
        viewModelScope.launch {
            val success = authManager.login(_email.value, _password.value)
            _isLoading.value = false
            
            if (!success) {
                // Error is already set in authManager
                _error.value = authManager.error.value
            }
        }
    }
    
    fun clearError() {
        _error.value = null
        authManager.clearError()
    }
}