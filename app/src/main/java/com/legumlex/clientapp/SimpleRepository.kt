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
    
    // Get dashboard statistics from API
    suspend fun getDashboardStats(): SimpleApiResult<DashboardStats> {
        return try {
            // Add small delay to simulate network call
            delay(500)
            
            // TODO: Replace with actual API calls once endpoints are confirmed
            // For now, we'll use enhanced mock data that could come from API
            
            /* TODO: Implement real API calls
            val customersResponse = apiService.getCustomers()
            val projectsResponse = apiService.getProjects()
            val invoicesResponse = apiService.getInvoices()
            val ticketsResponse = apiService.getTickets()
            
            if (customersResponse.isSuccessful && projectsResponse.isSuccessful && 
                invoicesResponse.isSuccessful && ticketsResponse.isSuccessful) {
                
                val projects = projectsResponse.body() ?: emptyList()
                val invoices = invoicesResponse.body() ?: emptyList()
                val tickets = ticketsResponse.body() ?: emptyList()
                
                val stats = DashboardStats(
                    activeCases = projects.count { it.status == "active" },
                    unpaidInvoices = invoices.count { it.status == "unpaid" },
                    totalDocuments = 0, // Will need separate documents API call
                    openTickets = tickets.count { it.status == "open" }
                )
                
                SimpleApiResult.Success(stats)
            } else {
                SimpleApiResult.Error("Failed to fetch dashboard data")
            }
            */
            
            // Enhanced mock data for demonstration
            SimpleApiResult.Success(
                DashboardStats(
                    activeCases = 3,
                    unpaidInvoices = 2,
                    totalDocuments = 15,
                    openTickets = 1
                )
            )
            
        } catch (e: Exception) {
            SimpleApiResult.Error("Network error: ${e.message}")
        }
    }
    
    // Get detailed case/project data
    suspend fun getCases(): SimpleApiResult<List<CaseItem>> {
        return try {
            delay(300)
            
            // TODO: Replace with actual API call
            // val response = apiService.getProjects()
            
            val mockCases = listOf(
                CaseItem(
                    id = "1",
                    title = "Personal Injury Case",
                    status = "Active",
                    lastUpdate = "2 days ago",
                    priority = "High"
                ),
                CaseItem(
                    id = "2", 
                    title = "Contract Review",
                    status = "In Progress",
                    lastUpdate = "1 week ago",
                    priority = "Medium"
                ),
                CaseItem(
                    id = "3",
                    title = "Estate Planning",
                    status = "Pending",
                    lastUpdate = "3 days ago",
                    priority = "Low"
                )
            )
            
            SimpleApiResult.Success(mockCases)
            
        } catch (e: Exception) {
            SimpleApiResult.Error("Failed to fetch cases: ${e.message}")
        }
    }
    
    // Get invoice data
    suspend fun getInvoices(): SimpleApiResult<List<InvoiceItem>> {
        return try {
            delay(300)
            
            val mockInvoices = listOf(
                InvoiceItem(
                    id = "INV-001",
                    amount = "$1,250.00",
                    status = "Unpaid",
                    dueDate = "Jan 15, 2025",
                    description = "Legal Consultation"
                ),
                InvoiceItem(
                    id = "INV-002",
                    amount = "$850.00", 
                    status = "Paid",
                    dueDate = "Dec 20, 2024",
                    description = "Document Review"
                )
            )
            
            SimpleApiResult.Success(mockInvoices)
            
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