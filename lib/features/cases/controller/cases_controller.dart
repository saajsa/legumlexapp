import 'package:get/get.dart';
import 'package:legumlex_customer/features/cases/model/case_model.dart';
import 'package:legumlex_customer/features/cases/model/consultation_model.dart';
import 'package:legumlex_customer/features/cases/model/document_model.dart';
import 'package:legumlex_customer/features/cases/model/hearing_model.dart';
import 'package:legumlex_customer/features/cases/repo/cases_repo.dart';

class CasesController extends GetxController {
  CasesRepo get _casesRepo => Get.find<CasesRepo>();
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  List<CaseModel> _cases = <CaseModel>[].obs;
  List<CaseModel> get cases => _cases;
  
  CaseModel? _selectedCase;
  CaseModel? get selectedCase => _selectedCase;
  
  List<HearingModel> _hearings = <HearingModel>[].obs;
  List<HearingModel> get hearings => _hearings;
  
  List<DocumentModel> _documents = <DocumentModel>[].obs;
  List<DocumentModel> get documents => _documents;
  
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  
  // Fetch all cases for the client
  Future<void> fetchCases() async {
    _isLoading = true;
    _errorMessage = null;
    update();
    
    try {
      final response = await _casesRepo.getCases();
      
      if (response.status == true && response.data != null) {
        _cases.assignAll(response.data!);
      } else {
        _errorMessage = response.message ?? 'Failed to load cases';
      }
    } catch (e) {
      _errorMessage = 'Error occurred while fetching cases: $e';
    } finally {
      _isLoading = false;
      update();
    }
  }
  
  // Fetch a specific case by ID
  Future<void> fetchCaseById(int caseId) async {
    _isLoading = true;
    _errorMessage = null;
    update();
    
    try {
      final response = await _casesRepo.getCaseById(caseId);
      
      if (response.status == true && response.data != null && response.data!.isNotEmpty) {
        _selectedCase = response.data!.first;
      } else {
        _errorMessage = response.message ?? 'Failed to load case';
      }
    } catch (e) {
      _errorMessage = 'Error occurred while fetching case: $e';
    } finally {
      _isLoading = false;
      update();
    }
  }
  
  // Fetch hearings for a specific case
  Future<void> fetchCaseHearings(int caseId) async {
    _isLoading = true;
    _errorMessage = null;
    update();
    
    try {
      final response = await _casesRepo.getCaseHearings(caseId);
      
      if (response.status == true && response.data != null) {
        _hearings.assignAll(response.data!);
      } else {
        _errorMessage = response.message ?? 'Failed to load hearings';
      }
    } catch (e) {
      _errorMessage = 'Error occurred while fetching hearings: $e';
    } finally {
      _isLoading = false;
      update();
    }
  }
  
  // Fetch documents for a specific case
  Future<void> fetchCaseDocuments(int caseId) async {
    _isLoading = true;
    _errorMessage = null;
    update();
    
    try {
      final response = await _casesRepo.getCaseDocuments(caseId);
      
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
  
  // Clear selected case
  void clearSelectedCase() {
    _selectedCase = null;
    update();
  }
  
  // Clear error message
  void clearError() {
    _errorMessage = null;
    update();
  }
}