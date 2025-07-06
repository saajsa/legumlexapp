package com.legumlex.clientapp.viewmodels

import androidx.lifecycle.viewModelScope
import com.legumlex.clientapp.models.Invoice
import com.legumlex.clientapp.models.Payment
import com.legumlex.clientapp.services.ApiResult
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

data class InvoiceUiState(
    val invoices: List<Invoice> = emptyList(),
    val selectedInvoice: Invoice? = null,
    val invoicePayments: List<Payment> = emptyList(),
    val isLoadingInvoices: Boolean = false,
    val isLoadingInvoiceDetails: Boolean = false,
    val isLoadingPayments: Boolean = false,
    val isDownloadingPdf: Boolean = false,
    val searchQuery: String = "",
    val filteredInvoices: List<Invoice> = emptyList(),
    val selectedFilter: InvoiceFilter = InvoiceFilter.ALL
)

enum class InvoiceFilter {
    ALL, PAID, UNPAID, OVERDUE, DRAFT
}

class InvoiceViewModel : BaseViewModel() {
    
    private val _uiState = MutableStateFlow(InvoiceUiState())
    val uiState: StateFlow<InvoiceUiState> = _uiState.asStateFlow()
    
    init {
        loadInvoices()
    }
    
    fun loadInvoices() {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isLoadingInvoices = true)
            
            when (val result = repository.getInvoices()) {
                is ApiResult.Success -> {
                    _uiState.value = _uiState.value.copy(
                        invoices = result.data,
                        filteredInvoices = filterInvoices(result.data, _uiState.value.selectedFilter, _uiState.value.searchQuery),
                        isLoadingInvoices = false
                    )
                }
                is ApiResult.Error -> {
                    _uiState.value = _uiState.value.copy(isLoadingInvoices = false)
                    setError("Failed to load invoices: ${result.message}")
                }
                is ApiResult.Loading -> {
                    _uiState.value = _uiState.value.copy(isLoadingInvoices = true)
                }
            }
        }
    }
    
    fun loadInvoiceDetails(invoiceId: String) {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isLoadingInvoiceDetails = true)
            
            when (val result = repository.getInvoice(invoiceId)) {
                is ApiResult.Success -> {
                    _uiState.value = _uiState.value.copy(
                        selectedInvoice = result.data,
                        isLoadingInvoiceDetails = false
                    )
                    // Load invoice payments
                    loadInvoicePayments(invoiceId)
                }
                is ApiResult.Error -> {
                    _uiState.value = _uiState.value.copy(isLoadingInvoiceDetails = false)
                    setError("Failed to load invoice details: ${result.message}")
                }
                is ApiResult.Loading -> {
                    _uiState.value = _uiState.value.copy(isLoadingInvoiceDetails = true)
                }
            }
        }
    }
    
    private fun loadInvoicePayments(invoiceId: String) {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isLoadingPayments = true)
            
            when (val result = repository.getPayments(invoiceId = invoiceId)) {
                is ApiResult.Success -> {
                    _uiState.value = _uiState.value.copy(
                        invoicePayments = result.data,
                        isLoadingPayments = false
                    )
                }
                is ApiResult.Error -> {
                    _uiState.value = _uiState.value.copy(isLoadingPayments = false)
                    setError("Failed to load payments: ${result.message}")
                }
                is ApiResult.Loading -> {
                    _uiState.value = _uiState.value.copy(isLoadingPayments = true)
                }
            }
        }
    }
    
    fun downloadInvoicePdf(invoiceId: String) {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isDownloadingPdf = true)
            
            when (val result = repository.getInvoicePdf(invoiceId)) {
                is ApiResult.Success -> {
                    _uiState.value = _uiState.value.copy(isDownloadingPdf = false)
                    // Handle PDF download success
                    // This would typically involve saving the file or opening it
                }
                is ApiResult.Error -> {
                    _uiState.value = _uiState.value.copy(isDownloadingPdf = false)
                    setError("Failed to download PDF: ${result.message}")
                }
                is ApiResult.Loading -> {
                    _uiState.value = _uiState.value.copy(isDownloadingPdf = true)
                }
            }
        }
    }
    
    fun searchInvoices(query: String) {
        _uiState.value = _uiState.value.copy(
            searchQuery = query,
            filteredInvoices = filterInvoices(_uiState.value.invoices, _uiState.value.selectedFilter, query)
        )
    }
    
    fun filterInvoices(filter: InvoiceFilter) {
        _uiState.value = _uiState.value.copy(
            selectedFilter = filter,
            filteredInvoices = filterInvoices(_uiState.value.invoices, filter, _uiState.value.searchQuery)
        )
    }
    
    private fun filterInvoices(invoices: List<Invoice>, filter: InvoiceFilter, searchQuery: String): List<Invoice> {
        var filteredInvoices = when (filter) {
            InvoiceFilter.ALL -> invoices
            InvoiceFilter.PAID -> invoices.filter { it.isPaid }
            InvoiceFilter.UNPAID -> invoices.filter { !it.isPaid && !it.isOverdue }
            InvoiceFilter.OVERDUE -> invoices.filter { it.isOverdue }
            InvoiceFilter.DRAFT -> invoices.filter { it.status == "6" }
        }
        
        if (searchQuery.isNotBlank()) {
            filteredInvoices = filteredInvoices.filter { invoice ->
                invoice.number.contains(searchQuery, ignoreCase = true) ||
                invoice.formattedNumber.contains(searchQuery, ignoreCase = true) ||
                invoice.clientNote?.contains(searchQuery, ignoreCase = true) == true
            }
        }
        
        return filteredInvoices.sortedByDescending { it.dateCreated }
    }
    
    fun selectInvoice(invoice: Invoice) {
        _uiState.value = _uiState.value.copy(selectedInvoice = invoice)
        loadInvoicePayments(invoice.id)
    }
    
    fun clearSelectedInvoice() {
        _uiState.value = _uiState.value.copy(
            selectedInvoice = null,
            invoicePayments = emptyList()
        )
    }
    
    fun refreshInvoices() {
        loadInvoices()
    }
    
    fun clearError() {
        super.clearError()
    }
}