package com.legumlex.clientapp.models

/**
 * Dashboard statistics data class
 */
data class DashboardStats(
    val activeCases: Int = 0,
    val unpaidInvoices: Int = 0,
    val totalDocuments: Int = 0,
    val openTickets: Int = 0,
    val totalInvoices: Int = 0
)