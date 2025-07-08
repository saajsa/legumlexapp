import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:legumlex_customer/common/components/snack_bar/show_custom_snackbar.dart';
import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/features/estimate/model/estimate_accept_model.dart';
import 'package:legumlex_customer/features/estimate/model/estimate_details_model.dart';
import 'package:legumlex_customer/features/estimate/model/estimate_model.dart';
import 'package:legumlex_customer/features/estimate/repo/estimate_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:signature/signature.dart';

class EstimateController extends GetxController {
  EstimateRepo estimateRepo;
  EstimateController({required this.estimateRepo});

  bool isLoading = true;
  bool isSubmitLoading = false;
  EstimatesModel estimatesModel = EstimatesModel();
  EstimateDetailsModel estimateDetailsModel = EstimateDetailsModel();

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = shouldLoad ? true : false;
    update();

    await loadEstimates();
    isLoading = false;
    update();
  }

  Future<void> loadEstimates() async {
    ResponseModel responseModel = await estimateRepo.getAllEstimates();
    estimatesModel =
        EstimatesModel.fromJson(jsonDecode(responseModel.responseJson));
    isLoading = false;
    update();
  }

  Future<void> loadEstimateDetails(estimateId) async {
    ResponseModel responseModel =
        await estimateRepo.getEstimateDetails(estimateId);
    if (responseModel.status) {
      estimateDetailsModel =
          EstimateDetailsModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode signatureFocusNode = FocusNode();

  Future<void> acceptEstimate(estimateId) async {
    String firstName = firstNameController.text.toString();
    String lastName = lastNameController.text.toString();
    String email = emailController.text.toString();
    Uint8List? signatureBase = await signatureController.toPngBytes();
    String signature = base64Encode(signatureBase as List<int>);
    String wifiIP = await NetworkInfo().getWifiIP() ?? '';

    if (firstName.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterFirstName.tr]);
      return;
    }
    if (lastName.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterLastName.tr]);
      return;
    }
    if (email.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterEmail.tr]);
      return;
    }
    if (signatureController.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.pleaseAddSignature.tr]);
    }

    isSubmitLoading = true;
    update();

    EstimateAcceptModel estimateAcceptModel = EstimateAcceptModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
      ipAddress: wifiIP,
      signature: signature,
    );

    ResponseModel responseModel =
        await estimateRepo.acceptEstimate(estimateId, estimateAcceptModel);
    if (responseModel.status) {
      Get.back();
      await loadEstimateDetails(estimateId);
      CustomSnackBar.success(successList: [responseModel.message.tr]);
      await loadEstimates();
    } else {
      CustomSnackBar.error(errorList: [(responseModel.message.tr)]);
    }

    isSubmitLoading = false;
    update();
  }

  // Reject Estimate
  Future<void> rejectEstimate(estimateId) async {
    ResponseModel responseModel = await estimateRepo.rejectEstimate(estimateId);

    isSubmitLoading = true;
    update();

    if (responseModel.status) {
      await loadEstimateDetails(estimateId);
      CustomSnackBar.success(successList: [responseModel.message.tr]);
      await loadEstimates();
    } else {
      CustomSnackBar.error(errorList: [(responseModel.message.tr)]);
    }

    isSubmitLoading = false;
    update();
  }

  void clearData() {
    isLoading = false;
    isSubmitLoading = false;
    firstNameController.text = '';
    lastNameController.text = '';
    emailController.text = '';
    signatureController.clear();
  }
}
