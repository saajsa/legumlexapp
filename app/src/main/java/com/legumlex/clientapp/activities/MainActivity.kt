package com.legumlex.clientapp.activities

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.runtime.Composable
import androidx.compose.ui.tooling.preview.Preview
import com.legumlex.clientapp.LegumLexApp
import com.legumlex.clientapp.ui.theme.LegumLexClientAppTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            LegumLexApp()
        }
    }
}

@Preview(showBackground = true)
@Composable
fun LegumLexAppPreview() {
    LegumLexClientAppTheme {
        LegumLexApp()
    }
}