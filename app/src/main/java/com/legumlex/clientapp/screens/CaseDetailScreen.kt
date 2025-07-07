package com.legumlex.clientapp.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.legumlex.clientapp.models.Case
import com.legumlex.clientapp.models.Hearing
import com.legumlex.clientapp.models.LegalDocument
import com.legumlex.clientapp.ui.components.LegumLexCard
import com.legumlex.clientapp.ui.components.LegumLexCardElevation
import com.legumlex.clientapp.ui.components.StatusChip

@Composable
fun CaseDetailScreen(
    caseId: String,
    viewModel: CaseDetailViewModel,
    onNavigateBack: () -> Unit,
    onNavigateToDocument: (String) -> Unit,
    onNavigateToHearing: (String) -> Unit
) {
    val case by viewModel.case.collectAsStateWithLifecycle()
    val hearings by viewModel.hearings.collectAsStateWithLifecycle()
    val documents by viewModel.documents.collectAsStateWithLifecycle()
    val isLoading by viewModel.isLoading.collectAsStateWithLifecycle()
    val error by viewModel.error.collectAsStateWithLifecycle()
    
    LaunchedEffect(caseId) {
        viewModel.loadCaseDetails(caseId)
    }
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.White)
            .padding(16.dp)
    ) {
        // Header with back button
        Row(
            modifier = Modifier.fillMaxWidth(),
            verticalAlignment = Alignment.CenterVertically
        ) {
            IconButton(onClick = onNavigateBack) {
                Icon(
                    imageVector = Icons.Default.ArrowBack,
                    contentDescription = "Back",
                    tint = MaterialTheme.colorScheme.primary
                )
            }
            Spacer(modifier = Modifier.width(8.dp))
            Text(
                text = "Case Details",
                style = MaterialTheme.typography.headlineMedium.copy(
                    fontWeight = FontWeight.Bold
                ),
                color = MaterialTheme.colorScheme.onSurface
            )
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        when {
            isLoading -> {
                Box(
                    modifier = Modifier.fillMaxSize(),
                    contentAlignment = Alignment.Center
                ) {
                    CircularProgressIndicator(
                        color = MaterialTheme.colorScheme.primary
                    )
                }
            }
            
            error != null -> {
                ErrorSection(
                    error = error!!,
                    onRetry = { viewModel.loadCaseDetails(caseId) }
                )
            }
            
            case != null -> {
                LazyColumn(
                    verticalArrangement = Arrangement.spacedBy(16.dp)
                ) {
                    // Case Info Section
                    item {
                        CaseInfoSection(case = case!!)
                    }
                    
                    // Hearings Section
                    item {
                        SectionHeader(
                            title = "Hearings",
                            count = hearings.size,
                            icon = Icons.Default.Gavel
                        )
                    }
                    
                    if (hearings.isEmpty()) {
                        item {
                            EmptyStateCard(
                                message = "No hearings scheduled",
                                icon = Icons.Default.Gavel
                            )
                        }
                    } else {
                        items(hearings) { hearing ->
                            HearingCard(
                                hearing = hearing,
                                onClick = { onNavigateToHearing(hearing.id) }
                            )
                        }
                    }
                    
                    // Documents Section
                    item {
                        SectionHeader(
                            title = "Documents",
                            count = documents.size,
                            icon = Icons.Default.Description
                        )
                    }
                    
                    if (documents.isEmpty()) {
                        item {
                            EmptyStateCard(
                                message = "No documents available",
                                icon = Icons.Default.Description
                            )
                        }
                    } else {
                        items(documents) { document ->
                            DocumentCard(
                                document = document,
                                onClick = { onNavigateToDocument(document.id) }
                            )
                        }
                    }
                }
            }
        }
    }
}

@Composable
private fun CaseInfoSection(case: Case) {
    LegumLexCard(
        elevation = LegumLexCardElevation.Medium,
        modifier = Modifier.fillMaxWidth()
    ) {
        Column(
            modifier = Modifier.padding(20.dp)
        ) {
            Text(
                text = case.displayName,
                style = MaterialTheme.typography.headlineSmall.copy(
                    fontWeight = FontWeight.W600
                ),
                color = MaterialTheme.colorScheme.onSurface
            )
            
            Spacer(modifier = Modifier.height(8.dp))
            
            StatusChip(status = case.statusText)
            
            Spacer(modifier = Modifier.height(16.dp))
            
            // Case details grid
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                Column(modifier = Modifier.weight(1f)) {
                    InfoItem(
                        label = "Client",
                        value = case.clientName ?: "Not specified"
                    )
                    Spacer(modifier = Modifier.height(12.dp))
                    InfoItem(
                        label = "Court",
                        value = case.courtDisplay ?: "Not assigned"
                    )
                }
                
                Column(modifier = Modifier.weight(1f)) {
                    InfoItem(
                        label = "Date Filed",
                        value = case.formattedDateFiled
                    )
                    Spacer(modifier = Modifier.height(12.dp))
                    InfoItem(
                        label = "Judge",
                        value = case.judgeName ?: "Not assigned"
                    )
                }
            }
            
            if (!case.consultationReference.isNullOrBlank()) {
                Spacer(modifier = Modifier.height(16.dp))
                InfoItem(
                    label = "Consultation Reference",
                    value = case.consultationReference!!
                )
            }
        }
    }
}

