import 'dart:async';
import 'dart:convert';
import 'package:legumlex_customer/common/components/snack_bar/show_custom_snackbar.dart';
import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/features/knowledge/model/knowledge_details_model.dart';
import 'package:legumlex_customer/features/knowledge/model/knowledge_model.dart';
import 'package:legumlex_customer/features/knowledge/repo/knowledge_repo.dart';
import 'package:get/get.dart';

class KnowledgeController extends GetxController {
  KnowledgeRepo knowledgeRepo;
  KnowledgeController({required this.knowledgeRepo});

  bool isLoading = true;
  int? selectButton = -1;
  KnowledgeBasesModel knowledgeBaseModel = KnowledgeBasesModel();
  KnowledgeBaseDetailsModel knowledgeBaseDetailsModel =
      KnowledgeBaseDetailsModel();

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = shouldLoad ? true : false;
    update();

    await loadKnowledgeBase();
    isLoading = false;
    update();
  }

  Future<void> loadKnowledgeBase() async {
    ResponseModel responseModel = await knowledgeRepo.getAllKnowledgeBase();
    knowledgeBaseModel =
        KnowledgeBasesModel.fromJson(jsonDecode(responseModel.responseJson));

    isLoading = false;
    update();
  }

  Future<void> loadKnowledgeBaseDetails(slug) async {
    ResponseModel responseModel =
        await knowledgeRepo.getKnowledgeBaseDetails(slug);
    if (responseModel.status) {
      knowledgeBaseDetailsModel = KnowledgeBaseDetailsModel.fromJson(
          jsonDecode(responseModel.responseJson));
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();
  }

  void changeColorListNameTimeline(int selected) {
    selectButton = selected;
    update();
  }

  Future<void> getKnowledgeBaseByGroupSlugName(slugName) async {
    isLoading = true;
    update();
    ResponseModel responseModel =
        await knowledgeRepo.getKnowledgeBaseBySlug(slugName);

    knowledgeBaseModel =
        KnowledgeBasesModel.fromJson(jsonDecode(responseModel.responseJson));
    isLoading = false;
    update();
  }
}
