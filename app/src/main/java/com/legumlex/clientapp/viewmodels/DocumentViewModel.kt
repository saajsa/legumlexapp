package com.legumlex.clientapp.viewmodels

import androidx.lifecycle.viewModelScope
import com.legumlex.clientapp.models.Document
import com.legumlex.clientapp.services.ApiResult
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

data class DocumentUiState(
    val documents: List<Document> = emptyList(),
    val selectedDocument: Document? = null,
    val isLoadingDocuments: Boolean = false,
    val isLoadingDocument: Boolean = false,
    val isDownloadingFile: Boolean = false,
    val searchQuery: String = "",
    val filteredDocuments: List<Document> = emptyList(),
    val selectedFilter: DocumentFilter = DocumentFilter.ALL,
    val selectedCategory: String = "All"
)

enum class DocumentFilter {
    ALL, IMAGES, PDFS, DOCUMENTS, SPREADSHEETS, PRESENTATIONS
}

class DocumentViewModel : BaseViewModel() {
    
    private val _uiState = MutableStateFlow(DocumentUiState())
    val uiState: StateFlow<DocumentUiState> = _uiState.asStateFlow()
    
    init {
        loadDocuments()
    }
    
    fun loadDocuments() {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isLoadingDocuments = true)
            
            when (val result = repository.getDocuments()) {
                is ApiResult.Success -> {
                    _uiState.value = _uiState.value.copy(
                        documents = result.data,
                        filteredDocuments = filterDocuments(
                            result.data, 
                            _uiState.value.selectedFilter, 
                            _uiState.value.searchQuery,
                            _uiState.value.selectedCategory
                        ),
                        isLoadingDocuments = false
                    )
                }
                is ApiResult.Error -> {
                    _uiState.value = _uiState.value.copy(isLoadingDocuments = false)
                    setError("Failed to load documents: ${result.message}")
                }
                is ApiResult.Loading -> {
                    _uiState.value = _uiState.value.copy(isLoadingDocuments = true)
                }
            }
        }
    }
    
    fun loadDocumentDetails(documentId: String) {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isLoadingDocument = true)
            
            when (val result = repository.getDocument(documentId)) {
                is ApiResult.Success -> {
                    _uiState.value = _uiState.value.copy(
                        selectedDocument = result.data,
                        isLoadingDocument = false
                    )
                }
                is ApiResult.Error -> {
                    _uiState.value = _uiState.value.copy(isLoadingDocument = false)
                    setError("Failed to load document: ${result.message}")
                }
                is ApiResult.Loading -> {
                    _uiState.value = _uiState.value.copy(isLoadingDocument = true)
                }
            }
        }
    }
    
    fun downloadDocument(documentId: String) {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isDownloadingFile = true)
            
            when (val result = repository.downloadFile(documentId)) {
                is ApiResult.Success -> {
                    _uiState.value = _uiState.value.copy(isDownloadingFile = false)
                    // Handle download success
                    // This would typically involve saving the file or opening it
                }
                is ApiResult.Error -> {
                    _uiState.value = _uiState.value.copy(isDownloadingFile = false)
                    setError("Failed to download file: ${result.message}")
                }
                is ApiResult.Loading -> {
                    _uiState.value = _uiState.value.copy(isDownloadingFile = true)
                }
            }
        }
    }
    
    fun searchDocuments(query: String) {
        _uiState.value = _uiState.value.copy(
            searchQuery = query,
            filteredDocuments = filterDocuments(
                _uiState.value.documents, 
                _uiState.value.selectedFilter, 
                query,
                _uiState.value.selectedCategory
            )
        )
    }
    
    fun filterDocuments(filter: DocumentFilter) {
        _uiState.value = _uiState.value.copy(
            selectedFilter = filter,
            filteredDocuments = filterDocuments(
                _uiState.value.documents, 
                filter, 
                _uiState.value.searchQuery,
                _uiState.value.selectedCategory
            )
        )
    }
    
    fun filterByCategory(category: String) {
        _uiState.value = _uiState.value.copy(
            selectedCategory = category,
            filteredDocuments = filterDocuments(
                _uiState.value.documents, 
                _uiState.value.selectedFilter, 
                _uiState.value.searchQuery,
                category
            )
        )
    }
    
    private fun filterDocuments(
        documents: List<Document>, 
        filter: DocumentFilter, 
        searchQuery: String,
        category: String
    ): List<Document> {
        var filteredDocuments = when (filter) {
            DocumentFilter.ALL -> documents
            DocumentFilter.IMAGES -> documents.filter { it.isImage }
            DocumentFilter.PDFS -> documents.filter { it.isPdf }
            DocumentFilter.DOCUMENTS -> documents.filter { it.isDocument }
            DocumentFilter.SPREADSHEETS -> documents.filter { it.isSpreadsheet }
            DocumentFilter.PRESENTATIONS -> documents.filter { it.isPresentation }
        }
        
        if (category != "All") {
            filteredDocuments = filteredDocuments.filter { it.category == category }
        }
        
        if (searchQuery.isNotBlank()) {
            filteredDocuments = filteredDocuments.filter { document ->
                document.displayName.contains(searchQuery, ignoreCase = true) ||
                document.description?.contains(searchQuery, ignoreCase = true) == true ||
                document.tagsList.any { it.contains(searchQuery, ignoreCase = true) }
            }
        }
        
        return filteredDocuments.sortedByDescending { it.dateAdded }
    }
    
    fun getAvailableCategories(): List<String> {
        val categories = _uiState.value.documents.mapNotNull { it.category }.distinct().sorted()
        return listOf("All") + categories
    }
    
    fun selectDocument(document: Document) {
        _uiState.value = _uiState.value.copy(selectedDocument = document)
    }
    
    fun clearSelectedDocument() {
        _uiState.value = _uiState.value.copy(selectedDocument = null)
    }
    
    fun refreshDocuments() {
        loadDocuments()
    }
    
    fun clearError() {
        super.clearError()
    }
}