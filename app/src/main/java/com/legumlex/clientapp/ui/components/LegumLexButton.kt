package com.legumlex.clientapp.ui.components

import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.legumlex.clientapp.ui.theme.LegumLexPrimary
import com.legumlex.clientapp.ui.theme.LegumLexPrimaryVariant

@Composable
fun LegumLexButton(
    text: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    variant: LegumLexButtonVariant = LegumLexButtonVariant.Primary
) {
    val (backgroundColor, contentColor) = when (variant) {
        LegumLexButtonVariant.Primary -> LegumLexPrimary to Color.White
        LegumLexButtonVariant.Secondary -> Color.Transparent to LegumLexPrimary
        LegumLexButtonVariant.Outline -> Color.Transparent to LegumLexPrimary
    }
    
    Button(
        onClick = onClick,
        modifier = modifier
            .height(56.dp), // Similar to website button height
        enabled = enabled,
        shape = RoundedCornerShape(4.dp), // border-radius: 4px from website
        colors = ButtonDefaults.buttonColors(
            containerColor = backgroundColor,
            contentColor = contentColor,
            disabledContainerColor = Color.Gray,
            disabledContentColor = Color.White
        ),
        contentPadding = PaddingValues(
            horizontal = 32.dp, // Similar to website 50px padding
            vertical = 16.dp    // Similar to website 19px padding
        ),
        elevation = when (variant) {
            LegumLexButtonVariant.Primary -> ButtonDefaults.buttonElevation(
                defaultElevation = 2.dp,
                pressedElevation = 4.dp
            )
            else -> ButtonDefaults.buttonElevation(0.dp)
        }
    ) {
        Text(
            text = text,
            fontSize = 16.sp, // Close to website 1.125em
            fontWeight = FontWeight.W500, // font-weight: 500 from website
            letterSpacing = 0.04.sp // letter-spacing: 0.04em from website
        )
    }
}

@Composable
fun LegumLexSecondaryButton(
    text: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true
) {
    OutlinedButton(
        onClick = onClick,
        modifier = modifier
            .height(56.dp),
        enabled = enabled,
        shape = RoundedCornerShape(4.dp),
        colors = ButtonDefaults.outlinedButtonColors(
            contentColor = LegumLexPrimary,
            disabledContentColor = Color.Gray
        ),
        border = ButtonDefaults.outlinedButtonBorder.copy(
            brush = androidx.compose.ui.graphics.SolidColor(LegumLexPrimary)
        ),
        contentPadding = PaddingValues(
            horizontal = 32.dp,
            vertical = 16.dp
        )
    ) {
        Text(
            text = text,
            fontSize = 16.sp,
            fontWeight = FontWeight.W500,
            letterSpacing = 0.04.sp
        )
    }
}

enum class LegumLexButtonVariant {
    Primary,
    Secondary,
    Outline
}