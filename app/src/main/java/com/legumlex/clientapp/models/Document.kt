package com.legumlex.clientapp.models

import com.google.gson.annotations.SerializedName

data class Document(
    @SerializedName("id")
    val id: String,
    
    @SerializedName("file_name")
    val fileName: String,
    
    @SerializedName("original_name")
    val originalName: String?,
    
    @SerializedName("file_type")
    val fileType: String?,
    
    @SerializedName("file_size")
    val fileSize: String?,
    
    @SerializedName("description")
    val description: String?,
    
    @SerializedName("category")
    val category: String?,
    
    @SerializedName("tags")
    val tags: String?,
    
    @SerializedName("rel_id")
    val relId: String?, // Related entity ID (project, case, invoice, etc.)
    
    @SerializedName("rel_type")
    val relType: String?, // Related entity type (project, case, invoice, etc.)
    
    @SerializedName("staffid")
    val staffId: String?,
    
    @SerializedName("clientid")
    val clientId: String?,
    
    @SerializedName("contact_id")
    val contactId: String?,
    
    @SerializedName("is_public")
    val isPublic: String?,
    
    @SerializedName("visible_to_customer")
    val visibleToCustomer: String?,
    
    @SerializedName("dateadded")
    val dateAdded: String?,
    
    @SerializedName("last_activity")
    val lastActivity: String?,
    
    @SerializedName("subject")
    val subject: String?,
    
    @SerializedName("external")
    val external: String?,
    
    @SerializedName("external_link")
    val externalLink: String?,
    
    @SerializedName("thumbnail_link")
    val thumbnailLink: String?,
    
    @SerializedName("file_path")
    val filePath: String?
) {
    val displayName: String
        get() = originalName ?: fileName
    
    val fileSizeFormatted: String
        get() = fileSize?.let { formatFileSize(it.toLongOrNull() ?: 0) } ?: "Unknown"
    
    val isVisibleToCustomer: Boolean
        get() = visibleToCustomer == "1"
    
    val isPublicDocument: Boolean
        get() = isPublic == "1"
    
    val fileExtension: String
        get() = fileName.substringAfterLast('.', "").lowercase()
    
    val isImage: Boolean
        get() = fileExtension in listOf("jpg", "jpeg", "png", "gif", "webp", "bmp")
    
    val isPdf: Boolean
        get() = fileExtension == "pdf"
    
    val isDocument: Boolean
        get() = fileExtension in listOf("doc", "docx", "txt", "rtf", "odt")
    
    val isSpreadsheet: Boolean
        get() = fileExtension in listOf("xls", "xlsx", "csv", "ods")
    
    val isPresentation: Boolean
        get() = fileExtension in listOf("ppt", "pptx", "odp")
    
    val categoryFormatted: String
        get() = category?.replaceFirstChar { it.uppercase() } ?: "General"
    
    val relatedEntityType: String
        get() = when (relType) {
            "project" -> "Project"
            "case" -> "Case"
            "invoice" -> "Invoice"
            "ticket" -> "Ticket"
            "contract" -> "Contract"
            "proposal" -> "Proposal"
            "estimate" -> "Estimate"
            else -> "Document"
        }
    
    val tagsList: List<String>
        get() = tags?.split(",")?.map { it.trim() }?.filter { it.isNotBlank() } ?: emptyList()
    
    private fun formatFileSize(sizeInBytes: Long): String {
        return when {
            sizeInBytes < 1024 -> "$sizeInBytes B"
            sizeInBytes < 1024 * 1024 -> "${sizeInBytes / 1024} KB"
            sizeInBytes < 1024 * 1024 * 1024 -> "${sizeInBytes / (1024 * 1024)} MB"
            else -> "${sizeInBytes / (1024 * 1024 * 1024)} GB"
        }
    }
}