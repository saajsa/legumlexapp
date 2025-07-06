package com.legumlex.clientapp.viewmodels

import androidx.lifecycle.viewModelScope
import com.legumlex.clientapp.models.*
import com.legumlex.clientapp.services.ApiResult
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

data class DashboardUiState(
    val recentCases: List<Case> = emptyList(),
    val recentInvoices: List<Invoice> = emptyList(),
    val recentDocuments: List<Document> = emptyList(),
    val recentTickets: List<Ticket> = emptyList(),
    val summaryStats: DashboardStats = DashboardStats(),
    val isRefreshing: Boolean = false
)

data class DashboardStats(
    val totalCases: Int = 0,
    val activeCases: Int = 0,
    val totalInvoices: Int = 0,
    val unpaidInvoices: Int = 0,
    val totalDocuments: Int = 0,
    val openTickets: Int = 0,
    val totalAmount: Double = 0.0,
    val unpaidAmount: Double = 0.0
)

class DashboardViewModel : BaseViewModel() {
    
    private val _uiState = MutableStateFlow(DashboardUiState())
    val uiState: StateFlow<DashboardUiState> = _uiState.asStateFlow()
    
    init {
        loadDashboardData()
    }
    
    fun loadDashboardData() {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isRefreshing = true)
            
            // Load recent cases
            loadRecentCases()
            
            // Load recent invoices
            loadRecentInvoices()
            
            // Load recent documents
            loadRecentDocuments()
            
            // Load recent tickets
            loadRecentTickets()
            
            _uiState.value = _uiState.value.copy(isRefreshing = false)
        }
    }
    
    private suspend fun loadRecentCases() {
        when (val result = repository.getCases(page = 1, limit = 5)) {
            is ApiResult.Success -> {
                _uiState.value = _uiState.value.copy(
                    recentCases = result.data,
                    summaryStats = _uiState.value.summaryStats.copy(
                        totalCases = result.data.size,
                        activeCases = result.data.count { it.isActive }
                    )
                )
            }
            is ApiResult.Error -> {
                setError("Failed to load cases: ${result.message}")
            }
            is ApiResult.Loading -> {
                // Handle loading state if needed
            }
        }
    }
    
    private suspend fun loadRecentInvoices() {
        when (val result = repository.getInvoices(page = 1, limit = 5)) {
            is ApiResult.Success -> {
                val totalAmount = result.data.sumOf { it.totalAmount }
                val unpaidAmount = result.data.filter { !it.isPaid }.sumOf { it.totalAmount }
                
                _uiState.value = _uiState.value.copy(
                    recentInvoices = result.data,
                    summaryStats = _uiState.value.summaryStats.copy(
                        totalInvoices = result.data.size,
                        unpaidInvoices = result.data.count { !it.isPaid },
                        totalAmount = totalAmount,
                        unpaidAmount = unpaidAmount
                    )
                )
            }
            is ApiResult.Error -> {
                setError("Failed to load invoices: ${result.message}")
            }
            is ApiResult.Loading -> {
                // Handle loading state if needed
            }
        }
    }
    
    private suspend fun loadRecentDocuments() {
        when (val result = repository.getDocuments(page = 1, limit = 5)) {
            is ApiResult.Success -> {
                _uiState.value = _uiState.value.copy(
                    recentDocuments = result.data,
                    summaryStats = _uiState.value.summaryStats.copy(
                        totalDocuments = result.data.size
                    )
                )
            }
            is ApiResult.Error -> {
                setError("Failed to load documents: ${result.message}")
            }
            is ApiResult.Loading -> {
                // Handle loading state if needed
            }
        }
    }
    
    private suspend fun loadRecentTickets() {
        when (val result = repository.getTickets(page = 1, limit = 5)) {
            is ApiResult.Success -> {
                _uiState.value = _uiState.value.copy(
                    recentTickets = result.data,
                    summaryStats = _uiState.value.summaryStats.copy(
                        openTickets = result.data.count { it.isOpen }
                    )
                )
            }
            is ApiResult.Error -> {
                setError("Failed to load tickets: ${result.message}")
            }
            is ApiResult.Loading -> {
                // Handle loading state if needed
            }
        }
    }
    
    fun refreshDashboard() {
        loadDashboardData()
    }
    
    fun clearError() {
        super.clearError()
    }
}