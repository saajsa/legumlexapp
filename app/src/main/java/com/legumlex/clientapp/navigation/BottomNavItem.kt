package com.legumlex.clientapp.navigation

import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.ui.graphics.vector.ImageVector

data class BottomNavItem(
    val name: String,
    val route: String,
    val icon: ImageVector,
    val selectedIcon: ImageVector = icon
)

val bottomNavItems = listOf(
    BottomNavItem(
        name = "Dashboard",
        route = Screen.Dashboard.route,
        icon = Icons.Default.Home
    ),
    BottomNavItem(
        name = "Cases",
        route = Screen.Cases.route,
        icon = Icons.Default.FolderOpen,
        selectedIcon = Icons.Default.FolderOpen
    ),
    BottomNavItem(
        name = "Documents",
        route = Screen.Documents.route,
        icon = Icons.Default.Article
    ),
    BottomNavItem(
        name = "Invoices",
        route = Screen.Invoices.route,
        icon = Icons.Default.Payment
    ),
    BottomNavItem(
        name = "Tickets",
        route = Screen.Tickets.route,
        icon = Icons.Default.Help
    )
)