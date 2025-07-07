package com.legumlex.clientapp.services

import com.legumlex.clientapp.utils.ApiConfig
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

class ApiClient {
    
    companion object {
        @Volatile
        private var INSTANCE: PerfexApiService? = null
        
        fun getInstance(): PerfexApiService {
            return INSTANCE ?: synchronized(this) {
                INSTANCE ?: buildApiService().also { INSTANCE = it }
            }
        }
        
        private fun buildApiService(): PerfexApiService {
            val client = OkHttpClient.Builder()
                .addInterceptor(createAuthInterceptor())
                .addInterceptor(createLoggingInterceptor())
                .connectTimeout(ApiConfig.TIMEOUT_SECONDS, TimeUnit.SECONDS)
                .readTimeout(ApiConfig.TIMEOUT_SECONDS, TimeUnit.SECONDS)
                .writeTimeout(ApiConfig.TIMEOUT_SECONDS, TimeUnit.SECONDS)
                .build()
            
            return Retrofit.Builder()
                .baseUrl(ApiConfig.BASE_URL)
                .client(client)
                .addConverterFactory(GsonConverterFactory.create())
                .build()
                .create(PerfexApiService::class.java)
        }
        
        private fun createAuthInterceptor(): Interceptor {
            return Interceptor { chain ->
                val original = chain.request()
                val requestBuilder = original.newBuilder()
                    .header(ApiConfig.Headers.CONTENT_TYPE, ApiConfig.ContentTypes.JSON)
                    .header(ApiConfig.Headers.ACCEPT, ApiConfig.ContentTypes.JSON)
                    .header(ApiConfig.Headers.USER_AGENT, ApiConfig.USER_AGENT_VALUE)
                    .header(ApiConfig.Headers.AUTH_TOKEN, ApiConfig.API_TOKEN)
                
                val request = requestBuilder.build()
                chain.proceed(request)
            }
        }
        
        private fun createLoggingInterceptor(): HttpLoggingInterceptor {
            return HttpLoggingInterceptor().apply {
                level = HttpLoggingInterceptor.Level.BODY
            }
        }
    }
}