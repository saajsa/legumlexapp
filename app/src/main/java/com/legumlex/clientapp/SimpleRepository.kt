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
    
    // Get dashboard statistics from real Perfex CRM API
    suspend fun getDashboardStats(): SimpleApiResult<DashboardStats> {
        return try {
            // Make real API calls to Perfex CRM
            val projectsResponse = apiService.getProjects()
            val invoicesResponse = apiService.getInvoices()
            val ticketsResponse = apiService.getTickets()
            
            // Check if all calls were successful
            if (projectsResponse.isSuccessful && invoicesResponse.isSuccessful && ticketsResponse.isSuccessful) {
                
                val projects = projectsResponse.body()?.data ?: emptyList()
                val invoices = invoicesResponse.body()?.data ?: emptyList()
                val tickets = ticketsResponse.body()?.data ?: emptyList()
                
                // Calculate real statistics from API data
                val stats = DashboardStats(
                    activeCases = projects.size, // All projects for the client
                    unpaidInvoices = invoices.count { it.status == "unpaid" || it.status == "1" },
                    totalDocuments = 0, // Will need separate documents API call
                    openTickets = tickets.count { it.status == "open" || it.status == "1" }
                )
                
                SimpleApiResult.Success(stats)
            } else {
                // If any API call fails, return error with details
                val errorMessage = when {
                    !projectsResponse.isSuccessful -> "Failed to fetch projects: ${projectsResponse.message()}"
                    !invoicesResponse.isSuccessful -> "Failed to fetch invoices: ${invoicesResponse.message()}"
                    !ticketsResponse.isSuccessful -> "Failed to fetch tickets: ${ticketsResponse.message()}"
                    else -> "Failed to fetch dashboard data"
                }
                SimpleApiResult.Error(errorMessage)
            }
            
        } catch (e: Exception) {
            SimpleApiResult.Error("Network error: ${e.message}")
        }
    }
    
    // Get detailed case/project data from real API
    suspend fun getCases(): SimpleApiResult<List<CaseItem>> {
        return try {
            val response = apiService.getProjects()
            
            if (response.isSuccessful && response.body() != null) {
                val projects = response.body()!!.data ?: emptyList()
                
                // Convert API projects to CaseItem format
                val cases = projects.map { project ->
                    CaseItem(
                        id = project.id,
                        title = project.name ?: "Untitled Project",
                        status = when (project.status) {
                            "1" -> "Active"
                            "2" -> "In Progress" 
                            "3" -> "On Hold"
                            "4" -> "Cancelled"
                            "5" -> "Finished"
                            else -> "Unknown"
                        },
                        lastUpdate = project.projectCreated ?: "Unknown",
                        priority = "Normal" // Project model doesn't have priority field
                    )
                }
                
                SimpleApiResult.Success(cases)
            } else {
                SimpleApiResult.Error("Failed to fetch cases: ${response.message()}")
            }
            
        } catch (e: Exception) {
            SimpleApiResult.Error("Failed to fetch cases: ${e.message}")
        }
    }
    
    // Get invoice data from real API
    suspend fun getInvoices(): SimpleApiResult<List<InvoiceItem>> {
        return try {
            val response = apiService.getInvoices()
            
            if (response.isSuccessful && response.body() != null) {
                val invoices = response.body()!!.data ?: emptyList()
                
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