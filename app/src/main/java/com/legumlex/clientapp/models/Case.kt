package com.legumlex.clientapp.models

import com.google.gson.annotations.SerializedName

data class Case(
    @SerializedName("id")
    val id: String,
    
    @SerializedName("consultation_id")
    val consultationId: String?,
    
    @SerializedName("case_title")
    val caseTitle: String,
    
    @SerializedName("case_number")
    val caseNumber: String?,
    
    @SerializedName("client_id")
    val clientId: String,
    
    @SerializedName("contact_id")
    val contactId: String?,
    
    @SerializedName("court_room_id")
    val courtRoomId: String?,
    
    @SerializedName("date_filed")
    val dateFiled: String?,
    
    @SerializedName("date_created")
    val dateCreated: String?,
    
    @SerializedName("client_name")
    val clientName: String?,
    
    @SerializedName("contact_name")
    val contactName: String?,
    
    @SerializedName("court_name")
    val courtName: String?,
    
    @SerializedName("court_no")
    val courtNo: String?,
    
    @SerializedName("judge_name")
    val judgeName: String?,
    
    @SerializedName("court_display")
    val courtDisplay: String?,
    
    @SerializedName("consultation_reference")
    val consultationReference: String?,
    
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
        get() = dateCreated != null
    
    val shortDescription: String
        get() = when {
            !clientName.isNullOrBlank() && !courtName.isNullOrBlank() -> "$clientName • $courtName"
            !clientName.isNullOrBlank() -> clientName
            !courtName.isNullOrBlank() -> courtName
            else -> "Case #$id"
        }
    
    val statusText: String
        get() = when {
            dateFiled != null -> "Filed"
            courtRoomId != null -> "Assigned to Court"
            consultationId != null -> "From Consultation"
            else -> "Active"
        }
    
    val formattedDateFiled: String
        get() = dateFiled ?: "Not filed yet"
    
    val formattedDateCreated: String
        get() = dateCreated ?: "Unknown"
}