package com.legumlex.clientapp.services

import com.legumlex.clientapp.models.*
import retrofit2.Response
import retrofit2.http.*

interface PerfexApiService {
    
    // Perfex CRM API Endpoints (as per official API manual)
    // Authentication is done via authtoken header (configured in ApiClient)
    
    // Core Perfex CRM endpoints
    @GET("customers")
    suspend fun getCustomers(): Response<List<User>>
    
    @GET("projects")
    suspend fun getProjects(): Response<List<Project>>
    
    @GET("invoices")
    suspend fun getInvoices(): Response<List<Invoice>>
    
    @GET("tickets")
    suspend fun getTickets(): Response<List<Ticket>>
    
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

// Backend API Request/Response Models
data class LoginRequest(
    val email: String,
    val password: String
)

data class AuthResponse(
    val success: Boolean,
    val message: String,
    val token: String? = null,
    val client: ClientInfo? = null
)

data class ClientInfo(
    val id: String,
    val name: String,
    val email: String
)

data class ApiResponse(
    val success: Boolean,
    val message: String
)

data class DashboardStatsResponse(
    val success: Boolean,
    val data: DashboardStatsData? = null,
    val message: String? = null
)

data class DashboardStatsData(
    val activeCases: Int,
    val unpaidInvoices: Int,
    val totalDocuments: Int,
    val openTickets: Int
)

data class ProjectsResponse(
    val success: Boolean,
    val data: List<Project>? = null,
    val message: String? = null
)

data class InvoicesResponse(
    val success: Boolean,
    val data: List<Invoice>? = null,
    val message: String? = null
)

data class TicketsResponse(
    val success: Boolean,
    val data: List<Ticket>? = null,
    val message: String? = null
)