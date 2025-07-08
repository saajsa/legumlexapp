package com.legumlex.clientapp.models

data class LoginData(
    val client_id: String,
    val contact_id: String,
    val client_logged_in: Boolean,
    val API_TIME: Long,
    val token: String
)

data class LoginRequest(
    val email: String,
    val password: String
)

data class LoginResponse(
    val status: Boolean,
    val data: LoginData?,
    val message: String
)

data class LogoutResponse(
    val status: Boolean,
    val message: String
)

data class RegisterRequest(
    val company: String,
    val firstname: String,
    val lastname: String,
    val email: String,
    val password: String,
    val passwordr: String,
    val vat: String? = null,
    val phonenumber: String? = null,
    val contact_phonenumber: String? = null,
    val website: String? = null,
    val position: String? = null,
    val country: Int? = null,
    val city: String? = null,
    val address: String? = null,
    val zip: String? = null,
    val state: String? = null
)

data class RegisterResponse(
    val status: Boolean,
    val message: String
)

data class CustomerApiResponse<T>(
    val status: Boolean,
    val data: T?,
    val message: String
)