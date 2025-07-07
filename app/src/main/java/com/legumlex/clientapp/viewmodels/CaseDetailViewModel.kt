package com.legumlex.clientapp.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.legumlex.clientapp.models.Case
import com.legumlex.clientapp.models.Hearing
import com.legumlex.clientapp.models.LegalDocument
import com.legumlex.clientapp.services.LegalApiRepository
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch

class CaseDetailViewModel : ViewModel() {
    
    private val repository = LegalApiRepository.getInstance()
    
    private val _case = MutableStateFlow<Case?>(null)
    val case: StateFlow<Case?> = _case
    
    private val _hearings = MutableStateFlow<List<Hearing>>(emptyList())
    val hearings: StateFlow<List<Hearing>> = _hearings
    
    private val _documents = MutableStateFlow<List<LegalDocument>>(emptyList())
    val documents: StateFlow<List<LegalDocument>> = _documents
    
    private val _isLoading = MutableStateFlow(false)
    val isLoading: StateFlow<Boolean> = _isLoading
    
    private val _error = MutableStateFlow<String?>(null)
    val error: StateFlow<String?> = _error
    
    fun loadCaseDetails(caseId: String) {
        viewModelScope.launch {
            _isLoading.value = true
            _error.value = null
            
            try {
                // Load case details
                val caseResult = repository.getCase(caseId)
                caseResult.fold(
                    onSuccess = { case ->
                        _case.value = case
                        // Load related data
                        loadHearings(caseId)
                        loadDocuments(caseId)
                    },
                    onFailure = { exception ->
                        _error.value = exception.message ?: "Failed to load case details"
                    }
                )
            } catch (e: Exception) {
                _error.value = "Error loading case: ${e.message}"
            } finally {
                _isLoading.value = false
            }
        }
    }
    
    private suspend fun loadHearings(caseId: String) {
        try {
            val hearingsResult = repository.getHearingsByCase(caseId)
            hearingsResult.fold(
                onSuccess = { hearings ->
                    _hearings.value = hearings
                },
                onFailure = { exception ->
                    // Don't overwrite main error, just log
                    println("Failed to load hearings: ${exception.message}")
                }
            )
        } catch (e: Exception) {
            println("Error loading hearings: ${e.message}")
        }
    }
    
    private suspend fun loadDocuments(caseId: String) {
        try {
            val documentsResult = repository.getDocumentsByCase(caseId)
            documentsResult.fold(
                onSuccess = { documents ->
                    _documents.value = documents
                },
                onFailure = { exception ->
                    // Don't overwrite main error, just log
                    println("Failed to load documents: ${exception.message}")
                }
            )
        } catch (e: Exception) {
            println("Error loading documents: ${e.message}")
        }
    }
    
    fun refresh(caseId: String) {
        loadCaseDetails(caseId)
    }
}