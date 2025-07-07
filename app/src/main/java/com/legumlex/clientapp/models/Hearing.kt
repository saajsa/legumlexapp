package com.legumlex.clientapp.models

import com.google.gson.annotations.SerializedName

data class Hearing(
    @SerializedName("id")
    val id: String,
    
    @SerializedName("case_id")
    val caseId: String,
    
    @SerializedName("hearing_date")
    val hearingDate: String,
    
    @SerializedName("hearing_time")
    val hearingTime: String?,
    
    @SerializedName("court_name")
    val courtName: String?,
    
    @SerializedName("courtroom")
    val courtroom: String?,
    
    @SerializedName("judge_name")
    val judgeName: String?,
    
    @SerializedName("hearing_type")
    val hearingType: String?,
    
    @SerializedName("status")
    val status: String = "1",
    
    @SerializedName("notes")
    val notes: String?,
    
    @SerializedName("outcome")
    val outcome: String?,
    
    @SerializedName("next_hearing_date")
    val nextHearingDate: String?,
    
    @SerializedName("duration")
    val duration: String?,
    
    @SerializedName("case_number")
    val caseNumber: String?,
    
    @SerializedName("case_name")
    val caseName: String?,
    
    @SerializedName("client_name")
    val clientName: String?,
    
    @SerializedName("priority")
    val priority: String = "2",
    
    @SerializedName("reminder_set")
    val reminderSet: Boolean = false,
    
    @SerializedName("reminder_time")
    val reminderTime: String?,
    
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
            "4" -> "Postponed"
            "5" -> "Cancelled"
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
    
    val hearingTypeFormatted: String
        get() = hearingType?.replaceFirstChar { it.uppercase() } ?: "General"
    
    val isUpcoming: Boolean
        get() = status == "1"
    
    val isCompleted: Boolean
        get() = status == "3"
    
    val isPastDue: Boolean
        get() = status == "1" && hearingDate < getCurrentDate()
    
    val durationMinutes: Int
        get() = duration?.toIntOrNull() ?: 0
    
    val fullCourtLocation: String
        get() = if (courtroom.isNullOrBlank()) 
            courtName ?: "Court"
        else 
            "${courtName ?: "Court"} - $courtroom"
    
    val displayName: String
        get() = if (caseNumber.isNullOrBlank()) 
            caseName ?: "Hearing #$id"
        else 
            "$caseNumber - ${caseName ?: "Hearing"}"
    
    val hasReminder: Boolean
        get() = reminderSet && !reminderTime.isNullOrBlank()
    
    // Helper function to get current date (you might want to use a proper date library)
    private fun getCurrentDate(): String {
        return "2024-12-31" // Placeholder - implement with actual date logic
    }
}