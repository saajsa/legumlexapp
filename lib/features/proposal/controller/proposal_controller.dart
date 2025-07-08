import 'dart:async';
import 'dart:convert';
import 'package:legumlex_customer/common/components/snack_bar/show_custom_snackbar.dart';
import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/features/proposal/model/proposal_details_model.dart';
import 'package:legumlex_customer/features/proposal/model/proposal_model.dart';
import 'package:legumlex_customer/features/proposal/repo/proposal_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProposalController extends GetxController {
  ProposalRepo proposalRepo;
  ProposalController({required this.proposalRepo});

  bool isLoading = true;
  bool isSubmitLoading = false;
  ProposalsModel proposalsModel = ProposalsModel();
  ProposalDetailsModel proposalDetailsModel = ProposalDetailsModel();

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = shouldLoad ? true : false;
    update();

    await loadProposals();
    isLoading = false;
    update();
  }

  Future<void> loadProposals() async {
    ResponseModel responseModel = await proposalRepo.getAllProposals();
    if (responseModel.status) {
      proposalsModel =
          ProposalsModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {
      CustomSnackBar.error(errorList: [responseModel.message.tr]);
    }
    isLoading = false;
    update();
  }

  Future<void> loadProposalDetails(proposalId) async {
    ResponseModel responseModel =
        await proposalRepo.getProposalDetails(proposalId);
    if (responseModel.status) {
      proposalDetailsModel =
          ProposalDetailsModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();
  }

  TextEditingController commentController = TextEditingController();
  FocusNode commentFocusNode = FocusNode();

  Future<void> addProposalComment(proposalId) async {
    String comment = commentController.text.toString();

    if (comment.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterComment.tr]);
      return;
    }

    isSubmitLoading = true;
    update();

    ResponseModel responseModel =
        await proposalRepo.postProposalComment(proposalId, comment);
    if (responseModel.status) {
      Get.back();
      await loadProposalDetails(proposalId);
      CustomSnackBar.success(successList: [responseModel.message.tr]);
    } else {
      CustomSnackBar.error(errorList: [responseModel.message.tr]);
      return;
    }

    isSubmitLoading = false;
    update();
  }

  void clearData() {
    isLoading = false;
    commentController.text = '';
  }
}
