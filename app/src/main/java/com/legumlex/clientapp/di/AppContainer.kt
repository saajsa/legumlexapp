package com.legumlex.clientapp.di

import android.content.Context
import com.legumlex.clientapp.auth.AuthManager
import com.legumlex.clientapp.services.Repository
import com.legumlex.clientapp.services.ApiService
import com.legumlex.clientapp.utils.ApiConfig
import com.legumlex.clientapp.viewmodels.*
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

class AppContainer(private val context: Context) {
    
    // Network
    private val okHttpClient: OkHttpClient by lazy {
        val loggingInterceptor = HttpLoggingInterceptor().apply {
            level = HttpLoggingInterceptor.Level.BODY
        }
        
        OkHttpClient.Builder()
            .addInterceptor(loggingInterceptor)
            .connectTimeout(30, TimeUnit.SECONDS)
            .readTimeout(30, TimeUnit.SECONDS)
            .writeTimeout(30, TimeUnit.SECONDS)
            .build()
    }
    
    private val retrofit: Retrofit by lazy {
        Retrofit.Builder()
            .baseUrl(ApiConfig.BASE_URL)
            .client(okHttpClient)
            .addConverterFactory(GsonConverterFactory.create())
            .build()
    }
    
    val apiService: ApiService by lazy {
        retrofit.create(ApiService::class.java)
    }
    
    // Auth
    val authManager: AuthManager by lazy {
        AuthManager(context, apiService)
    }
    
    // Repository
    val repository: Repository by lazy {
        Repository(apiService, context)
    }
    
    // ViewModels
    fun createLoginViewModel(): LoginViewModel {
        return LoginViewModel(authManager)
    }
    
    fun createDashboardViewModel(): DashboardViewModel {
        return DashboardViewModel(repository)
    }
    
    fun createCasesViewModel(): CasesViewModel {
        return CasesViewModel(repository)
    }
    
    fun createDocumentsViewModel(): DocumentsViewModel {
        return DocumentsViewModel(repository)
    }
    
    fun createInvoicesViewModel(): InvoicesViewModel {
        return InvoicesViewModel(repository)
    }
    
    fun createTicketsViewModel(): TicketsViewModel {
        return TicketsViewModel(repository)
    }
    
    fun createProfileViewModel(): ProfileViewModel {
        return ProfileViewModel(repository, authManager)
    }
}