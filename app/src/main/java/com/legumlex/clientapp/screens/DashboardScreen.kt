package com.legumlex.clientapp.screens

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.legumlex.clientapp.ui.components.StatCard
import com.legumlex.clientapp.viewmodels.DashboardViewModel

@Composable
fun DashboardScreen(
    viewModel: DashboardViewModel,
    onNavigateToCases: () -> Unit,
    onNavigateToDocuments: () -> Unit,
    onNavigateToInvoices: () -> Unit,
    onNavigateToTickets: () -> Unit,
    onNavigateToCaseDetail: (String) -> Unit,
    onNavigateToInvoiceDetail: (String) -> Unit
) {
    val uiState by viewModel.uiState.collectAsStateWithLifecycle()
    val isLoading by viewModel.isLoading.collectAsStateWithLifecycle()
    val error by viewModel.error.collectAsStateWithLifecycle()
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
    ) {
        if (isLoading && uiState.recentCases.isEmpty()) {
            Box(
                modifier = Modifier.fillMaxSize(),
                contentAlignment = Alignment.Center
            ) {
                CircularProgressIndicator()
            }
        } else {
            LazyColumn(
                verticalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                item {
                    Text(
                        text = "Welcome to LegumLex",
                        style = MaterialTheme.typography.headlineMedium.copy(
                            fontWeight = FontWeight.Bold
                        ),
                        color = MaterialTheme.colorScheme.onSurface
                    )
                }
                
                item {
                    Text(
                        text = "Your Legal Client Portal",
                        style = MaterialTheme.typography.bodyLarge,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
                
                item {
                    Spacer(modifier = Modifier.height(8.dp))
                }
                
                // Quick Stats Row
                item {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.spacedBy(12.dp)
                    ) {
                        Card(
                            modifier = Modifier
                                .weight(1f)
                                .clickable { onNavigateToCases() }
                        ) {
                            StatCard(
                                title = "Active Cases",
                                value = uiState.summaryStats.activeCases.toString(),
                                icon = Icons.Default.Folder,
                                modifier = Modifier.fillMaxWidth()
                            )
                        }
                        Card(
                            modifier = Modifier
                                .weight(1f)
                                .clickable { onNavigateToInvoices() }
                        ) {
                            StatCard(
                                title = "Unpaid Invoices",
                                value = uiState.summaryStats.unpaidInvoices.toString(),
                                icon = Icons.Default.Receipt,
                                modifier = Modifier.fillMaxWidth()
                            )
                        }
                    }
                }
                
                item {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.spacedBy(12.dp)
                    ) {
                        Card(
                            modifier = Modifier
                                .weight(1f)
                                .clickable { onNavigateToDocuments() }
                        ) {
                            StatCard(
                                title = "Documents",
                                value = uiState.summaryStats.totalDocuments.toString(),
                                icon = Icons.Default.Description,
                                modifier = Modifier.fillMaxWidth()
                            )
                        }
                        Card(
                            modifier = Modifier
                                .weight(1f)
                                .clickable { onNavigateToTickets() }
                        ) {
                            StatCard(
                                title = "Open Tickets",
                                value = uiState.summaryStats.openTickets.toString(),
                                icon = Icons.Default.Support,
                                modifier = Modifier.fillMaxWidth()
                            )
                        }
                    }
                }
                
                // Recent Activity Section
                item {
                    Text(
                        text = "Recent Activity",
                        style = MaterialTheme.typography.titleLarge.copy(
                            fontWeight = FontWeight.SemiBold
                        ),
                        modifier = Modifier.padding(top = 24.dp, bottom = 16.dp)
                    )
                }
                
                if (uiState.recentCases.isEmpty() && uiState.recentInvoices.isEmpty()) {
                    item {
                        Card(
                            modifier = Modifier.fillMaxWidth(),
                            colors = CardDefaults.cardColors(
                                containerColor = MaterialTheme.colorScheme.surfaceVariant
                            )
                        ) {
                            Column(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(24.dp),
                                horizontalAlignment = Alignment.CenterHorizontally
                            ) {
                                Icon(
                                    imageVector = Icons.Default.Home,
                                    contentDescription = null,
                                    tint = MaterialTheme.colorScheme.onSurfaceVariant,
                                    modifier = Modifier.size(48.dp)
                                )
                                Spacer(modifier = Modifier.height(16.dp))
                                Text(
                                    text = "Welcome to your legal client portal",
                                    style = MaterialTheme.typography.titleMedium,
                                    textAlign = TextAlign.Center
                                )
                                Spacer(modifier = Modifier.height(8.dp))
                                Text(
                                    text = "Your cases, documents, invoices, and support tickets will appear here",
                                    style = MaterialTheme.typography.bodyMedium,
                                    textAlign = TextAlign.Center,
                                    color = MaterialTheme.colorScheme.onSurfaceVariant
                                )
                            }
                        }
                    }
                }
            }
        }
        
        // Error handling
        error?.let { errorMessage ->
            LaunchedEffect(errorMessage) {
                // Show snackbar or handle error display
            }
        }
        
        // Pull to refresh
        if (uiState.isRefreshing) {
            LinearProgressIndicator(
                modifier = Modifier.fillMaxWidth()
            )
        }
    }
}