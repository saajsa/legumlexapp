package com.legumlex.clientapp

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch

// Simple Login ViewModel
class SimpleLoginViewModel(private val authManager: SimpleAuthManager) : ViewModel() {
    
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
        _error.value = null
    }
    
    fun updatePassword(newPassword: String) {
        _password.value = newPassword
        _error.value = null
    }
    
    fun login() {
        if (_email.value.isEmpty() || _password.value.isEmpty()) {
            _error.value = "Please enter both email and password"
            return
        }
        
        viewModelScope.launch {
            _isLoading.value = true
            val success = authManager.login(_email.value, _password.value)
            _isLoading.value = false
            
            if (!success) {
                _error.value = "Login failed"
            }
        }
    }
}

// Simple Dashboard ViewModel  
class SimpleDashboardViewModel(private val repository: SimpleRepository) : ViewModel() {
    
    private val _stats = MutableStateFlow(DashboardStats())
    val stats: StateFlow<DashboardStats> = _stats
    
    private val _isLoading = MutableStateFlow(false)
    val isLoading: StateFlow<Boolean> = _isLoading
    
    init {
        loadStats()
    }
    
    private fun loadStats() {
        viewModelScope.launch {
            _isLoading.value = true
            when (val result = repository.getDashboardStats()) {
                is SimpleApiResult.Success -> {
                    _stats.value = result.data
                }
                is SimpleApiResult.Error -> {
                    // Handle error
                }
                is SimpleApiResult.Loading -> {
                    // Already handled
                }
            }
            _isLoading.value = false
        }
    }
}