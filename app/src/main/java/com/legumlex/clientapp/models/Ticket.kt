package com.legumlex.clientapp.models

import com.google.gson.annotations.SerializedName

data class Ticket(
    @SerializedName("ticketid")
    val id: String,
    
    @SerializedName("adminreplying")
    val adminReplying: String?,
    
    @SerializedName("userid")
    val userId: String,
    
    @SerializedName("contactid")
    val contactId: String?,
    
    @SerializedName("merged_ticket_id")
    val mergedTicketId: String?,
    
    @SerializedName("email")
    val email: String?,
    
    @SerializedName("name")
    val name: String?,
    
    @SerializedName("department")
    val department: String?,
    
    @SerializedName("priority")
    val priority: String,
    
    @SerializedName("status")
    val status: String,
    
    @SerializedName("service")
    val service: String?,
    
    @SerializedName("ticketkey")
    val ticketKey: String,
    
    @SerializedName("subject")
    val subject: String,
    
    @SerializedName("message")
    val message: String?,
    
    @SerializedName("admin")
    val admin: String?,
    
    @SerializedName("date")
    val date: String,
    
    @SerializedName("project_id")
    val projectId: String?,
    
    @SerializedName("lastreply")
    val lastReply: String?,
    
    @SerializedName("clientread")
    val clientRead: String,
    
    @SerializedName("adminread")
    val adminRead: String,
    
    @SerializedName("assigned")
    val assigned: String?,
    
    @SerializedName("staff_id_replying")
    val staffIdReplying: String?,
    
    @SerializedName("tags")
    val tags: String?
) {
    val priorityText: String
        get() = when (priority) {
            "1" -> "Low"
            "2" -> "Medium"
            "3" -> "High"
            "4" -> "Urgent"
            else -> "Unknown"
        }
    
    val statusText: String
        get() = when (status) {
            "1" -> "Open"
            "2" -> "In Progress"
            "3" -> "Answered"
            "4" -> "On Hold"
            "5" -> "Closed"
            else -> "Unknown"
        }
    
    val isOpen: Boolean
        get() = status == "1"
    
    val isClosed: Boolean
        get() = status == "5"
    
    val isClientUnread: Boolean
        get() = clientRead == "0"
    
    val priorityLevel: Int
        get() = priority.toIntOrNull() ?: 1
}