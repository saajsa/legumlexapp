package com.legumlex.clientapp.ui.components

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import com.legumlex.clientapp.ui.theme.LegumLexSurfaceVariant

@Composable
fun LegumLexCard(
    modifier: Modifier = Modifier,
    onClick: (() -> Unit)? = null,
    elevation: LegumLexCardElevation = LegumLexCardElevation.Default,
    content: @Composable ColumnScope.() -> Unit
) {
    val elevationDp = when (elevation) {
        LegumLexCardElevation.None -> 0.dp
        LegumLexCardElevation.Low -> 1.dp
        LegumLexCardElevation.Default -> 2.dp
        LegumLexCardElevation.Medium -> 4.dp
        LegumLexCardElevation.High -> 8.dp // Similar to website box-shadow: 0 10px 20px rgba(52, 51, 82, 0.08)
    }
    
    Card(
        modifier = modifier
            .fillMaxWidth()
            .then(
                if (onClick != null) {
                    Modifier.clickable { onClick() }
                } else {
                    Modifier
                }
            ),
        shape = RoundedCornerShape(4.dp), // Consistent with button border-radius
        colors = CardDefaults.cardColors(
            containerColor = Color.White,
            contentColor = MaterialTheme.colorScheme.onSurface
        ),
        elevation = CardDefaults.cardElevation(
            defaultElevation = elevationDp
        )
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(20.dp), // Similar to website padding: 23px 30px 30px
            content = content
        )
    }
}

@Composable
fun LegumLexSurfaceCard(
    modifier: Modifier = Modifier,
    onClick: (() -> Unit)? = null,
    content: @Composable ColumnScope.() -> Unit
) {
    Card(
        modifier = modifier
            .fillMaxWidth()
            .then(
                if (onClick != null) {
                    Modifier.clickable { onClick() }
                } else {
                    Modifier
                }
            ),
        shape = RoundedCornerShape(4.dp),
        colors = CardDefaults.cardColors(
            containerColor = LegumLexSurfaceVariant, // #f4f4f4 from website
            contentColor = MaterialTheme.colorScheme.onSurface
        ),
        elevation = CardDefaults.cardElevation(
            defaultElevation = 0.dp
        )
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(24.dp),
            content = content
        )
    }
}

@Composable
fun LegumLexInfoCard(
    title: String,
    subtitle: String? = null,
    content: @Composable ColumnScope.() -> Unit
) {
    LegumLexCard(
        elevation = LegumLexCardElevation.Default
    ) {
        Text(
            text = title,
            style = MaterialTheme.typography.titleMedium,
            color = MaterialTheme.colorScheme.onSurface
        )
        
        if (subtitle != null) {
            Spacer(modifier = Modifier.height(4.dp))
            Text(
                text = subtitle,
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }
        
        Spacer(modifier = Modifier.height(12.dp))
        content()
    }
}

enum class LegumLexCardElevation {
    None,
    Low,
    Default,
    Medium,
    High
}