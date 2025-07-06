package com.legumlex.clientapp.activities

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import com.legumlex.clientapp.LegumLexApplication
import com.legumlex.clientapp.LegumLexApp
import com.legumlex.clientapp.ui.theme.LegumLexClientAppTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        val appContainer = (application as LegumLexApplication).appContainer
        
        setContent {
            LegumLexClientAppTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    LegumLexApp(appContainer)
                }
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun LegumLexAppPreview() {
    LegumLexClientAppTheme {
        // Preview doesn't need app container
    }
}