package com.legumlex.clientapp.services

import com.legumlex.clientapp.models.*
import retrofit2.Response
import retrofit2.http.*

interface PerfexApiService {
    
    // Perfex CRM API Endpoints (as per official API manual)
    // Authentication is done via authtoken header (configured in ApiClient)
    
    // Authentication verification endpoint
    @GET("customers/profile")
    suspend fun getCurrentCustomer(): Response<User>
    
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

// Simple response wrapper for API errors
data class ApiError(
    val message: String,
    val code: Int? = null
)