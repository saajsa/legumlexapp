package com.legumlex.clientapp

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.legumlex.clientapp.screens.DashboardScreen
import com.legumlex.clientapp.screens.LoginScreen
import com.legumlex.clientapp.screens.CasesScreen
import com.legumlex.clientapp.di.AppContainer
import com.legumlex.clientapp.navigation.Screen
import com.legumlex.clientapp.ui.components.LegumLexBottomBar

@Composable
fun LegumLexApp(appContainer: AppContainer) {
    val authManager = appContainer.authManager
    val isLoggedIn by authManager.isLoggedIn.collectAsStateWithLifecycle()
    
    if (isLoggedIn) {
        // Main app content with navigation
        MainAppContent(appContainer = appContainer)
    } else {
        // Login screen
        val loginViewModel = appContainer.createLoginViewModel()
        LoginScreen(
            viewModel = loginViewModel,
            onNavigateToMain = { /* Navigation handled by auth state */ }
        )
    }
}

@Composable
fun MainAppContent(appContainer: AppContainer) {
    val navController = rememberNavController()
    
    Scaffold(
        bottomBar = {
            LegumLexBottomBar(navController = navController)
        }
    ) { paddingValues ->
        NavHost(
            navController = navController,
            startDestination = Screen.Dashboard.route,
            modifier = Modifier.padding(paddingValues)
        ) {
            composable(Screen.Dashboard.route) {
                val dashboardViewModel = appContainer.createDashboardViewModel()
                DashboardScreen(
                    viewModel = dashboardViewModel,
                    onNavigateToCases = { 
                        navController.navigate(Screen.Cases.route) 
                    },
                    onNavigateToDocuments = { 
                        navController.navigate(Screen.Documents.route) 
                    },
                    onNavigateToInvoices = { 
                        navController.navigate(Screen.Invoices.route) 
                    },
                    onNavigateToTickets = { 
                        navController.navigate(Screen.Tickets.route) 
                    },
                    onNavigateToCaseDetail = { caseId ->
                        navController.navigate(Screen.CaseDetail.createRoute(caseId))
                    },
                    onNavigateToInvoiceDetail = { invoiceId ->
                        navController.navigate(Screen.InvoiceDetail.createRoute(invoiceId))
                    }
                )
            }
            
            composable(Screen.Cases.route) {
                val casesViewModel = appContainer.createCasesViewModel()
                CasesScreen(
                    viewModel = casesViewModel,
                    onNavigateToCaseDetail = { caseId ->
                        navController.navigate(Screen.CaseDetail.createRoute(caseId))
                    }
                )
            }
            
            composable(Screen.Documents.route) {
                PlaceholderScreen("Documents")
            }
            
            composable(Screen.Invoices.route) {
                PlaceholderScreen("Invoices")
            }
            
            composable(Screen.Tickets.route) {
                PlaceholderScreen("Support Tickets")
            }
            
            composable(Screen.CaseDetail.route) {
                PlaceholderScreen("Case Details")
            }
            
            composable(Screen.InvoiceDetail.route) {
                PlaceholderScreen("Invoice Details")
            }
        }
    }
}

@Composable
fun PlaceholderScreen(title: String) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = title,
            style = MaterialTheme.typography.headlineMedium,
            textAlign = TextAlign.Center
        )
        Spacer(modifier = Modifier.height(16.dp))
        Text(
            text = "Coming Soon",
            style = MaterialTheme.typography.bodyLarge,
            color = MaterialTheme.colorScheme.onSurfaceVariant,
            textAlign = TextAlign.Center
        )
    }
}

