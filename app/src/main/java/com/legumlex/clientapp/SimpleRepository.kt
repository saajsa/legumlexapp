package com.legumlex.clientapp

sealed class SimpleApiResult<out T> {
    data class Success<out T>(val data: T) : SimpleApiResult<T>()
    data class Error(val message: String) : SimpleApiResult<Nothing>()
    object Loading : SimpleApiResult<Nothing>()
}

class SimpleRepository {
    
    // Mock data for dashboard
    suspend fun getDashboardStats(): SimpleApiResult<DashboardStats> {
        return SimpleApiResult.Success(
            DashboardStats(
                activeCases = 3,
                unpaidInvoices = 2,
                totalDocuments = 15,
                openTickets = 1
            )
        )
    }
}

data class DashboardStats(
    val activeCases: Int = 0,
    val unpaidInvoices: Int = 0,
    val totalDocuments: Int = 0,
    val openTickets: Int = 0
)