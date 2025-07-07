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
    
    // Legal Practice Management API Endpoints (Extended)
    // These endpoints integrate with the new Legal Practice Management API
    
    // Cases API (maps to projects in Perfex CRM)
    @GET("cases")
    suspend fun getCases(): Response<List<Case>>
    
    @GET("cases/{id}")
    suspend fun getCase(@Path("id") id: String): Response<Case>
    
    @GET("cases/client/{client_id}")
    suspend fun getCasesByClient(@Path("client_id") clientId: String): Response<List<Case>>
    
    @GET("cases/search")
    suspend fun searchCases(@Query("q") query: String): Response<List<Case>>
    
    // Consultations API
    @GET("consultations")
    suspend fun getConsultations(): Response<List<Consultation>>
    
    @GET("consultations/{id}")
    suspend fun getConsultation(@Path("id") id: String): Response<Consultation>
    
    @POST("consultations")
    suspend fun createConsultation(@Body consultation: Consultation): Response<Consultation>
    
    @PUT("consultations/{id}")
    suspend fun updateConsultation(@Path("id") id: String, @Body consultation: Consultation): Response<Consultation>
    
    @POST("consultations/{id}/upgrade")
    suspend fun upgradeConsultationToCase(@Path("id") id: String): Response<Case>
    
    // Hearings API
    @GET("hearings")
    suspend fun getHearings(): Response<List<Hearing>>
    
    @GET("hearings/{id}")
    suspend fun getHearing(@Path("id") id: String): Response<Hearing>
    
    @GET("hearings/case/{case_id}")
    suspend fun getHearingsByCase(@Path("case_id") caseId: String): Response<List<Hearing>>
    
    @GET("hearings/upcoming")
    suspend fun getUpcomingHearings(): Response<List<Hearing>>
    
    @GET("hearings/today")
    suspend fun getTodaysHearings(): Response<List<Hearing>>
    
    // Legal Documents API
    @GET("legal_documents")
    suspend fun getLegalDocuments(): Response<List<LegalDocument>>
    
    @GET("legal_documents/{id}")
    suspend fun getLegalDocument(@Path("id") id: String): Response<LegalDocument>
    
    @GET("legal_documents/case/{case_id}")
    suspend fun getDocumentsByCase(@Path("case_id") caseId: String): Response<List<LegalDocument>>
    
    @GET("legal_documents/hearing/{hearing_id}")
    suspend fun getDocumentsByHearing(@Path("hearing_id") hearingId: String): Response<List<LegalDocument>>
    
    @GET("legal_documents/client/{client_id}")
    suspend fun getDocumentsByClient(@Path("client_id") clientId: String): Response<List<LegalDocument>>
    
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