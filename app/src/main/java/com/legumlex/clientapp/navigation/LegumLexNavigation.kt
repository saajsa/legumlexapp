package com.legumlex.clientapp.navigation

import androidx.compose.runtime.Composable
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import com.legumlex.clientapp.screens.*
import com.legumlex.clientapp.viewmodels.*

@Composable
fun LegumLexNavigation(
    navController: NavHostController,
    startDestination: String = Screen.Dashboard.route
) {
    NavHost(
        navController = navController,
        startDestination = startDestination
    ) {
        composable(Screen.Dashboard.route) {
            val viewModel: DashboardViewModel = viewModel()
            DashboardScreen(
                viewModel = viewModel,
                onNavigateToCases = { navController.navigate(Screen.Cases.route) },
                onNavigateToDocuments = { navController.navigate(Screen.Documents.route) },
                onNavigateToInvoices = { navController.navigate(Screen.Invoices.route) },
                onNavigateToTickets = { navController.navigate(Screen.Tickets.route) },
                onNavigateToCaseDetail = { caseId ->
                    navController.navigate(Screen.CaseDetail.createRoute(caseId))
                },
                onNavigateToInvoiceDetail = { invoiceId ->
                    navController.navigate(Screen.InvoiceDetail.createRoute(invoiceId))
                }
            )
        }
        
        composable(Screen.Cases.route) {
            val viewModel: CaseViewModel = viewModel()
            CasesScreen(
                viewModel = viewModel,
                onNavigateBack = { navController.popBackStack() },
                onNavigateToCaseDetail = { caseId ->
                    navController.navigate(Screen.CaseDetail.createRoute(caseId))
                }
            )
        }
        
        composable(Screen.CaseDetail.route) { backStackEntry ->
            val caseId = backStackEntry.arguments?.getString("caseId") ?: ""
            val viewModel: CaseViewModel = viewModel()
            CaseDetailScreen(
                caseId = caseId,
                viewModel = viewModel,
                onNavigateBack = { navController.popBackStack() },
                onNavigateToDocument = { documentId ->
                    navController.navigate(Screen.DocumentDetail.createRoute(documentId))
                }
            )
        }
        
        composable(Screen.Documents.route) {
            val viewModel: DocumentViewModel = viewModel()
            DocumentsScreen(
                viewModel = viewModel,
                onNavigateBack = { navController.popBackStack() },
                onNavigateToDocumentDetail = { documentId ->
                    navController.navigate(Screen.DocumentDetail.createRoute(documentId))
                }
            )
        }
        
        composable(Screen.DocumentDetail.route) { backStackEntry ->
            val documentId = backStackEntry.arguments?.getString("documentId") ?: ""
            val viewModel: DocumentViewModel = viewModel()
            DocumentDetailScreen(
                documentId = documentId,
                viewModel = viewModel,
                onNavigateBack = { navController.popBackStack() }
            )
        }
        
        composable(Screen.Invoices.route) {
            val viewModel: InvoiceViewModel = viewModel()
            InvoicesScreen(
                viewModel = viewModel,
                onNavigateBack = { navController.popBackStack() },
                onNavigateToInvoiceDetail = { invoiceId ->
                    navController.navigate(Screen.InvoiceDetail.createRoute(invoiceId))
                }
            )
        }
        
        composable(Screen.InvoiceDetail.route) { backStackEntry ->
            val invoiceId = backStackEntry.arguments?.getString("invoiceId") ?: ""
            val viewModel: InvoiceViewModel = viewModel()
            InvoiceDetailScreen(
                invoiceId = invoiceId,
                viewModel = viewModel,
                onNavigateBack = { navController.popBackStack() }
            )
        }
        
        composable(Screen.Tickets.route) {
            val viewModel: TicketViewModel = viewModel()
            TicketsScreen(
                viewModel = viewModel,
                onNavigateBack = { navController.popBackStack() },
                onNavigateToTicketDetail = { ticketId ->
                    navController.navigate(Screen.TicketDetail.createRoute(ticketId))
                },
                onNavigateToCreateTicket = {
                    navController.navigate(Screen.CreateTicket.route)
                }
            )
        }
        
        composable(Screen.TicketDetail.route) { backStackEntry ->
            val ticketId = backStackEntry.arguments?.getString("ticketId") ?: ""
            val viewModel: TicketViewModel = viewModel()
            TicketDetailScreen(
                ticketId = ticketId,
                viewModel = viewModel,
                onNavigateBack = { navController.popBackStack() }
            )
        }
        
        composable(Screen.CreateTicket.route) {
            val viewModel: TicketViewModel = viewModel()
            CreateTicketScreen(
                viewModel = viewModel,
                onNavigateBack = { navController.popBackStack() },
                onTicketCreated = { 
                    navController.popBackStack()
                    navController.navigate(Screen.Tickets.route)
                }
            )
        }
        
        composable(Screen.Profile.route) {
            ProfileScreen(
                onNavigateBack = { navController.popBackStack() }
            )
        }
        
        composable(Screen.Settings.route) {
            SettingsScreen(
                onNavigateBack = { navController.popBackStack() }
            )
        }
    }
}