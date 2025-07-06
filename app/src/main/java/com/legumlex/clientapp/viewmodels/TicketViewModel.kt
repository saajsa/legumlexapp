package com.legumlex.clientapp.viewmodels

import androidx.lifecycle.viewModelScope
import com.legumlex.clientapp.models.Ticket
import com.legumlex.clientapp.services.ApiResult
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

data class TicketUiState(
    val tickets: List<Ticket> = emptyList(),
    val selectedTicket: Ticket? = null,
    val isLoadingTickets: Boolean = false,
    val isLoadingTicketDetails: Boolean = false,
    val isCreatingTicket: Boolean = false,
    val isUpdatingTicket: Boolean = false,
    val searchQuery: String = "",
    val filteredTickets: List<Ticket> = emptyList(),
    val selectedFilter: TicketFilter = TicketFilter.ALL,
    val selectedPriorityFilter: TicketPriorityFilter = TicketPriorityFilter.ALL
)

enum class TicketFilter {
    ALL, OPEN, IN_PROGRESS, ANSWERED, ON_HOLD, CLOSED
}

enum class TicketPriorityFilter {
    ALL, LOW, MEDIUM, HIGH, URGENT
}

class TicketViewModel : BaseViewModel() {
    
    private val _uiState = MutableStateFlow(TicketUiState())
    val uiState: StateFlow<TicketUiState> = _uiState.asStateFlow()
    
    init {
        loadTickets()
    }
    
    fun loadTickets() {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isLoadingTickets = true)
            
            when (val result = repository.getTickets()) {
                is ApiResult.Success -> {
                    _uiState.value = _uiState.value.copy(
                        tickets = result.data,
                        filteredTickets = filterTickets(
                            result.data, 
                            _uiState.value.selectedFilter, 
                            _uiState.value.selectedPriorityFilter,
                            _uiState.value.searchQuery
                        ),
                        isLoadingTickets = false
                    )
                }
                is ApiResult.Error -> {
                    _uiState.value = _uiState.value.copy(isLoadingTickets = false)
                    setError("Failed to load tickets: ${result.message}")
                }
                is ApiResult.Loading -> {
                    _uiState.value = _uiState.value.copy(isLoadingTickets = true)
                }
            }
        }
    }
    
    fun loadTicketDetails(ticketId: String) {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isLoadingTicketDetails = true)
            
            when (val result = repository.getTicket(ticketId)) {
                is ApiResult.Success -> {
                    _uiState.value = _uiState.value.copy(
                        selectedTicket = result.data,
                        isLoadingTicketDetails = false
                    )
                }
                is ApiResult.Error -> {
                    _uiState.value = _uiState.value.copy(isLoadingTicketDetails = false)
                    setError("Failed to load ticket details: ${result.message}")
                }
                is ApiResult.Loading -> {
                    _uiState.value = _uiState.value.copy(isLoadingTicketDetails = true)
                }
            }
        }
    }
    
    fun createTicket(ticketData: Map<String, Any>) {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isCreatingTicket = true)
            
            when (val result = repository.createTicket(ticketData)) {
                is ApiResult.Success -> {
                    _uiState.value = _uiState.value.copy(isCreatingTicket = false)
                    // Refresh tickets to include the new one
                    loadTickets()
                }
                is ApiResult.Error -> {
                    _uiState.value = _uiState.value.copy(isCreatingTicket = false)
                    setError("Failed to create ticket: ${result.message}")
                }
                is ApiResult.Loading -> {
                    _uiState.value = _uiState.value.copy(isCreatingTicket = true)
                }
            }
        }
    }
    
    fun updateTicket(ticketId: String, updates: Map<String, Any>) {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isUpdatingTicket = true)
            
            when (val result = repository.updateTicket(ticketId, updates)) {
                is ApiResult.Success -> {
                    _uiState.value = _uiState.value.copy(isUpdatingTicket = false)
                    // Refresh tickets to show the updated ticket
                    loadTickets()
                    // Update selected ticket if it's the one being updated
                    if (_uiState.value.selectedTicket?.id == ticketId) {
                        loadTicketDetails(ticketId)
                    }
                }
                is ApiResult.Error -> {
                    _uiState.value = _uiState.value.copy(isUpdatingTicket = false)
                    setError("Failed to update ticket: ${result.message}")
                }
                is ApiResult.Loading -> {
                    _uiState.value = _uiState.value.copy(isUpdatingTicket = true)
                }
            }
        }
    }
    
    fun searchTickets(query: String) {
        _uiState.value = _uiState.value.copy(
            searchQuery = query,
            filteredTickets = filterTickets(
                _uiState.value.tickets, 
                _uiState.value.selectedFilter, 
                _uiState.value.selectedPriorityFilter,
                query
            )
        )
    }
    
    fun filterTickets(filter: TicketFilter) {
        _uiState.value = _uiState.value.copy(
            selectedFilter = filter,
            filteredTickets = filterTickets(
                _uiState.value.tickets, 
                filter, 
                _uiState.value.selectedPriorityFilter,
                _uiState.value.searchQuery
            )
        )
    }
    
    fun filterTicketsByPriority(priorityFilter: TicketPriorityFilter) {
        _uiState.value = _uiState.value.copy(
            selectedPriorityFilter = priorityFilter,
            filteredTickets = filterTickets(
                _uiState.value.tickets, 
                _uiState.value.selectedFilter, 
                priorityFilter,
                _uiState.value.searchQuery
            )
        )
    }
    
    private fun filterTickets(
        tickets: List<Ticket>, 
        filter: TicketFilter, 
        priorityFilter: TicketPriorityFilter,
        searchQuery: String
    ): List<Ticket> {
        var filteredTickets = when (filter) {
            TicketFilter.ALL -> tickets
            TicketFilter.OPEN -> tickets.filter { it.status == "1" }
            TicketFilter.IN_PROGRESS -> tickets.filter { it.status == "2" }
            TicketFilter.ANSWERED -> tickets.filter { it.status == "3" }
            TicketFilter.ON_HOLD -> tickets.filter { it.status == "4" }
            TicketFilter.CLOSED -> tickets.filter { it.status == "5" }
        }
        
        filteredTickets = when (priorityFilter) {
            TicketPriorityFilter.ALL -> filteredTickets
            TicketPriorityFilter.LOW -> filteredTickets.filter { it.priority == "1" }
            TicketPriorityFilter.MEDIUM -> filteredTickets.filter { it.priority == "2" }
            TicketPriorityFilter.HIGH -> filteredTickets.filter { it.priority == "3" }
            TicketPriorityFilter.URGENT -> filteredTickets.filter { it.priority == "4" }
        }
        
        if (searchQuery.isNotBlank()) {
            filteredTickets = filteredTickets.filter { ticket ->
                ticket.subject.contains(searchQuery, ignoreCase = true) ||
                ticket.message?.contains(searchQuery, ignoreCase = true) == true ||
                ticket.ticketKey.contains(searchQuery, ignoreCase = true)
            }
        }
        
        return filteredTickets.sortedByDescending { it.date }
    }
    
    fun selectTicket(ticket: Ticket) {
        _uiState.value = _uiState.value.copy(selectedTicket = ticket)
    }
    
    fun clearSelectedTicket() {
        _uiState.value = _uiState.value.copy(selectedTicket = null)
    }
    
    fun refreshTickets() {
        loadTickets()
    }
    
    override fun clearError() {
        super.clearError()
    }
}