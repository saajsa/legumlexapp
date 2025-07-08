package com.legumlex.clientapp.services

import com.legumlex.clientapp.utils.ApiConfig
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit
import java.net.SocketTimeoutException
import java.net.UnknownHostException
import android.util.Log

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
                .addInterceptor(createErrorInterceptor())
                .connectTimeout(ApiConfig.TIMEOUT_SECONDS, TimeUnit.SECONDS)
                .readTimeout(ApiConfig.TIMEOUT_SECONDS, TimeUnit.SECONDS)
                .writeTimeout(ApiConfig.TIMEOUT_SECONDS, TimeUnit.SECONDS)
                .retryOnConnectionFailure(true)
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
                    .header(ApiConfig.Headers.X_REQUESTED_WITH, "XMLHttpRequest")
                
                val request = requestBuilder.build()
                chain.proceed(request)
            }
        }
        
        private fun createLoggingInterceptor(): HttpLoggingInterceptor {
            return HttpLoggingInterceptor().apply {
                level = if (BuildConfig.DEBUG) HttpLoggingInterceptor.Level.BODY else HttpLoggingInterceptor.Level.NONE
            }
        }
        
        private fun createErrorInterceptor(): Interceptor {
            return Interceptor { chain ->
                val request = chain.request()
                try {
                    val response = chain.proceed(request)
                    
                    // Log specific error cases
                    when (response.code) {
                        401 -> Log.w("ApiClient", "Unauthorized: Check API token")
                        403 -> Log.w("ApiClient", "Forbidden: Check permissions and endpoint")
                        404 -> Log.w("ApiClient", "Not Found: Check endpoint URL")
                        500 -> Log.e("ApiClient", "Server Error: Internal server error")
                    }
                    
                    response
                } catch (e: Exception) {
                    Log.e("ApiClient", "Network error: ${e.message}", e)
                    throw e
                }
            }
        }
    }
}