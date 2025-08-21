import 'package:flutter/material.dart';
import 'package:legumlexapp/features/cases/model/document_model.dart';
import 'package:legumlexapp/features/cases/repo/documents_repo.dart';

class DocumentsController extends ChangeNotifier {
  final DocumentsRepo _documentsRepo = DocumentsRepo();
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  List<DocumentModel> _documents = [];
  List<DocumentModel> get documents => _documents;
  
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  
  // Fetch all documents related to cases
  Future<void> fetchDocuments() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      final response = await _documentsRepo.getDocuments();
      
      if (response.status == true && response.data != null) {
        _documents = response.data!;
      } else {
        _errorMessage = response.message ?? 'Failed to load documents';
      }
    } catch (e) {
      _errorMessage = 'Error occurred while fetching documents: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}