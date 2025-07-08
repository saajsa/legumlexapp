package com.legumlex.clientapp.services

import com.legumlex.clientapp.models.*
import retrofit2.Response
import retrofit2.http.*

interface PerfexApiService {
    
    // Perfex CRM Customer API Endpoints (based on official customer API documentation)
    // Authentication is done via Authorization header
    
    // Authentication endpoints
    @POST("authentication")
    suspend fun login(@Body loginRequest: LoginRequest): Response<LoginResponse>
    
    @POST("logout")
    suspend fun logout(): Response<LogoutResponse>
    
    @POST("register")
    suspend fun register(@Body registerRequest: RegisterRequest): Response<RegisterResponse>
    
    // Customer invoices - automatically filtered for authenticated customer
    @GET("invoices")
    suspend fun getInvoices(): Response<CustomerApiResponse<List<Invoice>>>
    
    @GET("invoices/id/{id}")
    suspend fun getInvoice(@Path("id") id: String): Response<CustomerApiResponse<Invoice>>
    
    // Customer projects - automatically filtered for authenticated customer
    @GET("projects")
    suspend fun getProjects(): Response<CustomerApiResponse<List<Project>>>
    
    @GET("projects/id/{id}")
    suspend fun getProject(@Path("id") id: String): Response<CustomerApiResponse<Project>>
    
    @GET("projects/id/{id}/group/{groupname}")
    suspend fun getProjectGroup(
        @Path("id") id: String, 
        @Path("groupname") groupName: String
    ): Response<CustomerApiResponse<List<ProjectGroup>>>
    
    // Customer tickets - automatically filtered for authenticated customer
    @GET("tickets")
    suspend fun getTickets(): Response<CustomerApiResponse<List<Ticket>>>
    
    @GET("tickets/id/{id}")
    suspend fun getTicket(@Path("id") id: String): Response<CustomerApiResponse<Ticket>>
    
    @POST("tickets")
    suspend fun createTicket(@Body ticketRequest: CreateTicketRequest): Response<CustomerApiResponse<Any>>
    
    @POST("tickets/add_reply/{id}")
    suspend fun addTicketReply(
        @Path("id") id: String,
        @Body replyRequest: TicketReplyRequest
    ): Response<CustomerApiResponse<Any>>
    
    // Customer estimates - automatically filtered for authenticated customer
    @GET("estimates")
    suspend fun getEstimates(): Response<CustomerApiResponse<List<Estimate>>>
    
    @GET("estimates/id/{id}")
    suspend fun getEstimate(@Path("id") id: String): Response<CustomerApiResponse<Estimate>>
    
    // Customer proposals - automatically filtered for authenticated customer
    @GET("proposals")
    suspend fun getProposals(): Response<CustomerApiResponse<List<Proposal>>>
    
    @GET("proposals/id/{id}")
    suspend fun getProposal(@Path("id") id: String): Response<CustomerApiResponse<Proposal>>
    
    @POST("proposals/id/{id}/group/proposals_comment")
    suspend fun addProposalComment(
        @Path("id") id: String,
        @Body commentRequest: CommentRequest
    ): Response<CustomerApiResponse<Any>>
    
    // Customer contracts - automatically filtered for authenticated customer
    @GET("contracts")
    suspend fun getContracts(): Response<CustomerApiResponse<List<Contract>>>
    
    @GET("contracts/id/{id}")
    suspend fun getContract(@Path("id") id: String): Response<CustomerApiResponse<Contract>>
    
    @POST("contracts/id/{id}/group/contract_comment")
    suspend fun addContractComment(
        @Path("id") id: String,
        @Body commentRequest: CommentRequest
    ): Response<CustomerApiResponse<Any>>
    
    // Task management for projects
    @POST("projects/id/{id}/group/tasks")
    suspend fun addTask(
        @Path("id") projectId: String,
        @Body taskRequest: CreateTaskRequest
    ): Response<CustomerApiResponse<Any>>
    
    @PUT("projects/id/{id}/group/tasks")
    suspend fun updateTask(
        @Path("id") projectId: String,
        @Body taskRequest: UpdateTaskRequest
    ): Response<CustomerApiResponse<Any>>
    
    // Knowledge base (public access)
    @GET("knowledge_base")
    suspend fun getKnowledgeBase(): Response<CustomerApiResponse<List<KnowledgeGroup>>>
    
    @GET("knowledge_base/group/{slug}")
    suspend fun getKnowledgeGroup(@Path("slug") slug: String): Response<CustomerApiResponse<List<KnowledgeGroup>>>
    
    @GET("knowledge_base/article/{slug}")
    suspend fun getKnowledgeArticle(@Path("slug") slug: String): Response<CustomerApiResponse<KnowledgeArticle>>
    
    // Miscellaneous endpoints
    @GET("miscellaneous/group/client_menu")
    suspend fun getClientMenu(): Response<CustomerApiResponse<List<MenuItem>>>
    
    @GET("miscellaneous/group/departments")
    suspend fun getDepartments(): Response<CustomerApiResponse<List<Department>>>
    
    @GET("miscellaneous/group/get_services")
    suspend fun getServices(): Response<CustomerApiResponse<List<Service>>>
    
    @GET("miscellaneous/group/get_ticket_priorities")
    suspend fun getTicketPriorities(): Response<CustomerApiResponse<List<Priority>>>
}

// Request/Response models for Customer API - Additional models

data class CreateTicketRequest(
    val subject: String,
    val department: Int,
    val priority: Int,
    val project: Int? = null,
    val TicketBody: String
)

data class TicketReplyRequest(
    val Message: String
)

data class CommentRequest(
    val content: String
)

data class CreateTaskRequest(
    val name: String,
    val priority: Int,
    val startdate: String,
    val duedate: String? = null,
    val assignees: List<Int>? = null,
    val description: String? = null
)

data class UpdateTaskRequest(
    val id: Int,
    val name: String,
    val priority: Int,
    val startdate: String,
    val duedate: String? = null,
    val assignees: List<Int>? = null,
    val description: String? = null
)

data class ProjectGroup(
    val id: String,
    val name: String
)

data class MenuItem(
    val id: Int,
    val name: String,
    val short_name: String
)

data class Department(
    val departmentid: String,
    val name: String
)

data class Service(
    val serviceid: String,
    val name: String
)

data class Priority(
    val priorityid: String,
    val name: String
)

data class KnowledgeGroup(
    val groupid: String,
    val name: String,
    val group_slug: String,
    val description: String,
    val active: String,
    val color: String,
    val group_order: String,
    val articles: List<KnowledgeArticle>? = null
)

data class KnowledgeArticle(
    val slug: String,
    val subject: String,
    val description: String,
    val active_article: String,
    val articlegroup: String,
    val articleid: String,
    val staff_article: String,
    val datecreated: String
)