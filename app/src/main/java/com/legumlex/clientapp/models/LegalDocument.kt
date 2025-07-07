package com.legumlex.clientapp.models

import com.google.gson.annotations.SerializedName

data class LegalDocument(
    @SerializedName("id")
    val id: String,
    
    @SerializedName("case_id")
    val caseId: String?,
    
    @SerializedName("hearing_id")
    val hearingId: String?,
    
    @SerializedName("client_id")
    val clientId: String?,
    
    @SerializedName("document_name")
    val documentName: String,
    
    @SerializedName("document_type")
    val documentType: String?,
    
    @SerializedName("file_path")
    val filePath: String?,
    
    @SerializedName("file_size")
    val fileSize: String?,
    
    @SerializedName("file_extension")
    val fileExtension: String?,
    
    @SerializedName("mime_type")
    val mimeType: String?,
    
    @SerializedName("description")
    val description: String?,
    
    @SerializedName("tags")
    val tags: String?,
    
    @SerializedName("status")
    val status: String = "1",
    
    @SerializedName("is_confidential")
    val isConfidential: Boolean = false,
    
    @SerializedName("access_level")
    val accessLevel: String = "1",
    
    @SerializedName("version")
    val version: String = "1.0",
    
    @SerializedName("parent_document_id")
    val parentDocumentId: String?,
    
    @SerializedName("uploaded_by")
    val uploadedBy: String?,
    
    @SerializedName("uploaded_date")
    val uploadedDate: String?,
    
    @SerializedName("modified_date")
    val modifiedDate: String?,
    
    @SerializedName("expiry_date")
    val expiryDate: String?,
    
    @SerializedName("case_name")
    val caseName: String?,
    
    @SerializedName("case_number")
    val caseNumber: String?,
    
    @SerializedName("hearing_date")
    val hearingDate: String?,
    
    @SerializedName("client_name")
    val clientName: String?,
    
    @SerializedName("download_url")
    val downloadUrl: String?,
    
    @SerializedName("thumbnail_url")
    val thumbnailUrl: String?
) {
    val statusText: String
        get() = when (status) {
            "1" -> "Active"
            "2" -> "Archived"
            "3" -> "Deleted"
            "4" -> "Under Review"
            "5" -> "Approved"
            "6" -> "Rejected"
            else -> "Unknown"
        }
    
    val documentTypeFormatted: String
        get() = documentType?.replaceFirstChar { it.uppercase() } ?: "Document"
    
    val accessLevelText: String
        get() = when (accessLevel) {
            "1" -> "Public"
            "2" -> "Internal"
            "3" -> "Client Only"
            "4" -> "Lawyer Only"
            "5" -> "Restricted"
            else -> "Unknown"
        }
    
    val isActive: Boolean
        get() = status == "1"
    
    val isArchived: Boolean
        get() = status == "2"
    
    val fileSizeBytes: Long
        get() = fileSize?.toLongOrNull() ?: 0L
    
    val fileSizeFormatted: String
        get() {
            val bytes = fileSizeBytes
            return when {
                bytes < 1024 -> "$bytes B"
                bytes < 1024 * 1024 -> "${bytes / 1024} KB"
                bytes < 1024 * 1024 * 1024 -> "${bytes / (1024 * 1024)} MB"
                else -> "${bytes / (1024 * 1024 * 1024)} GB"
            }
        }
    
    val isPdf: Boolean
        get() = fileExtension?.lowercase() == "pdf" || mimeType == "application/pdf"
    
    val isImage: Boolean
        get() = mimeType?.startsWith("image/") == true
    
    val isText: Boolean
        get() = mimeType?.startsWith("text/") == true
    
    val isWord: Boolean
        get() = mimeType?.contains("word") == true || 
                fileExtension?.lowercase() in listOf("doc", "docx")
    
    val isExcel: Boolean
        get() = mimeType?.contains("sheet") == true || 
                fileExtension?.lowercase() in listOf("xls", "xlsx")
    
    val tagsList: List<String>
        get() = tags?.split(",")?.map { it.trim() }?.filter { it.isNotEmpty() } ?: emptyList()
    
    val displayName: String
        get() = if (version != "1.0") "$documentName (v$version)" else documentName
    
    val associatedWith: String
        get() = when {
            !caseNumber.isNullOrBlank() -> "Case: $caseNumber"
            !caseName.isNullOrBlank() -> "Case: $caseName"
            !hearingDate.isNullOrBlank() -> "Hearing: $hearingDate"
            !clientName.isNullOrBlank() -> "Client: $clientName"
            else -> "General"
        }
    
    val hasExpiry: Boolean
        get() = !expiryDate.isNullOrBlank()
    
    val isExpired: Boolean
        get() = hasExpiry && expiryDate!! < getCurrentDate()
    
    val hasVersion: Boolean
        get() = !parentDocumentId.isNullOrBlank()
    
    // Helper function to get current date (you might want to use a proper date library)
    private fun getCurrentDate(): String {
        return "2024-12-31" // Placeholder - implement with actual date logic
    }
}