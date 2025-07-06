package com.legumlex.clientapp

import android.app.Application
import com.legumlex.clientapp.di.AppContainer

class LegumLexApplication : Application() {
    
    val appContainer: AppContainer by lazy {
        AppContainer(this)
    }
    
    override fun onCreate() {
        super.onCreate()
    }
}