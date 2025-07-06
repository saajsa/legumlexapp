package com.legumlex.clientapp.models

import com.google.gson.annotations.SerializedName

data class Payment(
    @SerializedName("id")
    val id: String,
    
    @SerializedName("invoiceid")
    val invoiceId: String,
    
    @SerializedName("amount")
    val amount: String,
    
    @SerializedName("paymentmethod")
    val paymentMethod: String?,
    
    @SerializedName("paymentmode")
    val paymentMode: String?,
    
    @SerializedName("date")
    val date: String,
    
    @SerializedName("daterecorded")
    val dateRecorded: String?,
    
    @SerializedName("note")
    val note: String?,
    
    @SerializedName("transactionid")
    val transactionId: String?,
    
    @SerializedName("paymentmethod_id")
    val paymentMethodId: String?,
    
    @SerializedName("currency")
    val currency: String?
) {
    val paymentAmount: Double
        get() = amount.toDoubleOrNull() ?: 0.0
    
    val paymentMethodFormatted: String
        get() = paymentMethod?.replaceFirstChar { it.uppercase() } ?: "Unknown"
    
    val hasTransactionId: Boolean
        get() = !transactionId.isNullOrBlank()
    
    val displayAmount: String
        get() = "${currency ?: "$"}${String.format("%.2f", paymentAmount)}"
}