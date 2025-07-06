package com.legumlex.clientapp.di

import android.content.Context
import com.legumlex.clientapp.SimpleAuthManager
import com.legumlex.clientapp.SimpleRepository
import com.legumlex.clientapp.SimpleLoginViewModel
import com.legumlex.clientapp.SimpleDashboardViewModel

class AppContainer(private val context: Context) {
    
    // Simple implementations
    val authManager: SimpleAuthManager by lazy {
        SimpleAuthManager(context)
    }
    
    val repository: SimpleRepository by lazy {
        SimpleRepository()
    }
    
    // ViewModels
    fun createLoginViewModel(): SimpleLoginViewModel {
        return SimpleLoginViewModel(authManager)
    }
    
    fun createDashboardViewModel(): SimpleDashboardViewModel {
        return SimpleDashboardViewModel(repository)
    }
}