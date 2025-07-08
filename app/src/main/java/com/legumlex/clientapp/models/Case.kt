package com.legumlex.clientapp.models

import com.google.gson.annotations.SerializedName

data class Case(
    @SerializedName("id")
    val id: String,
    
    @SerializedName("name")
    val caseTitle: String,
    
    @SerializedName("clientid")
    val clientId: String,
    
    @SerializedName("billing_type")
    val billingType: String?,
    
    @SerializedName("status")
    val status: String?,
    
    @SerializedName("start_date")
    val dateFiled: String?,
    
    @SerializedName("datecreated")
    val dateCreated: String?,
    
    @SerializedName("description")
    val description: String?,
    
    @SerializedName("progress")
    val progress: String?,
    
    @SerializedName("project_cost")
    val projectCost: String?,
    
    @SerializedName("project_rate_per_hour")
    val hourlyRate: String?,
    
    @SerializedName("estimated_hours")
    val estimatedHours: String?,
    
    @SerializedName("deadline")
    val deadline: String?,
    
    // Legacy fields for backward compatibility
    @SerializedName("consultation_id")
    val consultationId: String?,
    
    @SerializedName("case_number")
    val caseNumber: String?,
    
    @SerializedName("client_name")
    val clientName: String?,
    
    @SerializedName("hearing_count")
    val hearingCount: Int? = 0,
    
    @SerializedName("document_count")
    val documentCount: Int? = 0
) {
    val displayName: String
        get() = if (caseNumber.isNullOrBlank()) caseTitle else "$caseNumber - $caseTitle"
    
    val hasHearings: Boolean
        get() = (hearingCount ?: 0) > 0
    
    val hasDocuments: Boolean
        get() = (documentCount ?: 0) > 0
    
    val isActive: Boolean
        get() = status != "5" // 5 is typically completed/closed status
    
    val shortDescription: String
        get() = when {
            !clientName.isNullOrBlank() && !description.isNullOrBlank() -> "$clientName • ${description.take(50)}"
            !clientName.isNullOrBlank() -> clientName
            !description.isNullOrBlank() -> description.take(50)
            else -> "Project #$id"
        }
    
    val statusText: String
        get() = when (status) {
            "1" -> "Not Started"
            "2" -> "In Progress"
            "3" -> "On Hold"
            "4" -> "Cancelled"
            "5" -> "Completed"
            else -> "Active"
        }
    
    val formattedDateFiled: String
        get() = dateFiled ?: "Not filed yet"
    
    val formattedDateCreated: String
        get() = dateCreated ?: "Unknown"
}