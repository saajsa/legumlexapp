package com.legumlex.clientapp.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.legumlex.clientapp.models.Invoice
import com.legumlex.clientapp.services.ApiResult
import com.legumlex.clientapp.services.ClientRepository
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch

class InvoicesViewModel(
    private val repository: ClientRepository
) : ViewModel() {
    
    private val _invoices = MutableStateFlow<List<Invoice>>(emptyList())
    val invoices: StateFlow<List<Invoice>> = _invoices
    
    private val _isLoading = MutableStateFlow(false)
    val isLoading: StateFlow<Boolean> = _isLoading
    
    private val _error = MutableStateFlow<String?>(null)
    val error: StateFlow<String?> = _error
    
    init {
        loadInvoices()
    }
    
    fun loadInvoices() {
        viewModelScope.launch {
            _isLoading.value = true
            _error.value = null
            
            when (val result = repository.getInvoices()) {
                is ApiResult.Success -> {
                    _invoices.value = result.data
                    _error.value = null
                }
                is ApiResult.Error -> {
                    _error.value = result.message
                }
                is ApiResult.Loading -> {
                    // Loading state already handled
                }
            }
            
            _isLoading.value = false
        }
    }
    
    fun refresh() {
        loadInvoices()
    }
}