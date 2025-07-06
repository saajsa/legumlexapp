package com.legumlex.clientapp.utils

object ApiConfig {
    // Perfex CRM API Configuration
    const val BASE_URL = "https://legumlex.com/accs/api/"
    
    // Your Perfex CRM API Token
    const val API_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoiIiwibmFtZSI6IiIsIkFQSV9USU1FIjoxNzUxNzg4MzA1fQ.3Yjs0Pr86OUVEFNb1VN1eGIlKtV2yQ9Nn_o9kTNHGiI"
    
    // Request timeout in seconds
    const val TIMEOUT_SECONDS = 30L
    
    // Perfex CRM API Endpoints
    object Endpoints {
        const val CUSTOMERS = "customers"
        const val PROJECTS = "projects"
        const val INVOICES = "invoices"
        const val TICKETS = "tickets"
        const val CONTRACTS = "contracts"
        const val PROPOSALS = "proposals"
        const val ESTIMATES = "estimates"
        const val EXPENSES = "expenses"
        const val PAYMENTS = "payments"
        const val PAYMENT_METHODS = "payment_methods"
        const val TAXES = "taxes"
        const val FILES = "files"
    }
    
    // HTTP Headers - Perfex CRM uses 'authtoken' header
    object Headers {
        const val CONTENT_TYPE = "Content-Type"
        const val ACCEPT = "Accept"
        const val AUTH_TOKEN = "authtoken"  // Perfex CRM specific auth header
        const val USER_AGENT = "User-Agent"
    }
    
    // Content Types
    object ContentTypes {
        const val JSON = "application/json"
        const val FORM_DATA = "multipart/form-data"
    }
    
    // User Agent
    const val USER_AGENT_VALUE = "LegumLex-Android-Client/1.0"
    
    // Status Codes for better error handling
    object StatusCodes {
        const val SUCCESS = 200
        const val CREATED = 201
        const val BAD_REQUEST = 400
        const val UNAUTHORIZED = 401
        const val FORBIDDEN = 403
        const val NOT_FOUND = 404
        const val INTERNAL_SERVER_ERROR = 500
    }
}