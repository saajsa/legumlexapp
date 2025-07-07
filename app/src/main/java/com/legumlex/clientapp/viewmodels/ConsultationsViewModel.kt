package com.legumlex.clientapp.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.legumlex.clientapp.models.Consultation
import com.legumlex.clientapp.services.LegalApiRepository
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch

class ConsultationsViewModel : ViewModel() {
    
    private val repository = LegalApiRepository.getInstance()
    
    private val _consultations = MutableStateFlow<List<Consultation>>(emptyList())
    val consultations: StateFlow<List<Consultation>> = _consultations
    
    private val _isLoading = MutableStateFlow(false)
    val isLoading: StateFlow<Boolean> = _isLoading
    
    private val _error = MutableStateFlow<String?>(null)
    val error: StateFlow<String?> = _error
    
    init {
        loadConsultations()
    }
    
    private fun loadConsultations() {
        viewModelScope.launch {
            _isLoading.value = true
            _error.value = null
            
            try {
                val result = repository.getConsultations()
                result.fold(
                    onSuccess = { consultations ->
                        _consultations.value = consultations.sortedByDescending { 
                            it.createdDate ?: it.dateAdded 
                        }
                    },
                    onFailure = { exception ->
                        _error.value = exception.message ?: "Failed to load consultations"
                    }
                )
            } catch (e: Exception) {
                _error.value = "Error loading consultations: ${e.message}"
            } finally {
                _isLoading.value = false
            }
        }
    }
    
    fun refresh() {
        loadConsultations()
    }
}