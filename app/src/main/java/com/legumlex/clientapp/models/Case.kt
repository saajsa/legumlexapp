package com.legumlex.clientapp.models

import com.google.gson.annotations.SerializedName

data class Case(
    @SerializedName("id")
    val id: String,
    
    @SerializedName("name")
    val name: String,
    
    @SerializedName("description")
    val description: String?,
    
    @SerializedName("status")
    val status: String,
    
    @SerializedName("clientid")
    val clientId: String,
    
    @SerializedName("case_type")
    val caseType: String?,
    
    @SerializedName("priority")
    val priority: String,
    
    @SerializedName("start_date")
    val startDate: String?,
    
    @SerializedName("end_date")
    val endDate: String?,
    
    @SerializedName("court")
    val court: String?,
    
    @SerializedName("judge")
    val judge: String?,
    
    @SerializedName("opposing_party")
    val opposingParty: String?,
    
    @SerializedName("assigned_lawyer")
    val assignedLawyer: String?,
    
    @SerializedName("case_number")
    val caseNumber: String?,
    
    @SerializedName("billing_type")
    val billingType: String?,
    
    @SerializedName("hourly_rate")
    val hourlyRate: String?,
    
    @SerializedName("retainer_amount")
    val retainerAmount: String?,
    
    @SerializedName("total_hours")
    val totalHours: String?,
    
    @SerializedName("total_cost")
    val totalCost: String?,
    
    @SerializedName("notes")
    val notes: String?,
    
    @SerializedName("created_date")
    val createdDate: String?,
    
    @SerializedName("updated_date")
    val updatedDate: String?,
    
    @SerializedName("closed_date")
    val closedDate: String?
) {
    val statusText: String
        get() = when (status) {
            "1" -> "Open"
            "2" -> "In Progress"
            "3" -> "Pending"
            "4" -> "Closed"
            "5" -> "Won"
            "6" -> "Lost"
            "7" -> "Settled"
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
    
    val isActive: Boolean
        get() = status in listOf("1", "2", "3")
    
    val isClosed: Boolean
        get() = status in listOf("4", "5", "6", "7")
    
    val totalCostAmount: Double
        get() = totalCost?.toDoubleOrNull() ?: 0.0
    
    val totalHoursWorked: Double
        get() = totalHours?.toDoubleOrNull() ?: 0.0
    
    val hourlyRateAmount: Double
        get() = hourlyRate?.toDoubleOrNull() ?: 0.0
    
    val retainerAmountValue: Double
        get() = retainerAmount?.toDoubleOrNull() ?: 0.0
    
    val caseTypeFormatted: String
        get() = caseType?.replaceFirstChar { it.uppercase() } ?: "General"
    
    val displayName: String
        get() = if (caseNumber.isNullOrBlank()) name else "$caseNumber - $name"
}