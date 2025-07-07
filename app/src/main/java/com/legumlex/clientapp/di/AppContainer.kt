package com.legumlex.clientapp.di

import android.content.Context
import com.legumlex.clientapp.SimpleAuthManager
import com.legumlex.clientapp.SimpleRepository
import com.legumlex.clientapp.SimpleLoginViewModel
import com.legumlex.clientapp.SimpleDashboardViewModel
import com.legumlex.clientapp.SimpleCasesViewModel
import com.legumlex.clientapp.SimpleDocumentsViewModel
import com.legumlex.clientapp.SimpleInvoicesViewModel
import com.legumlex.clientapp.SimpleTicketsViewModel

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
    
    fun createCasesViewModel(): SimpleCasesViewModel {
        return SimpleCasesViewModel(repository)
    }
    
    fun createDocumentsViewModel(): SimpleDocumentsViewModel {
        return SimpleDocumentsViewModel(repository)
    }
    
    fun createInvoicesViewModel(): SimpleInvoicesViewModel {
        return SimpleInvoicesViewModel(repository)
    }
    
    fun createTicketsViewModel(): SimpleTicketsViewModel {
        return SimpleTicketsViewModel(repository)
    }
}