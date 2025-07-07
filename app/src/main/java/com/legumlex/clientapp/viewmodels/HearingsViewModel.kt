package com.legumlex.clientapp.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.legumlex.clientapp.models.Hearing
import com.legumlex.clientapp.services.LegalApiRepository
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch

class HearingsViewModel : ViewModel() {
    
    private val repository = LegalApiRepository.getInstance()
    
    private val _hearings = MutableStateFlow<List<Hearing>>(emptyList())
    val hearings: StateFlow<List<Hearing>> = _hearings
    
    private val _upcomingHearings = MutableStateFlow<List<Hearing>>(emptyList())
    val upcomingHearings: StateFlow<List<Hearing>> = _upcomingHearings
    
    private val _isLoading = MutableStateFlow(false)
    val isLoading: StateFlow<Boolean> = _isLoading
    
    private val _error = MutableStateFlow<String?>(null)
    val error: StateFlow<String?> = _error
    
    private val _showUpcomingOnly = MutableStateFlow(true)
    val showUpcomingOnly: StateFlow<Boolean> = _showUpcomingOnly
    
    init {
        loadHearings()
    }
    
    private fun loadHearings() {
        viewModelScope.launch {
            _isLoading.value = true
            _error.value = null
            
            try {
                // Load all hearings
                val allHearingsResult = repository.getHearings()
                allHearingsResult.fold(
                    onSuccess = { hearings ->
                        _hearings.value = hearings.sortedBy { it.hearingDate }
                    },
                    onFailure = { exception ->
                        _error.value = exception.message ?: "Failed to load hearings"
                    }
                )
                
                // Load upcoming hearings specifically
                val upcomingResult = repository.getUpcomingHearings()
                upcomingResult.fold(
                    onSuccess = { upcomingHearings ->
                        _upcomingHearings.value = upcomingHearings.sortedBy { it.hearingDate }
                    },
                    onFailure = { exception ->
                        // If specific upcoming endpoint fails, filter from all hearings
                        val allHearings = _hearings.value
                        _upcomingHearings.value = allHearings.filter { it.isUpcoming }
                            .sortedBy { it.hearingDate }
                    }
                )
            } catch (e: Exception) {
                _error.value = "Error loading hearings: ${e.message}"
            } finally {
                _isLoading.value = false
            }
        }
    }
    
    fun toggleUpcomingFilter() {
        _showUpcomingOnly.value = !_showUpcomingOnly.value
    }
    
    fun refresh() {
        loadHearings()
    }
}