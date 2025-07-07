package com.legumlex.clientapp

import com.legumlex.clientapp.services.ApiClient
import kotlinx.coroutines.delay

sealed class SimpleApiResult<out T> {
    data class Success<out T>(val data: T) : SimpleApiResult<T>()
    data class Error(val message: String) : SimpleApiResult<Nothing>()
    object Loading : SimpleApiResult<Nothing>()
}

class SimpleRepository {
    
    private val apiService = ApiClient.getInstance()
    
    // Get dashboard statistics using both Perfex CRM and Legal Practice Management API
    suspend fun getDashboardStats(): SimpleApiResult<DashboardStats> {
        return try {
            // Make API calls to both Perfex CRM and Legal Practice Management API
            val casesResponse = apiService.getCases()
            val invoicesResponse = apiService.getInvoices()
            val ticketsResponse = apiService.getTickets()
            val documentsResponse = apiService.getLegalDocuments()
            
            // Check if core calls were successful
            if (casesResponse.isSuccessful && invoicesResponse.isSuccessful) {
                
                val cases = casesResponse.body() ?: emptyList()
                val invoices = invoicesResponse.body() ?: emptyList()
                val tickets = ticketsResponse.body() ?: emptyList()
                val documents = documentsResponse.body() ?: emptyList()
                
                // Calculate real statistics from API data
                val stats = DashboardStats(
                    activeCases = cases.count { it.isActive },
                    unpaidInvoices = invoices.count { it.status == "1" }, // Unpaid status
                    totalDocuments = documents.size,
                    openTickets = tickets.count { it.status == "open" || it.status == "1" }
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
    
    // Get detailed case data from Legal Practice Management API
    suspend fun getCases(): SimpleApiResult<List<CaseItem>> {
        return try {
            val response = apiService.getCases()
            
            if (response.isSuccessful && response.body() != null) {
                val cases = response.body()!!
                
                // Convert API cases to CaseItem format
                val caseItems = cases.map { case ->
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
    
    // Get invoice data from Perfex CRM API
    suspend fun getInvoices(): SimpleApiResult<List<InvoiceItem>> {
        return try {
            val response = apiService.getInvoices()
            
            if (response.isSuccessful && response.body() != null) {
                val invoices = response.body()!!
                
                // Convert API invoices to InvoiceItem format
                val invoiceItems = invoices.map { invoice ->
                    InvoiceItem(
                        id = invoice.number ?: invoice.id,
                        amount = "$${invoice.total ?: "0.00"}",
                        status = when (invoice.status) {
                            "1" -> "Unpaid"
                            "2" -> "Paid"
                            "3" -> "Partially Paid"
                            "4" -> "Overdue"
                            "5" -> "Cancelled"
                            else -> "Unknown"
                        },
                        dueDate = invoice.dueDate ?: "No due date",
                        description = "Invoice #${invoice.number ?: invoice.id}"
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
    
    // Get documents data from Legal Practice Management API
    suspend fun getDocuments(): SimpleApiResult<List<DocumentItem>> {
        return try {
            val response = apiService.getLegalDocuments()
            
            if (response.isSuccessful && response.body() != null) {
                val documents = response.body()!!
                
                // Convert API documents to DocumentItem format
                val documentItems = documents.map { document ->
                    DocumentItem(
                        id = document.id,
                        name = document.name ?: "Unknown Document",
                        description = document.description ?: "No description available",
                        type = document.fileType ?: "unknown",
                        uploadDate = document.createdDate ?: "Unknown date"
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
    
    // Get tickets data from Perfex CRM API
    suspend fun getTickets(): SimpleApiResult<List<TicketItem>> {
        return try {
            val response = apiService.getTickets()
            
            if (response.isSuccessful && response.body() != null) {
                val tickets = response.body()!!
                
                // Convert API tickets to TicketItem format
                val ticketItems = tickets.map { ticket ->
                    TicketItem(
                        id = ticket.id,
                        subject = ticket.subject ?: "No subject",
                        description = ticket.message ?: "No description available",
                        status = when (ticket.status) {
                            "1" -> "Open"
                            "2" -> "In Progress"
                            "3" -> "Answered"
                            "4" -> "On Hold"
                            "5" -> "Closed"
                            else -> "Unknown"
                        },
                        priority = when (ticket.priority) {
                            "1" -> "Low"
                            "2" -> "Medium"
                            "3" -> "High"
                            "4" -> "Urgent"
                            else -> "Normal"
                        },
                        createdDate = ticket.date ?: "Unknown date"
                    )
                }
                
                SimpleApiResult.Success(ticketItems)
            } else {
                SimpleApiResult.Error("Failed to fetch tickets: ${response.message()}")
            }
            
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