package com.legumlex.clientapp.models

import com.google.gson.annotations.SerializedName

data class ApiResponse<T>(
    @SerializedName("status")
    val status: Boolean,
    
    @SerializedName("message")
    val message: String?,
    
    @SerializedName("data")
    val data: T?
)

data class ErrorResponse(
    @SerializedName("message")
    val message: String?,
    
    @SerializedName("errors")
    val errors: Map<String, List<String>>?
)