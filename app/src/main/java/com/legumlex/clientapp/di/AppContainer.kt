package com.legumlex.clientapp.di

import android.content.Context
import com.legumlex.clientapp.SimpleAuthManager
import com.legumlex.clientapp.SimpleRepository
import com.legumlex.clientapp.SimpleLoginViewModel
import com.legumlex.clientapp.viewmodels.DashboardViewModel
import com.legumlex.clientapp.viewmodels.InvoicesViewModel
import com.legumlex.clientapp.services.ClientRepository

class AppContainer(private val context: Context) {
    
    // Authentication and repositories
    val authManager: SimpleAuthManager by lazy {
        SimpleAuthManager(context)
    }
    
    val clientRepository: ClientRepository by lazy {
        ClientRepository(context)
    }
    
    // ViewModels
    fun createLoginViewModel(): SimpleLoginViewModel {
        return SimpleLoginViewModel(authManager)
    }
    
    fun createDashboardViewModel(): DashboardViewModel {
        return DashboardViewModel(clientRepository)
    }
    
    fun createInvoicesViewModel(): InvoicesViewModel {
        return InvoicesViewModel(clientRepository)
    }
}