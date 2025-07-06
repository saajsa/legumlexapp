package com.legumlex.clientapp.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.legumlex.clientapp.services.ApiResult
import com.legumlex.clientapp.services.Repository
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

abstract class BaseViewModel : ViewModel() {
    
    protected val repository = Repository.getInstance()
    
    private val _isLoading = MutableStateFlow(false)
    val isLoading: StateFlow<Boolean> = _isLoading.asStateFlow()
    
    private val _error = MutableStateFlow<String?>(null)
    val error: StateFlow<String?> = _error.asStateFlow()
    
    protected fun <T> handleApiResult(
        result: ApiResult<T>,
        onSuccess: (T) -> Unit,
        onError: (String) -> Unit = { setError(it) }
    ) {
        when (result) {
            is ApiResult.Success -> {
                setLoading(false)
                clearError()
                onSuccess(result.data)
            }
            is ApiResult.Error -> {
                setLoading(false)
                onError(result.message)
            }
            is ApiResult.Loading -> {
                setLoading(true)
                clearError()
            }
        }
    }
    
    protected fun setLoading(loading: Boolean) {
        _isLoading.value = loading
    }
    
    protected fun setError(message: String) {
        _error.value = message
    }
    
    protected open fun clearError() {
        _error.value = null
    }
    
    protected fun launchSafely(action: suspend () -> Unit) {
        viewModelScope.launch {
            try {
                action()
            } catch (e: Exception) {
                setError(e.message ?: "Unknown error occurred")
            }
        }
    }
}