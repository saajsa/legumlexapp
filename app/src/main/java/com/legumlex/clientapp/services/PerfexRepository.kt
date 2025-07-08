package com.legumlex.clientapp.services

import com.legumlex.clientapp.models.*
import retrofit2.Response
import java.net.UnknownHostException
import java.net.SocketTimeoutException
import android.util.Log

class PerfexRepository(private val apiService: PerfexApiService) {
    
    suspend fun getCases(): ApiResult<List<Case>> {
        return safeApiCall { apiService.getCases() }
    }
    
    suspend fun getCase(id: String): ApiResult<Case> {
        return safeApiCall { apiService.getCase(id) }
    }
    
    suspend fun getCasesByClient(clientId: String): ApiResult<List<Case>> {
        return safeApiCall { apiService.getCasesByClient(clientId) }
    }
    
    suspend fun getInvoices(): ApiResult<List<Invoice>> {
        return safeApiCall { apiService.getInvoices() }
    }
    
    suspend fun getInvoice(id: String): ApiResult<Invoice> {
        return safeApiCall { apiService.getInvoice(id) }
    }
    
    suspend fun getDocuments(): ApiResult<List<Document>> {
        return safeApiCall { apiService.getDocuments() }
    }
    
    suspend fun getDocument(id: String): ApiResult<Document> {
        return safeApiCall { apiService.getDocument(id) }
    }
    
    suspend fun getDocumentsByCase(caseId: String): ApiResult<List<LegalDocument>> {
        return safeApiCall { apiService.getDocumentsByCase(caseId = caseId) }
    }
    
    private suspend fun <T> safeApiCall(apiCall: suspend () -> Response<T>): ApiResult<T> {
        return try {
            val response = apiCall()
            if (response.isSuccessful) {
                response.body()?.let { data ->
                    ApiResult.Success(data)
                } ?: ApiResult.Error(
                    Exception("Empty response body"),
                    "No data received from server"
                )
            } else {
                val errorMessage = when (response.code()) {
                    400 -> "Bad request - Please check your input"
                    401 -> "Unauthorized - Please check your authentication"
                    403 -> "Forbidden - You don't have permission to access this resource"
                    404 -> "Not found - The requested resource doesn't exist"
                    500 -> "Internal server error - Please try again later"
                    502 -> "Bad gateway - Server is temporarily unavailable"
                    503 -> "Service unavailable - Please try again later"
                    else -> "API error: ${response.code()} - ${response.message()}"
                }
                
                Log.e("PerfexRepository", "API Error: ${response.code()} - ${response.message()}")
                ApiResult.Error(
                    Exception("HTTP ${response.code()}"),
                    errorMessage
                )
            }
        } catch (e: UnknownHostException) {
            Log.e("PerfexRepository", "Network error: No internet connection", e)
            ApiResult.Error(e, "No internet connection. Please check your network.")
        } catch (e: SocketTimeoutException) {
            Log.e("PerfexRepository", "Network error: Request timeout", e)
            ApiResult.Error(e, "Request timeout. Please try again.")
        } catch (e: Exception) {
            Log.e("PerfexRepository", "Unexpected error", e)
            ApiResult.Error(e, "An unexpected error occurred: ${e.message}")
        }
    }
}