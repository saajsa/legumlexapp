package com.legumlex.clientapp.models

import com.google.gson.annotations.SerializedName

data class Contract(
    @SerializedName("id")
    val id: String,
    
    @SerializedName("subject")
    val subject: String,
    
    @SerializedName("description")
    val description: String?,
    
    @SerializedName("client")
    val clientId: String,
    
    @SerializedName("project_id")
    val projectId: String?,
    
    @SerializedName("addedfrom")
    val addedFrom: String?,
    
    @SerializedName("dateadded")
    val dateAdded: String?,
    
    @SerializedName("isexpirynotified")
    val isExpiryNotified: String?,
    
    @SerializedName("contract_type")
    val contractType: String?,
    
    @SerializedName("contract_value")
    val contractValue: String?,
    
    @SerializedName("start_date")
    val startDate: String?,
    
    @SerializedName("end_date")
    val endDate: String?,
    
    @SerializedName("signed")
    val signed: String?,
    
    @SerializedName("signature")
    val signature: String?,
    
    @SerializedName("marked_as_signed")
    val markedAsSigned: String?,
    
    @SerializedName("acceptance_firstname")
    val acceptanceFirstname: String?,
    
    @SerializedName("acceptance_lastname")
    val acceptanceLastname: String?,
    
    @SerializedName("acceptance_email")
    val acceptanceEmail: String?,
    
    @SerializedName("acceptance_date")
    val acceptanceDate: String?,
    
    @SerializedName("acceptance_ip")
    val acceptanceIp: String?,
    
    @SerializedName("short_link")
    val shortLink: String?
) {
    val isSigned: Boolean
        get() = signed == "1"
    
    val contractValueAmount: Double
        get() = contractValue?.toDoubleOrNull() ?: 0.0
    
    val statusText: String
        get() = when {
            isSigned -> "Signed"
            !endDate.isNullOrBlank() && isExpired() -> "Expired"
            else -> "Pending"
        }
    
    val contractTypeFormatted: String
        get() = contractType?.replaceFirstChar { it.uppercase() } ?: "General"
    
    val acceptanceFullName: String
        get() = listOfNotNull(acceptanceFirstname, acceptanceLastname)
            .filter { it.isNotBlank() }
            .joinToString(" ")
    
    private fun isExpired(): Boolean {
        // Simple check - in real implementation, you'd compare with current date
        return false
    }
}