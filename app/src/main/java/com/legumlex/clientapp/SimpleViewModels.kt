package com.legumlex.clientapp

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.legumlex.clientapp.models.DashboardStats
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
        authManager.clearError()
    }
    
    fun updatePassword(newPassword: String) {
        _password.value = newPassword
        _error.value = null
        authManager.clearError()
    }
    
    fun login() {
        if (_email.value.isEmpty() || _password.value.isEmpty()) {
            _error.value = "Please enter both email and password"
            return
        }
        
        viewModelScope.launch {
            _isLoading.value = true
            _error.value = null
            
            try {
                val success = authManager.login(_email.value, _password.value)
                if (!success) {
                    // Get error from auth manager
                    _error.value = authManager.error.value ?: "Login failed"
                }
            } catch (e: Exception) {
                _error.value = "Login error: ${e.message}"
            } finally {
                _isLoading.value = false
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
    
    private val _error = MutableStateFlow<String?>(null)
    val error: StateFlow<String?> = _error
    
    init {
        loadStats()
    }
    
    private fun loadStats() {
        viewModelScope.launch {
            _isLoading.value = true
            _error.value = null
            
            try {
                val result = repository.getDashboardStats()
                when (result) {
                    is SimpleApiResult.Success -> {
                        _stats.value = result.data
                    }
                    is SimpleApiResult.Error -> {
                        _error.value = result.message
                    }
                    is SimpleApiResult.Loading -> {
                        // Already handled by _isLoading
                    }
                }
            } catch (e: Exception) {
                _error.value = "Failed to load dashboard: ${e.message}"
            } finally {
                _isLoading.value = false
            }
        }
    }
    
    fun refresh() {
        loadStats()
    }
}

// Simple Cases ViewModel
class SimpleCasesViewModel(private val repository: SimpleRepository) : ViewModel() {
    
    private val _cases = MutableStateFlow<List<CaseItem>>(emptyList())
    val cases: StateFlow<List<CaseItem>> = _cases
    
    private val _isLoading = MutableStateFlow(false)
    val isLoading: StateFlow<Boolean> = _isLoading
    
    private val _error = MutableStateFlow<String?>(null)
    val error: StateFlow<String?> = _error
    
    init {
        loadCases()
    }
    
    private fun loadCases() {
        viewModelScope.launch {
            _isLoading.value = true
            _error.value = null
            
            try {
                val result = repository.getCases()
                when (result) {
                    is SimpleApiResult.Success -> {
                        _cases.value = result.data
                    }
                    is SimpleApiResult.Error -> {
                        _error.value = result.message
                    }
                    is SimpleApiResult.Loading -> {
                        // Already handled by _isLoading
                    }
                }
            } catch (e: Exception) {
                _error.value = "Failed to load cases: ${e.message}"
            } finally {
                _isLoading.value = false
            }
        }
    }
    
    fun refresh() {
        loadCases()
    }
}

// Simple Documents ViewModel
class SimpleDocumentsViewModel(private val repository: SimpleRepository) : ViewModel() {
    
    private val _documents = MutableStateFlow<List<DocumentItem>>(emptyList())
    val documents: StateFlow<List<DocumentItem>> = _documents
    
    private val _isLoading = MutableStateFlow(false)
    val isLoading: StateFlow<Boolean> = _isLoading
    
    private val _error = MutableStateFlow<String?>(null)
    val error: StateFlow<String?> = _error
    
    init {
        loadDocuments()
    }
    
    private fun loadDocuments() {
        viewModelScope.launch {
            _isLoading.value = true
            _error.value = null
            
            try {
                val result = repository.getDocuments()
                when (result) {
                    is SimpleApiResult.Success -> {
                        _documents.value = result.data
                    }
                    is SimpleApiResult.Error -> {
                        _error.value = result.message
                    }
                    is SimpleApiResult.Loading -> {
                        // Already handled by _isLoading
                    }
                }
            } catch (e: Exception) {
                _error.value = "Failed to load documents: ${e.message}"
            } finally {
                _isLoading.value = false
            }
        }
    }
    
    fun refresh() {
        loadDocuments()
    }
}

// Simple Invoices ViewModel
class SimpleInvoicesViewModel(private val repository: SimpleRepository) : ViewModel() {
    
    private val _invoices = MutableStateFlow<List<InvoiceItem>>(emptyList())
    val invoices: StateFlow<List<InvoiceItem>> = _invoices
    
    private val _isLoading = MutableStateFlow(false)
    val isLoading: StateFlow<Boolean> = _isLoading
    
    private val _error = MutableStateFlow<String?>(null)
    val error: StateFlow<String?> = _error
    
    init {
        loadInvoices()
    }
    
    private fun loadInvoices() {
        viewModelScope.launch {
            _isLoading.value = true
            _error.value = null
            
            try {
                val result = repository.getInvoices()
                when (result) {
                    is SimpleApiResult.Success -> {
                        _invoices.value = result.data
                    }
                    is SimpleApiResult.Error -> {
                        _error.value = result.message
                    }
                    is SimpleApiResult.Loading -> {
                        // Already handled by _isLoading
                    }
                }
            } catch (e: Exception) {
                _error.value = "Failed to load invoices: ${e.message}"
            } finally {
                _isLoading.value = false
            }
        }
    }
    
    fun refresh() {
        loadInvoices()
    }
}

// Simple Tickets ViewModel
class SimpleTicketsViewModel(private val repository: SimpleRepository) : ViewModel() {
    
    private val _tickets = MutableStateFlow<List<TicketItem>>(emptyList())
    val tickets: StateFlow<List<TicketItem>> = _tickets
    
    private val _isLoading = MutableStateFlow(false)
    val isLoading: StateFlow<Boolean> = _isLoading
    
    private val _error = MutableStateFlow<String?>(null)
    val error: StateFlow<String?> = _error
    
    init {
        loadTickets()
    }
    
    private fun loadTickets() {
        viewModelScope.launch {
            _isLoading.value = true
            _error.value = null
            
            try {
                val result = repository.getTickets()
                when (result) {
                    is SimpleApiResult.Success -> {
                        _tickets.value = result.data
                    }
                    is SimpleApiResult.Error -> {
                        _error.value = result.message
                    }
                    is SimpleApiResult.Loading -> {
                        // Already handled by _isLoading
                    }
                }
            } catch (e: Exception) {
                _error.value = "Failed to load tickets: ${e.message}"
            } finally {
                _isLoading.value = false
            }
        }
    }
    
    fun refresh() {
        loadTickets()
    }
}