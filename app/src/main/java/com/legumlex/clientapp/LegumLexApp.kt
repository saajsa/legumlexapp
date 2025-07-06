package com.legumlex.clientapp

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.compose.rememberNavController
import com.legumlex.clientapp.navigation.LegumLexNavigation
import com.legumlex.clientapp.navigation.Screen
import com.legumlex.clientapp.navigation.bottomNavItems
import com.legumlex.clientapp.ui.components.LegumLexBottomBar
import com.legumlex.clientapp.ui.components.LegumLexTopBar
import com.legumlex.clientapp.ui.theme.LegumLexClientAppTheme

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun LegumLexApp() {
    LegumLexClientAppTheme {
        val navController = rememberNavController()
        val navBackStackEntry by navController.currentBackStackEntryAsState()
        val currentRoute = navBackStackEntry?.destination?.route
        
        // Determine if we should show bottom navigation
        val showBottomBar = currentRoute in bottomNavItems.map { it.route }
        
        // Determine if we should show back button
        val showBackButton = when (currentRoute) {
            Screen.Dashboard.route,
            Screen.Cases.route,
            Screen.Documents.route,
            Screen.Invoices.route,
            Screen.Tickets.route -> false
            else -> true
        }
        
        // Get title based on current route
        val title = when (currentRoute) {
            Screen.Dashboard.route -> "LegumLex Portal"
            Screen.Cases.route -> "My Cases"
            Screen.CaseDetail.route -> "Case Details"
            Screen.Documents.route -> "Documents"
            Screen.DocumentDetail.route -> "Document"
            Screen.Invoices.route -> "Invoices"
            Screen.InvoiceDetail.route -> "Invoice Details"
            Screen.Tickets.route -> "Support Tickets"
            Screen.TicketDetail.route -> "Ticket Details"
            Screen.CreateTicket.route -> "Create Ticket"
            Screen.Profile.route -> "Profile"
            Screen.Settings.route -> "Settings"
            else -> "LegumLex Portal"
        }
        
        Scaffold(
            modifier = Modifier.fillMaxSize(),
            topBar = {
                LegumLexTopBar(
                    title = title,
                    navController = navController,
                    showBackButton = showBackButton
                )
            },
            bottomBar = {
                if (showBottomBar) {
                    LegumLexBottomBar(navController = navController)
                }
            },
            containerColor = MaterialTheme.colorScheme.background
        ) { innerPadding ->
            LegumLexNavigation(
                navController = navController,
                modifier = Modifier.padding(innerPadding)
            )
        }
    }
}

@Composable
private fun LegumLexNavigation(
    navController: androidx.navigation.NavHostController,
    modifier: Modifier = Modifier
) {
    LegumLexNavigation(
        navController = navController,
        startDestination = Screen.Dashboard.route
    )
}