package com.legumlex.clientapp.services

import android.content.Context
import android.util.Log
import com.legumlex.clientapp.models.*
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import kotlinx.coroutines.flow.first

/**
 * Repository for client-specific data fetching from Perfex CRM API
 * This repository correctly handles client authentication and fetches data
 * for the authenticated client only
 */
class ClientRepository(private val context: Context) {
    
    companion object {
        private const val TAG = "ClientRepository"
    }
    
    private val apiService = ApiClient.getInstance()
    private val tokenManager = TokenManager(context)
    
    /**
     * Get current authenticated client ID
     * This should return the client ID that matches the API authentication
     */
    private suspend fun getCurrentClientId(): String? {
        return try {
            // Get the authenticated client ID from token or preferences
            // This should match the client who owns the API token
            tokenManager.getUserId().first()
        } catch (e: Exception) {
            Log.e(TAG, "Failed to get client ID", e)
            null
        }
    }
    
    /**
     * Get dashboard statistics for the authenticated client
     */
    suspend fun getDashboardStats(): ApiResult<DashboardStats> = withContext(Dispatchers.IO) {
        try {
            Log.d(TAG, "Fetching dashboard stats...")
            
            val clientId = getCurrentClientId()
            if (clientId == null) {
                Log.e(TAG, "No authenticated client ID")
                return@withContext ApiResult.Error(
                    Exception("Authentication required"),
                    "Please log in to view dashboard"
                )
            }
            
            Log.d(TAG, "Fetching stats for client: $clientId")
            
            // Fetch invoices for the client - this is the most reliable endpoint
            val invoicesResponse = apiService.getInvoices()
            
            if (invoicesResponse.isSuccessful) {
                val invoices = invoicesResponse.body() ?: emptyList()
                Log.d(TAG, "Fetched ${invoices.size} invoices")
                
                // Calculate statistics from invoice data
                val unpaidInvoices = invoices.count { !it.isPaid }
                val totalInvoices = invoices.size
                
                val stats = DashboardStats(
                    activeCases = 0, // Will implement when cases API is working
                    unpaidInvoices = unpaidInvoices,
                    totalDocuments = 0, // Will implement when documents API is working
                    openTickets = 0, // Will implement when tickets API is working
                    totalInvoices = totalInvoices
                )
                
                Log.d(TAG, "Dashboard stats: $stats")
                ApiResult.Success(stats)
            } else {
                val error = "Failed to fetch invoices: ${invoicesResponse.code()} ${invoicesResponse.message()}"
                Log.e(TAG, error)
                ApiResult.Error(
                    Exception("API Error ${invoicesResponse.code()}"),
                    error
                )
            }
            
        } catch (e: Exception) {
            Log.e(TAG, "Error fetching dashboard stats", e)
            ApiResult.Error(e, "Failed to load dashboard: ${e.message}")
        }
    }
    
    /**
     * Get all invoices for the authenticated client
     */
    suspend fun getInvoices(): ApiResult<List<Invoice>> = withContext(Dispatchers.IO) {
        try {
            Log.d(TAG, "Fetching invoices...")
            
            val clientId = getCurrentClientId()
            if (clientId == null) {
                Log.e(TAG, "No authenticated client ID")
                return@withContext ApiResult.Error(
                    Exception("Authentication required"),
                    "Please log in to view invoices"
                )
            }
            
            val response = apiService.getInvoices()
            
            if (response.isSuccessful) {
                val invoices = response.body() ?: emptyList()
                Log.d(TAG, "Fetched ${invoices.size} invoices for client")
                ApiResult.Success(invoices)
            } else {
                val error = "Failed to fetch invoices: ${response.code()} ${response.message()}"
                Log.e(TAG, error)
                ApiResult.Error(
                    Exception("API Error ${response.code()}"),
                    error
                )
            }
            
        } catch (e: Exception) {
            Log.e(TAG, "Error fetching invoices", e)
            ApiResult.Error(e, "Failed to load invoices: ${e.message}")
        }
    }
    
    /**
     * Get current user profile
     */
    suspend fun getCurrentUser(): ApiResult<User> = withContext(Dispatchers.IO) {
        try {
            Log.d(TAG, "Fetching current user profile...")
            
            val response = apiService.getCurrentCustomer()
            
            if (response.isSuccessful && response.body() != null) {
                val user = response.body()!!
                Log.d(TAG, "Fetched user profile: ${user.id}")
                ApiResult.Success(user)
            } else {
                val error = "Failed to fetch user profile: ${response.code()} ${response.message()}"
                Log.e(TAG, error)
                ApiResult.Error(
                    Exception("API Error ${response.code()}"),
                    error
                )
            }
            
        } catch (e: Exception) {
            Log.e(TAG, "Error fetching user profile", e)
            ApiResult.Error(e, "Failed to load profile: ${e.message}")
        }
    }
}

/**
 * Dashboard statistics data class
 */
data class DashboardStats(
    val activeCases: Int = 0,
    val unpaidInvoices: Int = 0,
    val totalDocuments: Int = 0,
    val openTickets: Int = 0,
    val totalInvoices: Int = 0
)