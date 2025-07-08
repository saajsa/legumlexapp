import 'dart:convert';
import 'package:legumlex_customer/common/components/snack_bar/show_custom_snackbar.dart';
import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/features/knowledge/model/knowledge_details_model.dart';
import 'package:legumlex_customer/features/privacy/repo/privacy_repo.dart';
import 'package:get/get.dart';

class PrivacyController extends GetxController {
  PrivacyRepo privacyRepo;
  bool isLoading = true;
  KnowledgeBaseDetailsModel privacyModel = KnowledgeBaseDetailsModel();
  PrivacyController({required this.privacyRepo});

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = shouldLoad ? true : false;
    update();

    await loadData();
    isLoading = false;
    update();
  }

  Future<void> loadData() async {
    ResponseModel responseModel = await privacyRepo.loadPrivacyData();
    if (responseModel.status) {
      privacyModel = KnowledgeBaseDetailsModel.fromJson(
          jsonDecode(responseModel.responseJson));
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();
  }
}
