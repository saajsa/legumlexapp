package com.legumlex.clientapp.services

import android.content.Context
import com.legumlex.clientapp.models.*
import retrofit2.Response
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import java.net.ConnectException
import java.net.SocketTimeoutException
import java.net.UnknownHostException

sealed class ApiResult<out T> {
    data class Success<out T>(val data: T) : ApiResult<T>()
    data class Error(val message: String, val code: Int? = null) : ApiResult<Nothing>()
    object Loading : ApiResult<Nothing>()
}

class Repository(
    private val apiService: ApiService,
    private val context: Context
) {
    
    // Generic method to handle API calls with proper error handling
    private suspend fun <T> safeApiCall(apiCall: suspend () -> Response<T>): ApiResult<T> {
        return try {
            val response = apiCall()
            if (response.isSuccessful) {
                response.body()?.let { body ->
                    ApiResult.Success(body)
                } ?: ApiResult.Error("Empty response body")
            } else {
                ApiResult.Error(
                    message = when (response.code()) {
                        401 -> "Unauthorized: Check your API token"
                        403 -> "Forbidden: Insufficient permissions"
                        404 -> "Not found: Resource doesn't exist"
                        500 -> "Server error: Please try again later"
                        else -> "HTTP ${response.code()}: ${response.message()}"
                    },
                    code = response.code()
                )
            }
        } catch (e: Exception) {
            ApiResult.Error(
                message = when (e) {
                    is ConnectException -> "Connection failed. Please check your internet connection."
                    is SocketTimeoutException -> "Request timed out. Please try again."
                    is UnknownHostException -> "Server not found. Please check your connection."
                    else -> e.message ?: "Unknown error occurred"
                }
            )
        }
    }
    
    // Customer methods
    suspend fun getCustomers(page: Int = 1, limit: Int = 20): ApiResult<List<User>> {
        return safeApiCall { apiService.getCustomers(page, limit) }
    }
    
    suspend fun getCustomer(customerId: String): ApiResult<User> {
        return safeApiCall { apiService.getCustomer(customerId) }
    }
    
    suspend fun updateCustomer(customerId: String, updates: Map<String, Any>): ApiResult<ApiResponse<User>> {
        return safeApiCall { apiService.updateCustomer(customerId, updates) }
    }
    
    // Project methods
    suspend fun getProjects(page: Int = 1, limit: Int = 20, customerId: String? = null): ApiResult<List<Project>> {
        return safeApiCall { apiService.getProjects(page, limit, customerId) }
    }
    
    suspend fun getProject(projectId: String): ApiResult<Project> {
        return safeApiCall { apiService.getProject(projectId) }
    }
    
    // Case methods (using projects as cases)
    suspend fun getCases(page: Int = 1, limit: Int = 20, customerId: String? = null): ApiResult<List<Case>> {
        return safeApiCall { apiService.getCases(page, limit, customerId) }
    }
    
    suspend fun getCase(caseId: String): ApiResult<Case> {
        return safeApiCall { apiService.getCase(caseId) }
    }
    
    // Invoice methods
    suspend fun getInvoices(page: Int = 1, limit: Int = 20, customerId: String? = null): ApiResult<List<Invoice>> {
        return safeApiCall { apiService.getInvoices(page, limit, customerId) }
    }
    
    suspend fun getInvoice(invoiceId: String): ApiResult<Invoice> {
        return safeApiCall { apiService.getInvoice(invoiceId) }
    }
    
    suspend fun getInvoicePdf(invoiceId: String): ApiResult<okhttp3.ResponseBody> {
        return safeApiCall { downloadService.getInvoicePdf(invoiceId) }
    }
    
    // Document methods
    suspend fun getDocuments(page: Int = 1, limit: Int = 20, relType: String? = null, relId: String? = null): ApiResult<List<Document>> {
        return safeApiCall { apiService.getDocuments(page, limit, relType, relId) }
    }
    
    suspend fun getDocument(documentId: String): ApiResult<Document> {
        return safeApiCall { apiService.getDocument(documentId) }
    }
    
    suspend fun downloadFile(fileId: String): ApiResult<okhttp3.ResponseBody> {
        return safeApiCall { downloadService.downloadFile(fileId) }
    }
    
    // Contract methods
    suspend fun getContracts(page: Int = 1, limit: Int = 20, customerId: String? = null): ApiResult<List<Contract>> {
        return safeApiCall { apiService.getContracts(page, limit, customerId) }
    }
    
    suspend fun getContract(contractId: String): ApiResult<Contract> {
        return safeApiCall { apiService.getContract(contractId) }
    }
    
    // Payment methods
    suspend fun getPayments(page: Int = 1, limit: Int = 20, customerId: String? = null, invoiceId: String? = null): ApiResult<List<Payment>> {
        return safeApiCall { apiService.getPayments(page, limit, customerId, invoiceId) }
    }
    
    suspend fun getPayment(paymentId: String): ApiResult<Payment> {
        return safeApiCall { apiService.getPayment(paymentId) }
    }
    
    // Ticket methods
    suspend fun getTickets(page: Int = 1, limit: Int = 20, customerId: String? = null): ApiResult<List<Ticket>> {
        return safeApiCall { apiService.getTickets(page, limit, customerId) }
    }
    
    suspend fun getTicket(ticketId: String): ApiResult<Ticket> {
        return safeApiCall { apiService.getTicket(ticketId) }
    }
    
    suspend fun createTicket(ticket: Map<String, Any>): ApiResult<Ticket> {
        return safeApiCall { apiService.createTicket(ticket) }
    }
    
    suspend fun updateTicket(ticketId: String, updates: Map<String, Any>): ApiResult<Ticket> {
        return safeApiCall { apiService.updateTicket(ticketId, updates) }
    }
    
    // Flow-based methods for reactive programming
    fun getCustomersFlow(page: Int = 1, limit: Int = 20): Flow<ApiResult<List<User>>> = flow {
        emit(ApiResult.Loading)
        emit(getCustomers(page, limit))
    }
    
    fun getInvoicesFlow(page: Int = 1, limit: Int = 20, customerId: String? = null): Flow<ApiResult<List<Invoice>>> = flow {
        emit(ApiResult.Loading)
        emit(getInvoices(page, limit, customerId))
    }
    
    fun getCasesFlow(page: Int = 1, limit: Int = 20, customerId: String? = null): Flow<ApiResult<List<Case>>> = flow {
        emit(ApiResult.Loading)
        emit(getCases(page, limit, customerId))
    }
    
    fun getDocumentsFlow(page: Int = 1, limit: Int = 20, relType: String? = null, relId: String? = null): Flow<ApiResult<List<Document>>> = flow {
        emit(ApiResult.Loading)
        emit(getDocuments(page, limit, relType, relId))
    }
    
    fun getContractsFlow(page: Int = 1, limit: Int = 20, customerId: String? = null): Flow<ApiResult<List<Contract>>> = flow {
        emit(ApiResult.Loading)
        emit(getContracts(page, limit, customerId))
    }
    
    fun getTicketsFlow(page: Int = 1, limit: Int = 20, customerId: String? = null): Flow<ApiResult<List<Ticket>>> = flow {
        emit(ApiResult.Loading)
        emit(getTickets(page, limit, customerId))
    }
    
    // Test connection
    suspend fun testConnection(): ApiResult<List<User>> {
        return safeApiCall { apiService.testConnection() }
    }
    
    // Legacy methods for backward compatibility
    @Deprecated("Use ApiResult-based methods instead")
    suspend fun getCustomersLegacy(page: Int = 1, limit: Int = 20): Response<List<User>> {
        return apiService.getCustomers(page, limit)
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