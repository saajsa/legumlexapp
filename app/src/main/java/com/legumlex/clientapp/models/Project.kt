package com.legumlex.clientapp.models

import com.google.gson.annotations.SerializedName

data class Project(
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
    
    @SerializedName("billing_type")
    val billingType: String?,
    
    @SerializedName("start_date")
    val startDate: String?,
    
    @SerializedName("deadline")
    val deadline: String?,
    
    @SerializedName("project_created")
    val projectCreated: String?,
    
    @SerializedName("date_finished")
    val dateFinished: String?,
    
    @SerializedName("progress")
    val progress: String?,
    
    @SerializedName("project_cost")
    val projectCost: String?,
    
    @SerializedName("project_rate_per_hour")
    val projectRatePerHour: String?,
    
    @SerializedName("estimated_hours")
    val estimatedHours: String?
) {
    val progressPercentage: Int
        get() = progress?.toIntOrNull() ?: 0
    
    val isCompleted: Boolean
        get() = status == "4" // Assuming status 4 means completed
    
    val isActive: Boolean
        get() = status == "2" // Assuming status 2 means in progress
    
    val statusText: String
        get() = when (status) {
            "1" -> "Not Started"
            "2" -> "In Progress"
            "3" -> "On Hold"
            "4" -> "Completed"
            "5" -> "Cancelled"
            else -> "Unknown"
        }
}