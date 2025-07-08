package com.legumlex.clientapp.services

import android.util.Log
import com.legumlex.clientapp.models.*
import com.legumlex.clientapp.utils.ApiConfig
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import retrofit2.Response

class LegalApiRepository {
    
    private val apiService = ApiClient.getInstance()
    
    companion object {
        private const val TAG = "LegalApiRepository"
        
        @Volatile
        private var INSTANCE: LegalApiRepository? = null
        
        fun getInstance(): LegalApiRepository {
            return INSTANCE ?: synchronized(this) {
                INSTANCE ?: LegalApiRepository().also { INSTANCE = it }
            }
        }
    }
    
    // Auth methods
    suspend fun verifyAuthentication(): Result<Boolean> = withContext(Dispatchers.IO) {
        try {
            Log.d(TAG, "Verifying authentication...")
            val response = apiService.getCases()
            
            if (response.isSuccessful) {
                Log.d(TAG, "Authentication successful")
                Result.success(true)
            } else {
                Log.e(TAG, "Authentication failed: ${response.code()} - ${response.message()}")
                Result.failure(Exception("Authentication failed: ${response.message()}"))
            }
        } catch (e: Exception) {
            Log.e(TAG, "Authentication error", e)
            Result.failure(e)
        }
    }
    
    // Cases methods
    suspend fun getCases(): Result<List<Case>> = withContext(Dispatchers.IO) {
        try {
            Log.d(TAG, "Fetching cases...")
            val response = apiService.getCases()
            
            if (response.isSuccessful) {
                val cases = response.body() ?: emptyList()
                Log.d(TAG, "Fetched ${cases.size} cases")
                Result.success(cases)
            } else {
                Log.e(TAG, "Failed to fetch cases: ${response.code()} - ${response.message()}")
                val errorBody = response.errorBody()?.string()
                Log.e(TAG, "Error body: $errorBody")
                Result.failure(Exception("Failed to fetch cases: ${response.message()}"))
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error fetching cases", e)
            Result.failure(e)
        }
    }
    
    suspend fun getCase(id: String): Result<Case> = withContext(Dispatchers.IO) {
        try {
            Log.d(TAG, "Fetching case with ID: $id")
            val response = apiService.getCase(id)
            
            if (response.isSuccessful) {
                val case = response.body()
                if (case != null) {
                    Log.d(TAG, "Fetched case: ${case.displayName}")
                    Result.success(case)
                } else {
                    Log.e(TAG, "Case not found")
                    Result.failure(Exception("Case not found"))
                }
            } else {
                Log.e(TAG, "Failed to fetch case: ${response.code()} - ${response.message()}")
                Result.failure(Exception("Failed to fetch case: ${response.message()}"))
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error fetching case", e)
            Result.failure(e)
        }
    }
    
    suspend fun searchCases(query: String): Result<List<Case>> = withContext(Dispatchers.IO) {
        try {
            Log.d(TAG, "Searching cases with query: $query")
            val response = apiService.searchCases(query)
            
            if (response.isSuccessful) {
                val cases = response.body() ?: emptyList()
                Log.d(TAG, "Found ${cases.size} cases for query: $query")
                Result.success(cases)
            } else {
                Log.e(TAG, "Failed to search cases: ${response.code()} - ${response.message()}")
                Result.failure(Exception("Failed to search cases: ${response.message()}"))
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error searching cases", e)
            Result.failure(e)
        }
    }
    
    // Consultations methods
    suspend fun getConsultations(): Result<List<Consultation>> = withContext(Dispatchers.IO) {
        try {
            Log.d(TAG, "Fetching consultations...")
            val response = apiService.getConsultations()
            
            if (response.isSuccessful) {
                val consultations = response.body() ?: emptyList()
                Log.d(TAG, "Fetched ${consultations.size} consultations")
                Result.success(consultations)
            } else {
                Log.e(TAG, "Failed to fetch consultations: ${response.code()} - ${response.message()}")
                Result.failure(Exception("Failed to fetch consultations: ${response.message()}"))
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error fetching consultations", e)
            Result.failure(e)
        }
    }
    
    suspend fun getConsultation(id: String): Result<Consultation> = withContext(Dispatchers.IO) {
        try {
            Log.d(TAG, "Fetching consultation with ID: $id")
            val response = apiService.getConsultation(id)
            
            if (response.isSuccessful) {
                val consultation = response.body()
                if (consultation != null) {
                    Log.d(TAG, "Fetched consultation: ${consultation.displayName}")
                    Result.success(consultation)
                } else {
                    Result.failure(Exception("Consultation not found"))
                }
            } else {
                Log.e(TAG, "Failed to fetch consultation: ${response.code()} - ${response.message()}")
                Result.failure(Exception("Failed to fetch consultation: ${response.message()}"))
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error fetching consultation", e)
            Result.failure(e)
        }
    }
    
    // Hearings methods
    suspend fun getHearings(): Result<List<Hearing>> = withContext(Dispatchers.IO) {
        try {
            Log.d(TAG, "Fetching hearings...")
            val response = apiService.getHearings()
            
            if (response.isSuccessful) {
                val hearings = response.body() ?: emptyList()
                Log.d(TAG, "Fetched ${hearings.size} hearings")
                Result.success(hearings)
            } else {
                Log.e(TAG, "Failed to fetch hearings: ${response.code()} - ${response.message()}")
                Result.failure(Exception("Failed to fetch hearings: ${response.message()}"))
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error fetching hearings", e)
            Result.failure(e)
        }
    }
    
    suspend fun getUpcomingHearings(): Result<List<Hearing>> = withContext(Dispatchers.IO) {
        try {
            Log.d(TAG, "Fetching upcoming hearings...")
            val response = apiService.getUpcomingHearings()
            
            if (response.isSuccessful) {
                val hearings = response.body() ?: emptyList()
                Log.d(TAG, "Fetched ${hearings.size} upcoming hearings")
                Result.success(hearings)
            } else {
                Log.e(TAG, "Failed to fetch upcoming hearings: ${response.code()} - ${response.message()}")
                Result.failure(Exception("Failed to fetch upcoming hearings: ${response.message()}"))
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error fetching upcoming hearings", e)
            Result.failure(e)
        }
    }
    
    suspend fun getHearingsByCase(caseId: String): Result<List<Hearing>> = withContext(Dispatchers.IO) {
        try {
            Log.d(TAG, "Fetching hearings for case: $caseId")
            val response = apiService.getHearingsByCase(caseId)
            
            if (response.isSuccessful) {
                val hearings = response.body() ?: emptyList()
                Log.d(TAG, "Fetched ${hearings.size} hearings for case: $caseId")
                Result.success(hearings)
            } else {
                Log.e(TAG, "Failed to fetch hearings for case: ${response.code()} - ${response.message()}")
                Result.failure(Exception("Failed to fetch hearings for case: ${response.message()}"))
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error fetching hearings for case", e)
            Result.failure(e)
        }
    }
    
    // Legal Documents methods
    suspend fun getLegalDocuments(): Result<List<LegalDocument>> = withContext(Dispatchers.IO) {
        try {
            Log.d(TAG, "Fetching legal documents...")
            val response = apiService.getLegalDocuments()
            
            if (response.isSuccessful) {
                val documents = response.body() ?: emptyList()
                Log.d(TAG, "Fetched ${documents.size} legal documents")
                Result.success(documents)
            } else {
                Log.e(TAG, "Failed to fetch legal documents: ${response.code()} - ${response.message()}")
                Result.failure(Exception("Failed to fetch legal documents: ${response.message()}"))
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error fetching legal documents", e)
            Result.failure(e)
        }
    }
    
    suspend fun getDocumentsByCase(caseId: String): Result<List<LegalDocument>> = withContext(Dispatchers.IO) {
        try {
            Log.d(TAG, "Fetching documents for case: $caseId")
            val response = apiService.getDocumentsByCase(caseId = caseId)
            
            if (response.isSuccessful) {
                val documents = response.body() ?: emptyList()
                Log.d(TAG, "Fetched ${documents.size} documents for case: $caseId")
                Result.success(documents)
            } else {
                Log.e(TAG, "Failed to fetch documents for case: ${response.code()} - ${response.message()}")
                Result.failure(Exception("Failed to fetch documents for case: ${response.message()}"))
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error fetching documents for case", e)
            Result.failure(e)
        }
    }
    
    // Invoices methods
    suspend fun getInvoices(): Result<List<Invoice>> = withContext(Dispatchers.IO) {
        try {
            Log.d(TAG, "Fetching invoices...")
            val response = apiService.getInvoices()
            
            if (response.isSuccessful) {
                val invoices = response.body() ?: emptyList()
                Log.d(TAG, "Fetched ${invoices.size} invoices")
                Result.success(invoices)
            } else {
                Log.e(TAG, "Failed to fetch invoices: ${response.code()} - ${response.message()}")
                Result.failure(Exception("Failed to fetch invoices: ${response.message()}"))
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error fetching invoices", e)
            Result.failure(e)
        }
    }
    
    // Tickets methods
    suspend fun getTickets(): Result<List<Ticket>> = withContext(Dispatchers.IO) {
        try {
            Log.d(TAG, "Fetching tickets...")
            val response = apiService.getTickets()
            
            if (response.isSuccessful) {
                val tickets = response.body() ?: emptyList()
                Log.d(TAG, "Fetched ${tickets.size} tickets")
                Result.success(tickets)
            } else {
                Log.e(TAG, "Failed to fetch tickets: ${response.code()} - ${response.message()}")
                Result.failure(Exception("Failed to fetch tickets: ${response.message()}"))
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error fetching tickets", e)
            Result.failure(e)
        }
    }
    
    // Dashboard stats method
    suspend fun getDashboardStats(): Result<DashboardStats> = withContext(Dispatchers.IO) {
        try {
            Log.d(TAG, "Fetching dashboard stats...")
            
            // Fetch all necessary data concurrently
            val casesResult = getCases()
            val invoicesResult = getInvoices()
            val documentsResult = getLegalDocuments()
            val ticketsResult = getTickets()
            
            // Calculate stats from the fetched data
            val activeCases = casesResult.getOrNull()?.size ?: 0
            val unpaidInvoices = invoicesResult.getOrNull()?.count { it.status == "unpaid" } ?: 0
            val totalDocuments = documentsResult.getOrNull()?.size ?: 0
            val openTickets = ticketsResult.getOrNull()?.count { it.status == "open" } ?: 0
            
            val stats = DashboardStats(
                activeCases = activeCases,
                unpaidInvoices = unpaidInvoices,
                totalDocuments = totalDocuments,
                openTickets = openTickets
            )
            
            Log.d(TAG, "Dashboard stats: $stats")
            Result.success(stats)
            
        } catch (e: Exception) {
            Log.e(TAG, "Error fetching dashboard stats", e)
            Result.failure(e)
        }
    }
}

