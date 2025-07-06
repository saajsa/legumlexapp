package com.legumlex.clientapp.models

import com.google.gson.annotations.SerializedName

data class Invoice(
    @SerializedName("id")
    val id: String,
    
    @SerializedName("sent")
    val sent: String,
    
    @SerializedName("datesend")
    val dateSend: String?,
    
    @SerializedName("clientid")
    val clientId: String,
    
    @SerializedName("deleted_customer_name")
    val deletedCustomerName: String?,
    
    @SerializedName("number")
    val number: String,
    
    @SerializedName("prefix")
    val prefix: String?,
    
    @SerializedName("number_format")
    val numberFormat: String?,
    
    @SerializedName("datecreated")
    val dateCreated: String,
    
    @SerializedName("date")
    val date: String,
    
    @SerializedName("duedate")
    val dueDate: String?,
    
    @SerializedName("currency")
    val currency: String?,
    
    @SerializedName("subtotal")
    val subtotal: String,
    
    @SerializedName("total_tax")
    val totalTax: String,
    
    @SerializedName("total")
    val total: String,
    
    @SerializedName("adjustment")
    val adjustment: String?,
    
    @SerializedName("addedfrom")
    val addedFrom: String?,
    
    @SerializedName("status")
    val status: String,
    
    @SerializedName("clientnote")
    val clientNote: String?,
    
    @SerializedName("adminnote")
    val adminNote: String?,
    
    @SerializedName("last_overdue_reminder")
    val lastOverdueReminder: String?,
    
    @SerializedName("last_due_reminder")
    val lastDueReminder: String?,
    
    @SerializedName("cancel_overdue_reminders")
    val cancelOverdueReminders: String?,
    
    @SerializedName("allowed_payment_modes")
    val allowedPaymentModes: String?,
    
    @SerializedName("token")
    val token: String?,
    
    @SerializedName("discount_percent")
    val discountPercent: String?,
    
    @SerializedName("discount_total")
    val discountTotal: String?,
    
    @SerializedName("discount_type")
    val discountType: String?,
    
    @SerializedName("recurring")
    val recurring: String?,
    
    @SerializedName("recurring_type")
    val recurringType: String?,
    
    @SerializedName("custom_recurring")
    val customRecurring: String?,
    
    @SerializedName("cycles")
    val cycles: String?,
    
    @SerializedName("total_cycles")
    val totalCycles: String?,
    
    @SerializedName("is_recurring_from")
    val isRecurringFrom: String?,
    
    @SerializedName("project_id")
    val projectId: String?,
    
    @SerializedName("subscription_id")
    val subscriptionId: String?
) {
    val formattedNumber: String
        get() = if (prefix.isNullOrBlank()) number else "$prefix$number"
    
    val statusText: String
        get() = when (status) {
            "1" -> "Unpaid"
            "2" -> "Paid"
            "3" -> "Partially Paid"
            "4" -> "Overdue"
            "5" -> "Cancelled"
            "6" -> "Draft"
            else -> "Unknown"
        }
    
    val isPaid: Boolean
        get() = status == "2"
    
    val isOverdue: Boolean
        get() = status == "4"
    
    val totalAmount: Double
        get() = total.toDoubleOrNull() ?: 0.0
    
    val subtotalAmount: Double
        get() = subtotal.toDoubleOrNull() ?: 0.0
    
    val taxAmount: Double
        get() = totalTax.toDoubleOrNull() ?: 0.0
}