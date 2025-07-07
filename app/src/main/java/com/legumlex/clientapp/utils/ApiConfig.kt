package com.legumlex.clientapp.utils

object ApiConfig {
    // Legal Practice Management API Configuration
    const val BASE_URL = "https://www.legumlex.com/accs/api/"
    
    // Legal Practice Management API Token (JWT)
    const val API_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoiIiwibmFtZSI6IiIsIkFQSV9USU1FIjoxNzUxNzg4MzA1fQ.3Yjs0Pr86OUVEFNb1VN1eGIlKtV2yQ9Nn_o9kTNHGiI"
    
    // Request timeout in seconds
    const val TIMEOUT_SECONDS = 30L
    
    // Legal Practice Management API Endpoints
    object Endpoints {
        const val CASES = "cases"
        const val CONSULTATIONS = "consultations"
        const val HEARINGS = "hearings"
        const val LEGAL_DOCUMENTS = "legal_documents"
        const val INVOICES = "invoices"
        const val TICKETS = "tickets"
        const val CONTRACTS = "contracts"
        const val PAYMENTS = "payments"
        const val FILES = "files"
    }
    
    // HTTP Headers - Legal API uses 'authtoken' header
    object Headers {
        const val CONTENT_TYPE = "Content-Type"
        const val ACCEPT = "Accept"
        const val AUTH_TOKEN = "authtoken"  // Legal API auth header
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