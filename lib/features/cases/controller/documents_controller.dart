import 'package:get/get.dart';
import 'package:legumlex_customer/features/cases/model/document_model.dart';
import 'package:legumlex_customer/features/cases/repo/documents_repo.dart';

class DocumentsController extends GetxController {
  DocumentsRepo get _documentsRepo => Get.find<DocumentsRepo>();
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  List<DocumentModel> _documents = <DocumentModel>[].obs;
  List<DocumentModel> get documents => _documents;
  
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  
  // Fetch all documents related to cases
  Future<void> fetchDocuments() async {
    _isLoading = true;
    _errorMessage = null;
    update();
    
    try {
      final response = await _documentsRepo.getDocuments();
      
      if (response.status == true && response.data != null) {
        _documents.assignAll(response.data!);
      } else {
        _errorMessage = response.message ?? 'Failed to load documents';
      }
    } catch (e) {
      _errorMessage = 'Error occurred while fetching documents: $e';
    } finally {
      _isLoading = false;
      update();
    }
  }
  
  // Clear error message
  void clearError() {
    _errorMessage = null;
    update();
  }
}