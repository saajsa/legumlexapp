package com.legumlex.clientapp

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.legumlex.clientapp.screens.DashboardScreen
import com.legumlex.clientapp.screens.LoginScreen

@Composable
fun LegumLexApp(appContainer: AppContainer) {
    val authManager = appContainer.authManager
    val isLoggedIn by authManager.isLoggedIn.collectAsStateWithLifecycle()
    
    if (isLoggedIn) {
        // Main app content
        val dashboardViewModel = appContainer.createDashboardViewModel()
        DashboardScreen(
            viewModel = dashboardViewModel,
            onNavigateToCases = { /* TODO */ },
            onNavigateToDocuments = { /* TODO */ },
            onNavigateToInvoices = { /* TODO */ },
            onNavigateToTickets = { /* TODO */ },
            onNavigateToCaseDetail = { /* TODO */ },
            onNavigateToInvoiceDetail = { /* TODO */ }
        )
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