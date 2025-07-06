package com.legumlex.clientapp.viewmodels

import androidx.lifecycle.viewModelScope
import com.legumlex.clientapp.models.Case
import com.legumlex.clientapp.models.Document
import com.legumlex.clientapp.services.ApiResult
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

data class CaseUiState(
    val cases: List<Case> = emptyList(),
    val selectedCase: Case? = null,
    val caseDocuments: List<Document> = emptyList(),
    val isLoadingCases: Boolean = false,
    val isLoadingCaseDetails: Boolean = false,
    val isLoadingDocuments: Boolean = false,
    val searchQuery: String = "",
    val filteredCases: List<Case> = emptyList(),
    val selectedFilter: CaseFilter = CaseFilter.ALL
)

enum class CaseFilter {
    ALL, ACTIVE, CLOSED, HIGH_PRIORITY
}

class CaseViewModel : BaseViewModel() {
    
    private val _uiState = MutableStateFlow(CaseUiState())
    val uiState: StateFlow<CaseUiState> = _uiState.asStateFlow()
    
    init {
        loadCases()
    }
    
    fun loadCases() {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isLoadingCases = true)
            
            when (val result = repository.getCases()) {
                is ApiResult.Success -> {
                    _uiState.value = _uiState.value.copy(
                        cases = result.data,
                        filteredCases = filterCases(result.data, _uiState.value.selectedFilter, _uiState.value.searchQuery),
                        isLoadingCases = false
                    )
                }
                is ApiResult.Error -> {
                    _uiState.value = _uiState.value.copy(isLoadingCases = false)
                    setError("Failed to load cases: ${result.message}")
                }
                is ApiResult.Loading -> {
                    _uiState.value = _uiState.value.copy(isLoadingCases = true)
                }
            }
        }
    }
    
    fun loadCaseDetails(caseId: String) {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isLoadingCaseDetails = true)
            
            when (val result = repository.getCase(caseId)) {
                is ApiResult.Success -> {
                    _uiState.value = _uiState.value.copy(
                        selectedCase = result.data,
                        isLoadingCaseDetails = false
                    )
                    // Load case documents
                    loadCaseDocuments(caseId)
                }
                is ApiResult.Error -> {
                    _uiState.value = _uiState.value.copy(isLoadingCaseDetails = false)
                    setError("Failed to load case details: ${result.message}")
                }
                is ApiResult.Loading -> {
                    _uiState.value = _uiState.value.copy(isLoadingCaseDetails = true)
                }
            }
        }
    }
    
    private fun loadCaseDocuments(caseId: String) {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isLoadingDocuments = true)
            
            when (val result = repository.getDocuments(relType = "case", relId = caseId)) {
                is ApiResult.Success -> {
                    _uiState.value = _uiState.value.copy(
                        caseDocuments = result.data,
                        isLoadingDocuments = false
                    )
                }
                is ApiResult.Error -> {
                    _uiState.value = _uiState.value.copy(isLoadingDocuments = false)
                    setError("Failed to load case documents: ${result.message}")
                }
                is ApiResult.Loading -> {
                    _uiState.value = _uiState.value.copy(isLoadingDocuments = true)
                }
            }
        }
    }
    
    fun searchCases(query: String) {
        _uiState.value = _uiState.value.copy(
            searchQuery = query,
            filteredCases = filterCases(_uiState.value.cases, _uiState.value.selectedFilter, query)
        )
    }
    
    fun filterCases(filter: CaseFilter) {
        _uiState.value = _uiState.value.copy(
            selectedFilter = filter,
            filteredCases = filterCases(_uiState.value.cases, filter, _uiState.value.searchQuery)
        )
    }
    
    private fun filterCases(cases: List<Case>, filter: CaseFilter, searchQuery: String): List<Case> {
        var filteredCases = when (filter) {
            CaseFilter.ALL -> cases
            CaseFilter.ACTIVE -> cases.filter { it.isActive }
            CaseFilter.CLOSED -> cases.filter { it.isClosed }
            CaseFilter.HIGH_PRIORITY -> cases.filter { it.priority == "3" || it.priority == "4" }
        }
        
        if (searchQuery.isNotBlank()) {
            filteredCases = filteredCases.filter { case ->
                case.name.contains(searchQuery, ignoreCase = true) ||
                case.description?.contains(searchQuery, ignoreCase = true) == true ||
                case.caseNumber?.contains(searchQuery, ignoreCase = true) == true ||
                case.opposingParty?.contains(searchQuery, ignoreCase = true) == true
            }
        }
        
        return filteredCases.sortedByDescending { it.createdDate }
    }
    
    fun selectCase(case: Case) {
        _uiState.value = _uiState.value.copy(selectedCase = case)
        loadCaseDocuments(case.id)
    }
    
    fun clearSelectedCase() {
        _uiState.value = _uiState.value.copy(
            selectedCase = null,
            caseDocuments = emptyList()
        )
    }
    
    fun refreshCases() {
        loadCases()
    }
    
    fun clearError() {
        super.clearError()
    }
}