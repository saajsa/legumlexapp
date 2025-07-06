package com.legumlex.clientapp.services

import com.legumlex.clientapp.utils.ApiConfig
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

object ApiClient {
    
    private val authInterceptor = Interceptor { chain ->
        val newRequest = chain.request().newBuilder()
            .addHeader(ApiConfig.Headers.AUTH_TOKEN, ApiConfig.API_TOKEN)
            .addHeader(ApiConfig.Headers.CONTENT_TYPE, ApiConfig.ContentTypes.JSON)
            .addHeader(ApiConfig.Headers.ACCEPT, ApiConfig.ContentTypes.JSON)
            .addHeader(ApiConfig.Headers.USER_AGENT, ApiConfig.USER_AGENT_VALUE)
            .build()
        chain.proceed(newRequest)
    }
    
    private val loggingInterceptor = HttpLoggingInterceptor().apply {
        level = HttpLoggingInterceptor.Level.BODY
    }
    
    private val okHttpClient = OkHttpClient.Builder()
        .addInterceptor(authInterceptor)
        .addInterceptor(loggingInterceptor)
        .connectTimeout(ApiConfig.TIMEOUT_SECONDS, TimeUnit.SECONDS)
        .readTimeout(ApiConfig.TIMEOUT_SECONDS, TimeUnit.SECONDS)
        .writeTimeout(ApiConfig.TIMEOUT_SECONDS, TimeUnit.SECONDS)
        .build()
    
    private val retrofit = Retrofit.Builder()
        .baseUrl(ApiConfig.BASE_URL)
        .client(okHttpClient)
        .addConverterFactory(GsonConverterFactory.create())
        .build()
    
    val apiService: ApiService = retrofit.create(ApiService::class.java)
    
    // Create a separate client for file downloads without timeout restrictions
    private val downloadOkHttpClient = OkHttpClient.Builder()
        .addInterceptor(authInterceptor)
        .connectTimeout(ApiConfig.TIMEOUT_SECONDS, TimeUnit.SECONDS)
        .readTimeout(5, TimeUnit.MINUTES) // Longer timeout for file downloads
        .writeTimeout(5, TimeUnit.MINUTES)
        .build()
    
    private val downloadRetrofit = Retrofit.Builder()
        .baseUrl(ApiConfig.BASE_URL)
        .client(downloadOkHttpClient)
        .build()
    
    val downloadService: ApiService = downloadRetrofit.create(ApiService::class.java)
}