import 'package:legumlex_customer/features/main_navigation/repo/main_navigation_repo.dart';
import 'package:get/get.dart';

class MainNavigationController extends GetxController {
  MainNavigationRepo repo;
  
  MainNavigationController({required this.repo});

  bool isLoading = false;
  
  // Feature toggles - these will be loaded from the API
  bool isProjectsEnable = true;
  bool isInvoicesEnable = true;
  bool isContractsEnable = true;
  bool isProposalsEnable = true;
  bool isSupportEnable = true;
  bool isEstimatesEnable = true;

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
      
      if (response.status) {
        final data = response.data;
        isProjectsEnable = data['projects_enable'] ?? true;
        isInvoicesEnable = data['invoices_enable'] ?? true;
        isContractsEnable = data['contracts_enable'] ?? true;
        isProposalsEnable = data['proposals_enable'] ?? true;
        isSupportEnable = data['support_enable'] ?? true;
        isEstimatesEnable = data['estimates_enable'] ?? true;
      }
    } catch (e) {
      // Default to all enabled if API fails
      isProjectsEnable = true;
      isInvoicesEnable = true;
      isContractsEnable = true;
      isProposalsEnable = true;
      isSupportEnable = true;
      isEstimatesEnable = true;
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
    
    features.add('profile'); // Always enabled
    
    return features;
  }

  int getNavigationItemCount() {
    int count = 2; // Dashboard + Profile (always available)
    
    if (isProjectsEnable) count++;
    if (isInvoicesEnable) count++;
    if (isSupportEnable) count++;
    
    return count;
  }
}