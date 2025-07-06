package com.legumlex.clientapp.viewmodels

import androidx.lifecycle.viewModelScope
import com.legumlex.clientapp.auth.AuthManager
import com.legumlex.clientapp.data.repository.ApiResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class LoginViewModel @Inject constructor(
    private val authManager: AuthManager
) : BaseViewModel() {
    
    private val _uiState = MutableStateFlow(LoginUiState())
    val uiState: StateFlow<LoginUiState> = _uiState.asStateFlow()
    
    fun updateEmail(email: String) {
        _uiState.value = _uiState.value.copy(email = email)
        clearError()
    }
    
    fun updatePassword(password: String) {
        _uiState.value = _uiState.value.copy(password = password)
        clearError()
    }
    
    fun login() {
        val currentState = _uiState.value
        if (currentState.email.isBlank() || currentState.password.isBlank()) {
            _error.value = "Please enter both email and password"
            return
        }
        
        viewModelScope.launch {
            _isLoading.value = true
            clearError()
            
            when (val result = authManager.login(currentState.email, currentState.password)) {
                is ApiResult.Success -> {
                    _uiState.value = _uiState.value.copy(
                        isLoggedIn = true,
                        password = "" // Clear password for security
                    )
                }
                is ApiResult.Error -> {
                    _error.value = result.message
                }
                is ApiResult.Loading -> {
                    // Already handled by _isLoading
                }
            }
            
            _isLoading.value = false
        }
    }
    
    override fun clearError() {
        _error.value = null
    }
}

data class LoginUiState(
    val email: String = "",
    val password: String = "",
    val isLoggedIn: Boolean = false
)