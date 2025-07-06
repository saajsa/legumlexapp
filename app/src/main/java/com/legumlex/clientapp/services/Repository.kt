package com.legumlex.clientapp.services

import com.legumlex.clientapp.models.*
import retrofit2.Response

class Repository {
    
    private val apiService = ApiClient.apiService
    private val downloadService = ApiClient.downloadService
    
    // Customer operations
    suspend fun getCustomers(page: Int = 1, limit: Int = 20): Response<List<User>> {
        return apiService.getCustomers(page, limit)
    }
    
    suspend fun getCustomer(customerId: String): Response<User> {
        return apiService.getCustomer(customerId)
    }
    
    suspend fun updateCustomer(customerId: String, updates: Map<String, Any>): Response<ApiResponse<User>> {
        return apiService.updateCustomer(customerId, updates)
    }
    
    // Project operations
    suspend fun getProjects(page: Int = 1, limit: Int = 20, customerId: String? = null): Response<List<Project>> {
        return apiService.getProjects(page, limit, customerId)
    }
    
    suspend fun getProject(projectId: String): Response<Project> {
        return apiService.getProject(projectId)
    }
    
    // Invoice operations
    suspend fun getInvoices(page: Int = 1, limit: Int = 20, customerId: String? = null): Response<List<Invoice>> {
        return apiService.getInvoices(page, limit, customerId)
    }
    
    suspend fun getInvoice(invoiceId: String): Response<Invoice> {
        return apiService.getInvoice(invoiceId)
    }
    
    suspend fun getInvoicePdf(invoiceId: String): Response<okhttp3.ResponseBody> {
        return downloadService.getInvoicePdf(invoiceId)
    }
    
    // Ticket operations
    suspend fun getTickets(page: Int = 1, limit: Int = 20, customerId: String? = null): Response<List<Ticket>> {
        return apiService.getTickets(page, limit, customerId)
    }
    
    suspend fun getTicket(ticketId: String): Response<Ticket> {
        return apiService.getTicket(ticketId)
    }
    
    suspend fun createTicket(ticket: Map<String, Any>): Response<Ticket> {
        return apiService.createTicket(ticket)
    }
    
    suspend fun updateTicket(ticketId: String, updates: Map<String, Any>): Response<Ticket> {
        return apiService.updateTicket(ticketId, updates)
    }
    
    // Contract operations
    suspend fun getContracts(page: Int = 1, limit: Int = 20, customerId: String? = null): Response<List<Any>> {
        return apiService.getContracts(page, limit, customerId)
    }
    
    // Proposal operations
    suspend fun getProposals(page: Int = 1, limit: Int = 20, customerId: String? = null): Response<List<Any>> {
        return apiService.getProposals(page, limit, customerId)
    }
    
    // Estimate operations
    suspend fun getEstimates(page: Int = 1, limit: Int = 20, customerId: String? = null): Response<List<Any>> {
        return apiService.getEstimates(page, limit, customerId)
    }
    
    // Payment operations
    suspend fun getPayments(page: Int = 1, limit: Int = 20, customerId: String? = null): Response<List<Any>> {
        return apiService.getPayments(page, limit, customerId)
    }
    
    // File operations
    suspend fun downloadFile(fileId: String): Response<okhttp3.ResponseBody> {
        return downloadService.downloadFile(fileId)
    }
    
    // Test API connection
    suspend fun testConnection(): Response<List<User>> {
        return apiService.testConnection()
    }
    
    // Utility methods for error handling
    fun <T> handleApiResponse(response: Response<T>): Result<T> {
        return if (response.isSuccessful && response.body() != null) {
            Result.success(response.body()!!)
        } else {
            val errorMessage = when (response.code()) {
                401 -> "Unauthorized: Check your API token"
                403 -> "Forbidden: Insufficient permissions"
                404 -> "Not found: Resource doesn't exist"
                500 -> "Server error: Please try again later"
                else -> "API Error: ${response.code()} - ${response.message()}"
            }
            Result.failure(Exception(errorMessage))
        }
    }
    
    companion object {
        @Volatile
        private var INSTANCE: Repository? = null
        
        fun getInstance(): Repository {
            return INSTANCE ?: synchronized(this) {
                INSTANCE ?: Repository().also { INSTANCE = it }
            }
        }
    }
}