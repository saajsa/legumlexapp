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
import com.legumlex.clientapp.ui.components.LegumLexCard
import com.legumlex.clientapp.ui.components.LegumLexInfoCard
import com.legumlex.clientapp.ui.components.LegumLexButton
import com.legumlex.clientapp.ui.components.LegumLexCardElevation
import com.legumlex.clientapp.SimpleDashboardViewModel
import com.legumlex.clientapp.DashboardStats

@Composable
fun DashboardScreen(
    viewModel: SimpleDashboardViewModel,
    onNavigateToCases: () -> Unit,
    onNavigateToDocuments: () -> Unit,
    onNavigateToInvoices: () -> Unit,
    onNavigateToTickets: () -> Unit,
    onNavigateToCaseDetail: (String) -> Unit,
    onNavigateToInvoiceDetail: (String) -> Unit
) {
    val stats by viewModel.stats.collectAsStateWithLifecycle()
    val isLoading by viewModel.isLoading.collectAsStateWithLifecycle()
    
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
                        LegumLexCard(
                            modifier = Modifier.weight(1f),
                            onClick = { onNavigateToCases() },
                            elevation = LegumLexCardElevation.Default
                        ) {
                            Icon(
                                imageVector = Icons.Default.Folder,
                                contentDescription = "Cases",
                                tint = MaterialTheme.colorScheme.primary,
                                modifier = Modifier.size(32.dp)
                            )
                            Spacer(modifier = Modifier.height(12.dp))
                            Text(
                                text = stats.activeCases.toString(),
                                style = MaterialTheme.typography.headlineMedium.copy(
                                    fontWeight = FontWeight.W600
                                ),
                                color = MaterialTheme.colorScheme.onSurface
                            )
                            Text(
                                text = "Active Cases",
                                style = MaterialTheme.typography.bodyMedium,
                                color = MaterialTheme.colorScheme.onSurfaceVariant
                            )
                        }
                        LegumLexCard(
                            modifier = Modifier.weight(1f),
                            onClick = { onNavigateToInvoices() },
                            elevation = LegumLexCardElevation.Default
                        ) {
                            Icon(
                                imageVector = Icons.Default.Receipt,
                                contentDescription = "Invoices",
                                tint = MaterialTheme.colorScheme.primary,
                                modifier = Modifier.size(32.dp)
                            )
                            Spacer(modifier = Modifier.height(12.dp))
                            Text(
                                text = stats.unpaidInvoices.toString(),
                                style = MaterialTheme.typography.headlineMedium.copy(
                                    fontWeight = FontWeight.W600
                                ),
                                color = MaterialTheme.colorScheme.onSurface
                            )
                            Text(
                                text = "Unpaid Invoices",
                                style = MaterialTheme.typography.bodyMedium,
                                color = MaterialTheme.colorScheme.onSurfaceVariant
                            )
                        }
                    }
                }
                
                item {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.spacedBy(12.dp)
                    ) {
                        LegumLexCard(
                            modifier = Modifier.weight(1f),
                            onClick = { onNavigateToDocuments() },
                            elevation = LegumLexCardElevation.Default
                        ) {
                            Icon(
                                imageVector = Icons.Default.Description,
                                contentDescription = "Documents",
                                tint = MaterialTheme.colorScheme.primary,
                                modifier = Modifier.size(32.dp)
                            )
                            Spacer(modifier = Modifier.height(12.dp))
                            Text(
                                text = stats.totalDocuments.toString(),
                                style = MaterialTheme.typography.headlineMedium.copy(
                                    fontWeight = FontWeight.W600
                                ),
                                color = MaterialTheme.colorScheme.onSurface
                            )
                            Text(
                                text = "Documents",
                                style = MaterialTheme.typography.bodyMedium,
                                color = MaterialTheme.colorScheme.onSurfaceVariant
                            )
                        }
                        LegumLexCard(
                            modifier = Modifier.weight(1f),
                            onClick = { onNavigateToTickets() },
                            elevation = LegumLexCardElevation.Default
                        ) {
                            Icon(
                                imageVector = Icons.Default.Support,
                                contentDescription = "Support",
                                tint = MaterialTheme.colorScheme.primary,
                                modifier = Modifier.size(32.dp)
                            )
                            Spacer(modifier = Modifier.height(12.dp))
                            Text(
                                text = stats.openTickets.toString(),
                                style = MaterialTheme.typography.headlineMedium.copy(
                                    fontWeight = FontWeight.W600
                                ),
                                color = MaterialTheme.colorScheme.onSurface
                            )
                            Text(
                                text = "Open Tickets",
                                style = MaterialTheme.typography.bodyMedium,
                                color = MaterialTheme.colorScheme.onSurfaceVariant
                            )
                        }
                    }
                }
            }
        }
    }
}