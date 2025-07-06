package com.legumlex.clientapp.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.legumlex.clientapp.ui.theme.*

@Composable
fun StatusChip(
    status: String,
    modifier: Modifier = Modifier
) {
    val (backgroundColor, textColor) = when (status.lowercase()) {
        "open", "1", "not started" -> StatusOpen to Color.White
        "in progress", "2", "in_progress" -> StatusInProgress to Color.White
        "completed", "4", "paid" -> StatusCompleted to Color.White
        "closed", "5", "cancelled" -> StatusClosed to Color.White
        "overdue", "unpaid" -> StatusOverdue to Color.White
        "on hold", "3" -> StatusInProgress to Color.White
        "answered" -> LegumLexSuccess to Color.White
        else -> MaterialTheme.colorScheme.surfaceVariant to MaterialTheme.colorScheme.onSurfaceVariant
    }
    
    Box(
        modifier = modifier
            .clip(RoundedCornerShape(12.dp))
            .background(backgroundColor)
            .padding(horizontal = 8.dp, vertical = 4.dp),
        contentAlignment = Alignment.Center
    ) {
        Text(
            text = status,
            color = textColor,
            fontSize = 12.sp,
            fontWeight = FontWeight.Medium
        )
    }
}

@Composable
fun PriorityChip(
    priority: String,
    modifier: Modifier = Modifier
) {
    val (backgroundColor, textColor) = when (priority.lowercase()) {
        "low", "1" -> PriorityLow to Color.White
        "medium", "2" -> PriorityMedium to Color.White
        "high", "3" -> PriorityHigh to Color.White
        "urgent", "4" -> PriorityUrgent to Color.White
        else -> MaterialTheme.colorScheme.surfaceVariant to MaterialTheme.colorScheme.onSurfaceVariant
    }
    
    Box(
        modifier = modifier
            .clip(RoundedCornerShape(12.dp))
            .background(backgroundColor)
            .padding(horizontal = 8.dp, vertical = 4.dp),
        contentAlignment = Alignment.Center
    ) {
        Text(
            text = priority,
            color = textColor,
            fontSize = 12.sp,
            fontWeight = FontWeight.Medium
        )
    }
}