@Composable
private fun SectionHeader(
    title: String,
    count: Int,
    icon: androidx.compose.ui.graphics.vector.ImageVector
) {
    Row(
        modifier = Modifier.fillMaxWidth(),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Icon(
            imageVector = icon,
            contentDescription = title,
            tint = MaterialTheme.colorScheme.primary,
            modifier = Modifier.size(24.dp)
        )
        Spacer(modifier = Modifier.width(8.dp))
        Text(
            text = title,
            style = MaterialTheme.typography.titleLarge.copy(
                fontWeight = FontWeight.W600
            ),
            color = MaterialTheme.colorScheme.onSurface
        )
        Spacer(modifier = Modifier.width(8.dp))
        Badge {
            Text(
                text = count.toString(),
                style = MaterialTheme.typography.labelSmall
            )
        }
    }
}

@Composable
private fun HearingCard(
    hearing: Hearing,
    onClick: () -> Unit
) {
    LegumLexCard(
        onClick = onClick,
        elevation = LegumLexCardElevation.Default,
        modifier = Modifier.fillMaxWidth()
    ) {
        Column(
            modifier = Modifier.padding(16.dp)
        ) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.Top
            ) {
                Column(modifier = Modifier.weight(1f)) {
                    Text(
                        text = hearing.hearingTypeFormatted,
                        style = MaterialTheme.typography.titleMedium.copy(
                            fontWeight = FontWeight.W600
                        ),
                        color = MaterialTheme.colorScheme.onSurface
                    )
                    Spacer(modifier = Modifier.height(4.dp))
                    Text(
                        text = hearing.fullCourtLocation,
                        style = MaterialTheme.typography.bodyMedium,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
                StatusChip(status = hearing.statusText)
            }
            
            Spacer(modifier = Modifier.height(12.dp))
            
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                InfoItem(
                    label = "Date",
                    value = hearing.hearingDate
                )
                InfoItem(
                    label = "Time",
                    value = hearing.hearingTime ?: "TBD"
                )
            }
        }
    }
}

@Composable
private fun DocumentCard(
    document: LegalDocument,
    onClick: () -> Unit
) {
    LegumLexCard(
        onClick = onClick,
        elevation = LegumLexCardElevation.Default,
        modifier = Modifier.fillMaxWidth()
    ) {
        Row(
            modifier = Modifier.padding(16.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            // Document type icon
            Icon(
                imageVector = when {
                    document.isPdf -> Icons.Default.PictureAsPdf
                    document.isImage -> Icons.Default.Image
                    document.isWord -> Icons.Default.Description
                    else -> Icons.Default.InsertDriveFile
                },
                contentDescription = "Document",
                tint = MaterialTheme.colorScheme.primary,
                modifier = Modifier.size(32.dp)
            )
            
            Spacer(modifier = Modifier.width(12.dp))
            
            Column(modifier = Modifier.weight(1f)) {
                Text(
                    text = document.displayName,
                    style = MaterialTheme.typography.titleMedium.copy(
                        fontWeight = FontWeight.W600
                    ),
                    color = MaterialTheme.colorScheme.onSurface
                )
                Spacer(modifier = Modifier.height(4.dp))
                Text(
                    text = document.documentTypeFormatted,
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
                if (!document.description.isNullOrBlank()) {
                    Spacer(modifier = Modifier.height(2.dp))
                    Text(
                        text = document.description!!,
                        style = MaterialTheme.typography.bodySmall,
                        color = MaterialTheme.colorScheme.onSurfaceVariant,
                        maxLines = 2
                    )
                }
            }
            
            Column(horizontalAlignment = Alignment.End) {
                Text(
                    text = document.fileSizeFormatted,
                    style = MaterialTheme.typography.labelSmall,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
                Spacer(modifier = Modifier.height(4.dp))
                StatusChip(status = document.statusText)
            }
        }
    }
}

@Composable
private fun InfoItem(
    label: String,
    value: String
) {
    Column {
        Text(
            text = label,
            style = MaterialTheme.typography.labelSmall,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )
        Spacer(modifier = Modifier.height(2.dp))
        Text(
            text = value,
            style = MaterialTheme.typography.bodyMedium,
            color = MaterialTheme.colorScheme.onSurface
        )
    }
}

@Composable
private fun EmptyStateCard(
    message: String,
    icon: androidx.compose.ui.graphics.vector.ImageVector
) {
    LegumLexCard(
        elevation = LegumLexCardElevation.Low,
        modifier = Modifier.fillMaxWidth()
    ) {
        Column(
            modifier = Modifier.padding(24.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Icon(
                imageVector = icon,
                contentDescription = message,
                tint = MaterialTheme.colorScheme.onSurfaceVariant,
                modifier = Modifier.size(48.dp)
            )
            Spacer(modifier = Modifier.height(12.dp))
            Text(
                text = message,
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }
    }
}

@Composable
private fun ErrorSection(
    error: String,
    onRetry: () -> Unit
) {
    Column(
        modifier = Modifier.fillMaxSize(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Card(
            colors = CardDefaults.cardColors(
                containerColor = MaterialTheme.colorScheme.errorContainer
            ),
            modifier = Modifier.fillMaxWidth()
        ) {
            Column(
                modifier = Modifier.padding(16.dp),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                Icon(
                    imageVector = Icons.Default.Error,
                    contentDescription = "Error",
                    tint = MaterialTheme.colorScheme.error,
                    modifier = Modifier.size(48.dp)
                )
                Spacer(modifier = Modifier.height(16.dp))
                Text(
                    text = "Failed to load case details",
                    style = MaterialTheme.typography.headlineSmall,
                    color = MaterialTheme.colorScheme.onErrorContainer
                )
                Spacer(modifier = Modifier.height(8.dp))
                Text(
                    text = error,
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onErrorContainer
                )
                Spacer(modifier = Modifier.height(16.dp))
                Button(
                    onClick = onRetry,
                    colors = ButtonDefaults.buttonColors(
                        containerColor = MaterialTheme.colorScheme.primary
                    )
                ) {
                    Text("Retry")
                }
            }
        }
    }
}