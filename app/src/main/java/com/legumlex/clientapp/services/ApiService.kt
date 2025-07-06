package com.legumlex.clientapp.services

import com.legumlex.clientapp.models.*
import retrofit2.Response
import retrofit2.http.*

interface ApiService {
    
    // Customer endpoints - Perfex CRM uses 'customers' for client data
    @GET("customers")
    suspend fun getCustomers(
        @Query("page") page: Int = 1,
        @Query("limit") limit: Int = 20
    ): Response<List<User>>
    
    @GET("customers/{id}")
    suspend fun getCustomer(
        @Path("id") customerId: String
    ): Response<User>
    
    @PUT("customers/{id}")
    suspend fun updateCustomer(
        @Path("id") customerId: String,
        @Body user: Map<String, Any>
    ): Response<ApiResponse<User>>
    
    // Project endpoints
    @GET("projects")
    suspend fun getProjects(
        @Query("page") page: Int = 1,
        @Query("limit") limit: Int = 20,
        @Query("customer_id") customerId: String? = null
    ): Response<List<Project>>
    
    @GET("projects/{id}")
    suspend fun getProject(
        @Path("id") projectId: String
    ): Response<Project>
    
    // Invoice endpoints
    @GET("invoices")
    suspend fun getInvoices(
        @Query("page") page: Int = 1,
        @Query("limit") limit: Int = 20,
        @Query("customer_id") customerId: String? = null
    ): Response<List<Invoice>>
    
    @GET("invoices/{id}")
    suspend fun getInvoice(
        @Path("id") invoiceId: String
    ): Response<Invoice>
    
    @GET("invoices/{id}/pdf")
    suspend fun getInvoicePdf(
        @Path("id") invoiceId: String
    ): Response<okhttp3.ResponseBody>
    
    // Ticket endpoints
    @GET("tickets")
    suspend fun getTickets(
        @Query("page") page: Int = 1,
        @Query("limit") limit: Int = 20,
        @Query("customer_id") customerId: String? = null
    ): Response<List<Ticket>>
    
    @GET("tickets/{id}")
    suspend fun getTicket(
        @Path("id") ticketId: String
    ): Response<Ticket>
    
    @POST("tickets")
    suspend fun createTicket(
        @Body ticket: Map<String, Any>
    ): Response<Ticket>
    
    @PUT("tickets/{id}")
    suspend fun updateTicket(
        @Path("id") ticketId: String,
        @Body updates: Map<String, Any>
    ): Response<Ticket>
    
    // Contract endpoints
    @GET("contracts")
    suspend fun getContracts(
        @Query("page") page: Int = 1,
        @Query("limit") limit: Int = 20,
        @Query("customer_id") customerId: String? = null
    ): Response<List<Any>>
    
    // Proposal endpoints
    @GET("proposals")
    suspend fun getProposals(
        @Query("page") page: Int = 1,
        @Query("limit") limit: Int = 20,
        @Query("customer_id") customerId: String? = null
    ): Response<List<Any>>
    
    // Estimate endpoints
    @GET("estimates")
    suspend fun getEstimates(
        @Query("page") page: Int = 1,
        @Query("limit") limit: Int = 20,
        @Query("customer_id") customerId: String? = null
    ): Response<List<Any>>
    
    // Payment endpoints
    @GET("payments")
    suspend fun getPayments(
        @Query("page") page: Int = 1,
        @Query("limit") limit: Int = 20,
        @Query("customer_id") customerId: String? = null
    ): Response<List<Any>>
    
    // File download
    @GET("files/{id}")
    suspend fun downloadFile(
        @Path("id") fileId: String
    ): Response<okhttp3.ResponseBody>
    
    // Test API connection
    @GET("customers")
    suspend fun testConnection(): Response<List<User>>
}