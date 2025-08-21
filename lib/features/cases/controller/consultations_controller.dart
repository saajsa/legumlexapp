import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legumlexapp/features/cases/model/consultation_model.dart';
import 'package:legumlexapp/features/cases/repo/consultations_repo.dart';

class ConsultationsController extends ChangeNotifier {
  ConsultationsRepo get _consultationsRepo => Get.find<ConsultationsRepo>();
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  List<ConsultationModel> _consultations = [];
  List<ConsultationModel> get consultations => _consultations;
  
  ConsultationModel? _selectedConsultation;
  ConsultationModel? get selectedConsultation => _selectedConsultation;
  
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  
  // Fetch all consultations for the client
  Future<void> fetchConsultations() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      final response = await _consultationsRepo.getConsultations();
      
      if (response.status == true && response.data != null) {
        _consultations = response.data!;
      } else {
        _errorMessage = response.message ?? 'Failed to load consultations';
      }
    } catch (e) {
      _errorMessage = 'Error occurred while fetching consultations: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Fetch a specific consultation by ID
  Future<void> fetchConsultationById(int consultationId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      final response = await _consultationsRepo.getConsultationById(consultationId);
      
      if (response.status == true && response.data != null && response.data!.isNotEmpty) {
        _selectedConsultation = response.data!.first;
      } else {
        _errorMessage = response.message ?? 'Failed to load consultation';
      }
    } catch (e) {
      _errorMessage = 'Error occurred while fetching consultation: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Clear selected consultation
  void clearSelectedConsultation() {
    _selectedConsultation = null;
    notifyListeners();
  }
  
  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}