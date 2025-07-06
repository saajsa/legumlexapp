package com.legumlex.clientapp

import android.app.Application
import dagger.hilt.android.HiltAndroidApp

@HiltAndroidApp
class LegumLexApplication : Application() {
    
    override fun onCreate() {
        super.onCreate()
    }
}