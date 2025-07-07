package com.legumlex.clientapp

import android.content.Context
import com.legumlex.clientapp.services.ApiClient
import com.legumlex.clientapp.services.TokenManager
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.first

sealed class SimpleApiResult<out T> {
    data class Success<out T>(val data: T) : SimpleApiResult<T>()
    data class Error(val message: String) : SimpleApiResult<Nothing>()
    object Loading : SimpleApiResult<Nothing>()
}

class SimpleRepository(private val context: Context) {
    
    private val apiService = ApiClient.getInstance()
    private val tokenManager = TokenManager(context)
    
    private suspend fun getCurrentClientId(): String? {
        return try {
            tokenManager.getUserId().first()
        } catch (e: Exception) {
            null
        }
    }
    
    // Get dashboard statistics using client-specific data
    suspend fun getDashboardStats(): SimpleApiResult<DashboardStats> {
        return try {
            val clientId = getCurrentClientId()
            if (clientId == null) {
                return SimpleApiResult.Error("Client not authenticated")
            }
            
            // Make API calls - use working endpoints
            val casesResponse = apiService.getCases() // Use general cases endpoint first
            val invoicesResponse = apiService.getInvoices()
            // Skip tickets and documents for now as they have endpoint issues
            //val ticketsResponse = apiService.getTickets()
            //val documentsResponse = apiService.getDocumentsByClient(clientId)
            
            // Check if core calls were successful
            if (casesResponse.isSuccessful && invoicesResponse.isSuccessful) {
                
                val cases = casesResponse.body() ?: emptyList()
                val invoices = invoicesResponse.body() ?: emptyList()
                
                // Filter data for current client
                val clientCases = cases.filter { it.clientId == clientId }
                val clientInvoices = invoices.filter { it.clientId == clientId }
                
                // Calculate real statistics from API data
                val stats = DashboardStats(
                    activeCases = clientCases.count { it.isActive },
                    unpaidInvoices = clientInvoices.count { it.status == "1" }, // Unpaid status
                    totalDocuments = 0, // Will be implemented later when documents API is working
                    openTickets = 0 // Will be implemented later when tickets API is working
                )
                
                SimpleApiResult.Success(stats)
            } else {
                // If core API calls fail, return error with details
                val errorMessage = when {
                    !casesResponse.isSuccessful -> "Failed to fetch cases: ${casesResponse.message()}"
                    !invoicesResponse.isSuccessful -> "Failed to fetch invoices: ${invoicesResponse.message()}"
                    else -> "Failed to fetch dashboard data"
                }
                SimpleApiResult.Error(errorMessage)
            }
            
        } catch (e: Exception) {
            SimpleApiResult.Error("Network error: ${e.message}")
        }
    }
    
    // Get detailed case data from Legal Practice Management API for current client
    suspend fun getCases(): SimpleApiResult<List<CaseItem>> {
        return try {
            val clientId = getCurrentClientId()
            if (clientId == null) {
                return SimpleApiResult.Error("Client not authenticated")
            }
            
            // Get all cases and filter for this client
            val response = apiService.getCases()
            
            if (response.isSuccessful && response.body() != null) {
                val allCases = response.body()!!
                
                // Filter cases for current client and convert to CaseItem format
                val caseItems = allCases
                    .filter { it.clientId == clientId }
                    .map { case ->
                        CaseItem(
                            id = case.id,
                            title = case.displayName,
                            status = case.statusText,
                            lastUpdate = case.updatedDate ?: case.createdDate ?: "Unknown",
                            priority = case.priorityText
                        )
                    }
                
                SimpleApiResult.Success(caseItems)
            } else {
                SimpleApiResult.Error("Failed to fetch cases: ${response.message()}")
            }
            
        } catch (e: Exception) {
            SimpleApiResult.Error("Failed to fetch cases: ${e.message}")
        }
    }
    
