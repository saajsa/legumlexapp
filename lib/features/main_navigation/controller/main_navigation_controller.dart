import 'dart:convert';
import 'package:legumlex_customer/features/main_navigation/repo/main_navigation_repo.dart';
import 'package:legumlex_customer/features/menu/model/menu_model.dart';
import 'package:get/get.dart';

class MainNavigationController extends GetxController {
  MainNavigationRepo repo;
  
  MainNavigationController({required this.repo});

  bool isLoading = false;
  bool _permissionsLoaded = false;
  
  bool get permissionsLoaded => _permissionsLoaded;
  
  // Feature toggles - these will be loaded from the API
  // Start with false to prevent showing tabs before permissions are loaded
  bool isProjectsEnable = false;
  bool isInvoicesEnable = false;
  bool isContractsEnable = false;
  bool isProposalsEnable = false;
  bool isSupportEnable = false;
  bool isEstimatesEnable = false;
  bool isCasesEnable = false;

  @override
  void onInit() {
    super.onInit();
    loadFeatureToggles();
  }

  Future<void> loadFeatureToggles() async {
    isLoading = true;
    update();
    
    try {
      // Load feature toggles from API
      final response = await repo.getFeatureToggles();
      
      print('=== PERMISSION API RESPONSE ===');
      print('Status: ${response.status}');
      print('Response JSON: ${response.responseJson}');
      
      if (response.status) {
        MenuModel menuModel = MenuModel.fromJson(jsonDecode(response.responseJson));
        
        // Log available menu items
        print('Available menu items:');
        menuModel.data?.forEach((item) {
          print('- ${item.name} (${item.shortName})');
        });
        
        isProjectsEnable = menuModel.data!.any((item) => item.name == 'Projects');
        isInvoicesEnable = menuModel.data!.any((item) => item.name == 'Invoices');
        isContractsEnable = menuModel.data!.any((item) => item.name == 'Contracts');
        isProposalsEnable = menuModel.data!.any((item) => item.name == 'Proposals');
        isSupportEnable = menuModel.data!.any((item) => item.name == 'Support');
        isEstimatesEnable = menuModel.data!.any((item) => item.name == 'Estimates');
        isCasesEnable = menuModel.data!.any((item) => item.name == 'Cases');
        
        // Log final permissions state
        print('=== PERMISSIONS STATE ===');
        print('Projects: $isProjectsEnable');
        print('Invoices: $isInvoicesEnable');
        print('Contracts: $isContractsEnable');
        print('Proposals: $isProposalsEnable');
        print('Support: $isSupportEnable');
        print('Estimates: $isEstimatesEnable');
        print('Cases: $isCasesEnable');
        
        _permissionsLoaded = true;
      } else {
        print('=== API RESPONSE ERROR ===');
        print('Status: false - ${response.responseJson}');
        _permissionsLoaded = true;
      }
    } catch (e) {
      print('=== API CALL EXCEPTION ===');
      print('Error: $e');
      
      // Default to all disabled if API fails to prevent showing unauthorized content
      isProjectsEnable = false;
      isInvoicesEnable = false;
      isContractsEnable = false;
      isProposalsEnable = false;
      isSupportEnable = false;
      isEstimatesEnable = false;
      isCasesEnable = false;
      _permissionsLoaded = true;
    }
    
    isLoading = false;
    update();
  }

  // Navigation helpers
  List<String> getEnabledFeatures() {
    List<String> features = ['dashboard']; // Always enabled
    
    if (isProjectsEnable) features.add('projects');
    if (isInvoicesEnable) features.add('invoices');
    if (isSupportEnable) features.add('support');
    if (isCasesEnable) features.add('cases');
    
    features.add('profile'); // Always enabled
    
    return features;
  }

  int getNavigationItemCount() {
    int count = 2; // Dashboard + Profile (always available)
    
    if (isProjectsEnable) count++;
    if (isInvoicesEnable) count++;
    if (isSupportEnable) count++;
    if (isCasesEnable) count++;
    
    return count;
  }
}