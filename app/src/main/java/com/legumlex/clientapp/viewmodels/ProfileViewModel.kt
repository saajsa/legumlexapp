package com.legumlex.clientapp.viewmodels

import com.legumlex.clientapp.auth.AuthManager
import com.legumlex.clientapp.services.Repository

class ProfileViewModel(
    private val repository: Repository,
    private val authManager: AuthManager
) : BaseViewModel() {
    
    override fun clearError() {
        super.clearError()
    }
}