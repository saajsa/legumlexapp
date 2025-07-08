package com.legumlex.clientapp.services

import android.content.Context
import com.legumlex.clientapp.models.*
import kotlinx.coroutines.flow.first


class CustomerRepository(private val context: Context) {
    
    private val apiService = ApiClient.getInstance()
    private val tokenManager = TokenManager(context)
    
    suspend fun login(email: String, password: String): ApiResult<LoginData> {
        return try {
            val loginRequest = LoginRequest(email, password)
            val response = apiService.login(loginRequest)
            
            if (response.isSuccessful && response.body()?.status == true) {
                val loginData = response.body()!!.data!!
                
                // Store the token and user data
                tokenManager.saveToken(loginData.token)
                tokenManager.saveUserId(loginData.client_id)
                tokenManager.saveContactId(loginData.contact_id)
                
                // Update the API token for future requests
                updateApiToken(loginData.token)
                
                ApiResult.Success(loginData)
            } else {
                val errorMessage = response.body()?.message ?: "Login failed"
                ApiResult.Error(Exception(errorMessage), errorMessage)
            }
        } catch (e: Exception) {
            ApiResult.Error(e, "Network error: ${e.message}")
        }
    }
    
    suspend fun logout(): ApiResult<String> {
        return try {
            val response = apiService.logout()
            
            if (response.isSuccessful && response.body()?.status == true) {
                // Clear stored data
                tokenManager.clearToken()
                tokenManager.clearUserId()
                tokenManager.clearContactId()
                
                ApiResult.Success(response.body()!!.message)
            } else {
                ApiResult.Error(Exception("Logout failed"), "Logout failed")
            }
        } catch (e: Exception) {
            ApiResult.Error(e, "Network error: ${e.message}")
        }
    }
    
    suspend fun getDashboardStats(): ApiResult<DashboardStats> {
        return try {
            // Make parallel calls to get dashboard data
            val invoicesResponse = apiService.getInvoices()
            val projectsResponse = apiService.getProjects() 
            val ticketsResponse = apiService.getTickets()
            
            if (invoicesResponse.isSuccessful && projectsResponse.isSuccessful && ticketsResponse.isSuccessful) {
                val invoices = invoicesResponse.body()?.data ?: emptyList()
                val projects = projectsResponse.body()?.data ?: emptyList()
                val tickets = ticketsResponse.body()?.data ?: emptyList()
                
                // Calculate statistics from the data
                val stats = DashboardStats(
                    activeCases = projects.count { it.status == "2" }, // In Progress status
                    unpaidInvoices = invoices.count { it.status == "1" }, // Unpaid status 
                    totalDocuments = 0, // Will be calculated from project files if needed
                    openTickets = tickets.count { it.status == "1" } // Open status
                )
                
                ApiResult.Success(stats)
            } else {
                val errorMessage = when {
                    !invoicesResponse.isSuccessful -> "Failed to fetch invoices: ${invoicesResponse.message()}"
                    !projectsResponse.isSuccessful -> "Failed to fetch projects: ${projectsResponse.message()}" 
                    !ticketsResponse.isSuccessful -> "Failed to fetch tickets: ${ticketsResponse.message()}"
                    else -> "Failed to fetch dashboard data"
                }
                ApiResult.Error(Exception(errorMessage), errorMessage)
            }
        } catch (e: Exception) {
            ApiResult.Error(e, "Network error: ${e.message}")
        }
    }
    
    suspend fun getInvoices(): ApiResult<List<Invoice>> {
        return try {
            val response = apiService.getInvoices()
            
            if (response.isSuccessful && response.body()?.status == true) {
                val invoices = response.body()!!.data ?: emptyList()
                ApiResult.Success(invoices)
            } else {
                val errorMessage = response.body()?.message ?: "Failed to fetch invoices"
                ApiResult.Error(Exception(errorMessage), errorMessage)
            }
        } catch (e: Exception) {
            ApiResult.Error(e, "Network error: ${e.message}")
        }
    }
    
    suspend fun getProjects(): ApiResult<List<Project>> {
        return try {
            val response = apiService.getProjects()
            
            if (response.isSuccessful && response.body()?.status == true) {
                val projects = response.body()!!.data ?: emptyList()
                ApiResult.Success(projects)
            } else {
                val errorMessage = response.body()?.message ?: "Failed to fetch projects"
                ApiResult.Error(Exception(errorMessage), errorMessage)
            }
        } catch (e: Exception) {
            ApiResult.Error(e, "Network error: ${e.message}")
        }
    }
    
    suspend fun getTickets(): ApiResult<List<Ticket>> {
        return try {
            val response = apiService.getTickets()
            
            if (response.isSuccessful && response.body()?.status == true) {
                val tickets = response.body()!!.data ?: emptyList()
                ApiResult.Success(tickets)
            } else {
                val errorMessage = response.body()?.message ?: "Failed to fetch tickets"
                ApiResult.Error(Exception(errorMessage), errorMessage)
            }
        } catch (e: Exception) {
            ApiResult.Error(e, "Network error: ${e.message}")
        }
    }
    
    suspend fun getInvoice(id: String): ApiResult<Invoice> {
        return try {
            val response = apiService.getInvoice(id)
            
            if (response.isSuccessful && response.body()?.status == true) {
                val invoice = response.body()!!.data!!
                ApiResult.Success(invoice)
            } else {
                val errorMessage = response.body()?.message ?: "Failed to fetch invoice"
                ApiResult.Error(Exception(errorMessage), errorMessage)
            }
        } catch (e: Exception) {
            ApiResult.Error(e, "Network error: ${e.message}")
        }
    }
    
    suspend fun getProject(id: String): ApiResult<Project> {
        return try {
            val response = apiService.getProject(id)
            
            if (response.isSuccessful && response.body()?.status == true) {
                val project = response.body()!!.data!!
                ApiResult.Success(project)
            } else {
                val errorMessage = response.body()?.message ?: "Failed to fetch project"
                ApiResult.Error(Exception(errorMessage), errorMessage)
            }
        } catch (e: Exception) {
            ApiResult.Error(e, "Network error: ${e.message}")
        }
    }
    
    suspend fun getTicket(id: String): ApiResult<Ticket> {
        return try {
            val response = apiService.getTicket(id)
            
            if (response.isSuccessful && response.body()?.status == true) {
                val ticket = response.body()!!.data!!
                ApiResult.Success(ticket)
            } else {
                val errorMessage = response.body()?.message ?: "Failed to fetch ticket"
                ApiResult.Error(Exception(errorMessage), errorMessage)
            }
        } catch (e: Exception) {
            ApiResult.Error(e, "Network error: ${e.message}")
        }
    }
    
    private fun updateApiToken(token: String) {
        // This would ideally update the API client instance with the new token
        // For now, we store it in ApiConfig (though this should be improved)
        // In a production app, you'd update the OkHttp interceptor dynamically
    }
    
    suspend fun isLoggedIn(): Boolean {
        return try {
            val token = tokenManager.getToken().first()
            !token.isNullOrEmpty()
        } catch (e: Exception) {
            false
        }
    }
}