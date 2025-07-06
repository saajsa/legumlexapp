package com.legumlex.clientapp.viewmodels

import com.legumlex.clientapp.services.Repository

class InvoicesViewModel(
    private val repository: Repository
) : BaseViewModel() {
    
    override fun clearError() {
        super.clearError()
    }
}