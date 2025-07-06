package com.legumlex.clientapp.models

import com.google.gson.annotations.SerializedName

data class User(
    @SerializedName("userid")
    val id: String,
    
    @SerializedName("company")
    val company: String?,
    
    @SerializedName("vat")
    val vat: String?,
    
    @SerializedName("phonenumber")
    val phoneNumber: String?,
    
    @SerializedName("country")
    val country: String?,
    
    @SerializedName("city")
    val city: String?,
    
    @SerializedName("zip")
    val zip: String?,
    
    @SerializedName("state")
    val state: String?,
    
    @SerializedName("address")
    val address: String?,
    
    @SerializedName("website")
    val website: String?,
    
    @SerializedName("datecreated")
    val dateCreated: String?,
    
    @SerializedName("active")
    val active: String,
    
    @SerializedName("leadid")
    val leadId: String?,
    
    @SerializedName("billing_street")
    val billingStreet: String?,
    
    @SerializedName("billing_city")
    val billingCity: String?,
    
    @SerializedName("billing_state")
    val billingState: String?,
    
    @SerializedName("billing_zip")
    val billingZip: String?,
    
    @SerializedName("billing_country")
    val billingCountry: String?,
    
    @SerializedName("shipping_street")
    val shippingStreet: String?,
    
    @SerializedName("shipping_city")
    val shippingCity: String?,
    
    @SerializedName("shipping_state")
    val shippingState: String?,
    
    @SerializedName("shipping_zip")
    val shippingZip: String?,
    
    @SerializedName("shipping_country")
    val shippingCountry: String?
) {
    val fullName: String
        get() = company ?: "Client"
    
    val isActive: Boolean
        get() = active == "1"
    
    val fullAddress: String
        get() = listOfNotNull(address, city, state, zip, country)
            .filter { it.isNotBlank() }
            .joinToString(", ")
    
    val fullBillingAddress: String
        get() = listOfNotNull(billingStreet, billingCity, billingState, billingZip, billingCountry)
            .filter { it.isNotBlank() }
            .joinToString(", ")
}