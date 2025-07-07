package com.legumlex.clientapp.services

import com.legumlex.clientapp.models.*
import retrofit2.Response
import retrofit2.http.*

interface LegalApiService {
    
    // Legal Practice Management API Endpoints
    // Authentication is done via authtoken header (configured in ApiClient)
    
    // Authentication verification endpoint
    @GET("customers/profile")
    suspend fun getCurrentCustomer(): Response<User>
    
    // Core Legal Practice Management endpoints
    @GET("cases")
    suspend fun getCases(): Response<List<Case>>
    
    @GET("consultations")
    suspend fun getConsultations(): Response<List<Consultation>>
    
    @GET("hearings")
    suspend fun getHearings(): Response<List<Hearing>>
    
    @GET("legal_documents")
    suspend fun getLegalDocuments(): Response<List<LegalDocument>>
    
    @GET("invoices")
    suspend fun getInvoices(): Response<List<Invoice>>
    
    @GET("tickets")
    suspend fun getTickets(): Response<List<Ticket>>
    
    // Detailed endpoints
    @GET("cases/{id}")
    suspend fun getCase(@Path("id") id: String): Response<Case>
    
    @GET("consultations/{id}")
    suspend fun getConsultation(@Path("id") id: String): Response<Consultation>
    
    @GET("hearings/{id}")
    suspend fun getHearing(@Path("id") id: String): Response<Hearing>
    
    @GET("legal_documents/{id}")
    suspend fun getLegalDocument(@Path("id") id: String): Response<LegalDocument>
    
    @GET("invoices/{id}")
    suspend fun getInvoice(@Path("id") id: String): Response<Invoice>
    
    @GET("tickets/{id}")
    suspend fun getTicket(@Path("id") id: String): Response<Ticket>
    
    // Search and filter endpoints
    @GET("cases/search")
    suspend fun searchCases(@Query("q") query: String): Response<List<Case>>
    
    @GET("consultations/search")
    suspend fun searchConsultations(@Query("q") query: String): Response<List<Consultation>>
    
    @GET("cases/client/{client_id}")
    suspend fun getCasesByClient(@Path("client_id") clientId: String): Response<List<Case>>
    
    @GET("hearings/case/{case_id}")
    suspend fun getHearingsByCase(@Path("case_id") caseId: String): Response<List<Hearing>>
    
    @GET("legal_documents/case/{case_id}")
    suspend fun getDocumentsByCase(@Path("case_id") caseId: String): Response<List<LegalDocument>>
    
    @GET("legal_documents/hearing/{hearing_id}")
    suspend fun getDocumentsByHearing(@Path("hearing_id") hearingId: String): Response<List<LegalDocument>>
    
    @GET("legal_documents/client/{client_id}")
    suspend fun getDocumentsByClient(@Path("client_id") clientId: String): Response<List<LegalDocument>>
    
    // Create endpoints
    @POST("consultations")
    suspend fun createConsultation(@Body consultation: Consultation): Response<Consultation>
    
    @POST("cases")
    suspend fun createCase(@Body case: Case): Response<Case>
    
    @POST("hearings")
    suspend fun createHearing(@Body hearing: Hearing): Response<Hearing>
    
    // Update endpoints
    @PUT("consultations/{id}")
    suspend fun updateConsultation(@Path("id") id: String, @Body consultation: Consultation): Response<Consultation>
    
    @PUT("cases/{id}")
    suspend fun updateCase(@Path("id") id: String, @Body case: Case): Response<Case>
    
    @PUT("hearings/{id}")
    suspend fun updateHearing(@Path("id") id: String, @Body hearing: Hearing): Response<Hearing>
    
    // Special endpoints
    @POST("consultations/{id}/upgrade")
    suspend fun upgradeConsultationToCase(@Path("id") id: String): Response<Case>
    
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
    
    // Files
    @GET("files")
    suspend fun getFiles(): Response<List<Document>>
    
    @GET("files/{id}")
    suspend fun getFile(@Path("id") id: String): Response<Document>
}

// Simple response wrapper for API errors
data class ApiError(
    val message: String,
    val code: Int? = null
)