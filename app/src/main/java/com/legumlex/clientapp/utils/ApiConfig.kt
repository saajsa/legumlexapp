package com.legumlex.clientapp.utils

object ApiConfig {
    // Perfex CRM Customer API Configuration
    const val BASE_URL = "https://www.legumlex.com/accs/customers_api/v1/"
    
    // Perfex CRM Customer API Token
    const val API_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoiIiwibmFtZSI6IiIsIkFQSV9USU1FIjoxNzUxNzg4MzA1fQ.3Yjs0Pr86OUVEFNb1VN1eGIlKtV2yQ9Nn_o9kTNHGiI"
    
    // Request timeout in seconds
    const val TIMEOUT_SECONDS = 30L
    
    // Perfex CRM Customer API Endpoints
    object Endpoints {
        const val PROFILE = "profile"
        const val INVOICES = "invoices"
        const val TICKETS = "tickets"
        const val PROJECTS = "projects"
        const val CONTRACTS = "contracts"
        const val PAYMENTS = "payments"
        const val FILES = "files"
        const val CONTACTS = "contacts"
        const val ESTIMATES = "estimates"
    }
    
    // HTTP Headers - Perfex Customer API uses 'Authorization' header
    object Headers {
        const val CONTENT_TYPE = "Content-Type"
        const val ACCEPT = "Accept"
        const val AUTHORIZATION = "Authorization"  // Perfex Customer API auth header
        const val USER_AGENT = "User-Agent"
        const val X_REQUESTED_WITH = "X-Requested-With"
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