    // Get invoice data from Perfex CRM API for current client
    suspend fun getInvoices(): SimpleApiResult<List<InvoiceItem>> {
        return try {
            val clientId = getCurrentClientId()
            if (clientId == null) {
                return SimpleApiResult.Error("Client not authenticated")
            }
            
            val response = apiService.getInvoices()
            
            if (response.isSuccessful && response.body() != null) {
                val allInvoices = response.body()!!
                
                // Filter invoices for current client and convert to InvoiceItem format
                val invoiceItems = allInvoices
                    .filter { it.clientId == clientId }
                    .map { invoice ->
                        InvoiceItem(
                            id = invoice.formattedNumber,
                            amount = "${invoice.currency ?: "$"}${invoice.total}",
                            status = invoice.statusText,
                            dueDate = invoice.dueDate ?: "No due date",
                            description = "Invoice ${invoice.formattedNumber} - ${invoice.clientNote ?: "Legal Services"}"
                        )
                    }
                
                SimpleApiResult.Success(invoiceItems)
            } else {
                SimpleApiResult.Error("Failed to fetch invoices: ${response.message()}")
            }
            
        } catch (e: Exception) {
            SimpleApiResult.Error("Failed to fetch invoices: ${e.message}")
        }
    }
    
    // Get documents data from Legal Practice Management API for current client
    suspend fun getDocuments(): SimpleApiResult<List<DocumentItem>> {
        return try {
            val clientId = getCurrentClientId()
            if (clientId == null) {
                return SimpleApiResult.Error("Client not authenticated")
            }
            
            // Get all documents and filter for this client
            val response = apiService.getLegalDocuments()
            
            if (response.isSuccessful && response.body() != null) {
                val allDocuments = response.body()!!
                
                // Filter documents for current client and convert API documents to DocumentItem format
                val documentItems = allDocuments
                    .filter { it.clientId == clientId }
                    .map { document ->
                        DocumentItem(
                            id = document.id,
                            name = document.documentName,
                            description = document.description ?: "Legal document for ${document.caseName ?: document.clientName ?: "case"}",
                            type = document.fileExtension ?: document.documentType ?: "pdf",
                            uploadDate = document.uploadedDate ?: document.modifiedDate ?: "Recent"
                        )
                    }
                
                SimpleApiResult.Success(documentItems)
            } else {
                SimpleApiResult.Error("Failed to fetch documents: ${response.message()}")
            }
            
        } catch (e: Exception) {
            SimpleApiResult.Error("Failed to fetch documents: ${e.message}")
        }
    }
    
    // Get tickets data from Perfex CRM API for current client
    suspend fun getTickets(): SimpleApiResult<List<TicketItem>> {
        return try {
            // Temporarily return empty list since tickets API endpoint returns 404
            // TODO: Implement once tickets API endpoint is available
            SimpleApiResult.Success(emptyList())
            
            /*
            val clientId = getCurrentClientId()
            if (clientId == null) {
                return SimpleApiResult.Error("Client not authenticated")
            }
            
            val response = apiService.getTickets()
            
            if (response.isSuccessful && response.body() != null) {
                val allTickets = response.body()!!
                
                // Filter tickets for current client and convert API tickets to TicketItem format
                val ticketItems = allTickets
                    .filter { it.userId == clientId || it.contactId == clientId }
                    .map { ticket ->
                        TicketItem(
                            id = ticket.id,
                            subject = ticket.subject,
                            description = ticket.message ?: "Support ticket regarding legal services",
                            status = ticket.statusText,
                            priority = ticket.priorityText,
                            createdDate = ticket.date
                        )
                    }
                
                SimpleApiResult.Success(ticketItems)
            } else {
                SimpleApiResult.Error("Failed to fetch tickets: ${response.message()}")
            }
            */
            
        } catch (e: Exception) {
            SimpleApiResult.Error("Failed to fetch tickets: ${e.message}")
        }
    }
}

data class DashboardStats(
    val activeCases: Int = 0,
    val unpaidInvoices: Int = 0,
    val totalDocuments: Int = 0,
    val openTickets: Int = 0
)

data class CaseItem(
    val id: String,
    val title: String,
    val status: String,
    val lastUpdate: String,
    val priority: String
)

data class InvoiceItem(
    val id: String,
    val amount: String,
    val status: String,
    val dueDate: String,
    val description: String
)

data class DocumentItem(
    val id: String,
    val name: String,
    val description: String,
    val type: String,
    val uploadDate: String
)

data class TicketItem(
    val id: String,
    val subject: String,
    val description: String,
    val status: String,
    val priority: String,
    val createdDate: String
)