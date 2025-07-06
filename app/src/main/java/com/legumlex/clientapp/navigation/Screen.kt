package com.legumlex.clientapp.navigation

sealed class Screen(val route: String) {
    object Dashboard : Screen("dashboard")
    object Cases : Screen("cases")
    object CaseDetail : Screen("case_detail/{caseId}") {
        fun createRoute(caseId: String) = "case_detail/$caseId"
    }
    object Documents : Screen("documents")
    object DocumentDetail : Screen("document_detail/{documentId}") {
        fun createRoute(documentId: String) = "document_detail/$documentId"
    }
    object Invoices : Screen("invoices")
    object InvoiceDetail : Screen("invoice_detail/{invoiceId}") {
        fun createRoute(invoiceId: String) = "invoice_detail/$invoiceId"
    }
    object Tickets : Screen("tickets")
    object TicketDetail : Screen("ticket_detail/{ticketId}") {
        fun createRoute(ticketId: String) = "ticket_detail/$ticketId"
    }
    object CreateTicket : Screen("create_ticket")
    object Profile : Screen("profile")
    object Settings : Screen("settings")
}