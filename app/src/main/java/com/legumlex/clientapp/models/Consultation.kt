package com.legumlex.clientapp.models

import com.google.gson.annotations.SerializedName

data class Consultation(
    @SerializedName("id")
    val id: String,
    
    @SerializedName("client_id")
    val clientId: String,
    
    @SerializedName("tag")
    val tag: String?,
    
    @SerializedName("note")
    val note: String?,
    
    @SerializedName("date_added")
    val dateAdded: String?,
    
    @SerializedName("client_name")
    val clientName: String?,
    
    @SerializedName("contact_name")
    val contactName: String?,
    
    @SerializedName("status")
    val status: String = "1",
    
    @SerializedName("consultation_type")
    val consultationType: String?,
    
    @SerializedName("priority")
    val priority: String = "2",
    
    @SerializedName("scheduled_date")
    val scheduledDate: String?,
    
    @SerializedName("duration")
    val duration: String?,
    
    @SerializedName("fee")
    val fee: String?,
    
    @SerializedName("payment_status")
    val paymentStatus: String?,
    
    @SerializedName("follow_up_required")
    val followUpRequired: Boolean = false,
    
    @SerializedName("follow_up_date")
    val followUpDate: String?,
    
    @SerializedName("created_date")
    val createdDate: String?,
    
    @SerializedName("updated_date")
    val updatedDate: String?
) {
    val statusText: String
        get() = when (status) {
            "1" -> "Scheduled"
            "2" -> "In Progress"
            "3" -> "Completed"
            "4" -> "Cancelled"
            "5" -> "Upgraded to Case"
            else -> "Unknown"
        }
    
    val priorityText: String
        get() = when (priority) {
            "1" -> "Low"
            "2" -> "Medium"
            "3" -> "High"
            "4" -> "Urgent"
            else -> "Normal"
        }
    
    val paymentStatusText: String
        get() = when (paymentStatus) {
            "1" -> "Paid"
            "2" -> "Pending"
            "3" -> "Overdue"
            else -> "Not Set"
        }
    
    val isActive: Boolean
        get() = status in listOf("1", "2")
    
    val isCompleted: Boolean
        get() = status == "3"
    
    val feeAmount: Double
        get() = fee?.toDoubleOrNull() ?: 0.0
    
    val durationMinutes: Int
        get() = duration?.toIntOrNull() ?: 0
    
    val consultationTypeFormatted: String
        get() = consultationType?.replaceFirstChar { it.uppercase() } ?: "General"
    
    val displayName: String
        get() = if (tag.isNullOrBlank()) "Consultation #$id" else "$tag - Consultation"
}