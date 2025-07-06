package com.legumlex.clientapp.services

import com.legumlex.clientapp.models.*
import com.legumlex.clientapp.auth.LoginResponse
import com.legumlex.clientapp.auth.RefreshTokenResponse
import retrofit2.Response
import retrofit2.http.*

interface ApiService {
    
    // Authentication endpoints
    // Note: Perfex CRM uses API token authentication via headers
    // Login is typically handled through web interface, API uses token-based auth
    @POST("authenticate")
    suspend fun authenticate(
        @Body credentials: Map<String, String>
    ): Response<LoginResponse>
    
    @GET("me")
    suspend fun getCurrentUser(): Response<User>
    
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
    ): Response<List<Contract>>
    
    @GET("contracts/{id}")
    suspend fun getContract(
        @Path("id") contractId: String
    ): Response<Contract>
    
    // Case endpoints (Projects can be used as Cases in legal context)
    @GET("projects")
    suspend fun getCases(
        @Query("page") page: Int = 1,
        @Query("limit") limit: Int = 20,
        @Query("customer_id") customerId: String? = null
    ): Response<List<Case>>
    
    @GET("projects/{id}")
    suspend fun getCase(
        @Path("id") caseId: String
    ): Response<Case>
    
    // Document endpoints
    @GET("files")
    suspend fun getDocuments(
        @Query("page") page: Int = 1,
        @Query("limit") limit: Int = 20,
        @Query("rel_type") relType: String? = null,
        @Query("rel_id") relId: String? = null
    ): Response<List<Document>>
    
    @GET("files/{id}")
    suspend fun getDocument(
        @Path("id") documentId: String
    ): Response<Document>
    
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
        @Query("customer_id") customerId: String? = null,
        @Query("invoice_id") invoiceId: String? = null
    ): Response<List<Payment>>
    
    @GET("payments/{id}")
    suspend fun getPayment(
        @Path("id") paymentId: String
    ): Response<Payment>
    
    // File download
    @GET("files/{id}")
    suspend fun downloadFile(
        @Path("id") fileId: String
    ): Response<okhttp3.ResponseBody>
    
    // Test API connection
    @GET("customers")
    suspend fun testConnection(): Response<List<User>>
}