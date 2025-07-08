package com.legumlex.clientapp.di

import android.content.Context
import com.legumlex.clientapp.SimpleLoginViewModel
import com.legumlex.clientapp.services.CustomerAuthManager
import com.legumlex.clientapp.viewmodels.DashboardViewModel
import com.legumlex.clientapp.viewmodels.InvoicesViewModel
import com.legumlex.clientapp.services.CustomerRepository

class AppContainer(private val context: Context) {
    
    // Authentication and repositories
    val authManager: CustomerAuthManager by lazy {
        CustomerAuthManager(context)
    }
    
    val customerRepository: CustomerRepository by lazy {
        CustomerRepository(context)
    }
    
    // ViewModels
    fun createLoginViewModel(): SimpleLoginViewModel {
        return SimpleLoginViewModel(authManager)
    }
    
    fun createDashboardViewModel(): DashboardViewModel {
        return DashboardViewModel(customerRepository)
    }
    
    fun createInvoicesViewModel(): InvoicesViewModel {
        return InvoicesViewModel(customerRepository)
    }
}