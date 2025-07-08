package com.legumlex.clientapp.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.legumlex.clientapp.services.ApiResult
import com.legumlex.clientapp.services.CustomerRepository
import com.legumlex.clientapp.models.DashboardStats
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch

class DashboardViewModel(
    private val repository: CustomerRepository
) : ViewModel() {
    
    private val _stats = MutableStateFlow(DashboardStats())
    val stats: StateFlow<DashboardStats> = _stats
    
    private val _isLoading = MutableStateFlow(false)
    val isLoading: StateFlow<Boolean> = _isLoading
    
    private val _error = MutableStateFlow<String?>(null)
    val error: StateFlow<String?> = _error
    
    init {
        loadStats()
    }
    
    fun loadStats() {
        viewModelScope.launch {
            _isLoading.value = true
            _error.value = null
            
            when (val result = repository.getDashboardStats()) {
                is ApiResult.Success -> {
                    _stats.value = result.data
                    _error.value = null
                }
                is ApiResult.Error -> {
                    _error.value = result.message
                }
                ApiResult.Loading -> {
                    // Loading state already handled
                }
            }
            
            _isLoading.value = false
        }
    }
    
    fun refresh() {
        loadStats()
    }
}