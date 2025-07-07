package com.legumlex.clientapp.services

import com.legumlex.clientapp.models.*
import retrofit2.Response
import retrofit2.http.*

interface PerfexApiService {
    
    // Perfex CRM doesn't have a separate auth endpoint - authentication is done via API token in headers
    // The API token should be obtained from Perfex CRM admin panel: Setup > API > API Management
    
    // Get current customer/client info (acts as auth verification)
    @GET("customers/profile")
    suspend fun getCurrentCustomer(): Response<User>
    
    // Dashboard Statistics - Real Perfex CRM endpoints
    @GET("customers")
    suspend fun getCustomers(): Response<ApiListResponse<User>>
    
    @GET("projects")
    suspend fun getProjects(): Response<ApiListResponse<Project>>
    
    @GET("invoices")
    suspend fun getInvoices(): Response<ApiListResponse<Invoice>>
    
    @GET("tickets")
    suspend fun getTickets(): Response<ApiListResponse<Ticket>>
    
    // Detailed endpoints
    @GET("customers/{id}")
    suspend fun getCustomer(@Path("id") id: String): Response<User>
    
    @GET("projects/{id}")
    suspend fun getProject(@Path("id") id: String): Response<Project>
    
    @GET("invoices/{id}")
    suspend fun getInvoice(@Path("id") id: String): Response<Invoice>
    
    @GET("tickets/{id}")
    suspend fun getTicket(@Path("id") id: String): Response<Ticket>
    
    // Documents/Files
    @GET("files")
    suspend fun getDocuments(): Response<List<Document>>
    
    @GET("files/{id}")
    suspend fun getDocument(@Path("id") id: String): Response<Document>
    
    // Contracts
    @GET("contracts")
    suspend fun getContracts(): Response<List<Contract>>
    
    @GET("contracts/{id}")
    suspend fun getContract(@Path("id") id: String): Response<Contract>
    
    // Payments
    @GET("payments")
    suspend fun getPayments(): Response<List<Payment>>
    
    @GET("payments/{id}")
    suspend fun getPayment(@Path("id") id: String): Response<Payment>
}

// Perfex CRM API Response wrapper
data class ApiListResponse<T>(
    val data: List<T>? = null,
    val success: Boolean = false,
    val message: String? = null,
    val total: Int? = null
)

data class ApiSingleResponse<T>(
    val data: T? = null,
    val success: Boolean = false,
    val message: String? = null
)

data class ApiError(
    val message: String,
    val success: Boolean = false,
    val code: Int? = null
)