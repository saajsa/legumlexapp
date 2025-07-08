import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:legumlex_customer/common/components/snack_bar/show_custom_snackbar.dart';
import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/features/contract/model/contract_details_model.dart';
import 'package:legumlex_customer/features/contract/model/contract_model.dart';
import 'package:legumlex_customer/features/contract/model/sign_contract_model.dart';
import 'package:legumlex_customer/features/contract/repo/contract_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:signature/signature.dart';

class ContractController extends GetxController {
  ContractRepo contractRepo;
  ContractController({required this.contractRepo});

  bool isLoading = true;
  bool isSubmitLoading = false;
  ContractsModel contractsModel = ContractsModel();
  ContractDetailsModel contractDetailsModel = ContractDetailsModel();

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = shouldLoad ? true : false;
    update();

    await loadContracts();
    isLoading = false;
    update();
  }

  Future<void> loadContracts() async {
    ResponseModel responseModel = await contractRepo.getAllContracts();
    contractsModel =
        ContractsModel.fromJson(jsonDecode(responseModel.responseJson));
    isLoading = false;
    update();
  }

  Future<void> loadContractDetails(projectId) async {
    ResponseModel responseModel =
        await contractRepo.getContractDetails(projectId);
    if (responseModel.status) {
      contractDetailsModel =
          ContractDetailsModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {
      CustomSnackBar.error(errorList: [responseModel.message.tr]);
    }

    isLoading = false;
    update();
  }

  TextEditingController commentController = TextEditingController();
  FocusNode commentFocusNode = FocusNode();

  Future<void> addContractComment(contractId) async {
    String comment = commentController.text.toString();

    if (comment.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterComment.tr]);
      return;
    }

    isSubmitLoading = true;
    update();

    ResponseModel responseModel =
        await contractRepo.postContractComment(contractId, comment);
    if (responseModel.status) {
      Get.back();
      await loadContractDetails(contractId);
      CustomSnackBar.success(successList: [responseModel.message.tr]);
    } else {
      CustomSnackBar.error(errorList: [responseModel.message.tr]);
      return;
    }

    isSubmitLoading = false;
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

  Future<void> signContract(contractId) async {
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

    SignContractModel signContractModel = SignContractModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
      ipAddress: wifiIP,
      signature: signature,
    );

    ResponseModel responseModel =
        await contractRepo.signContract(contractId, signContractModel);
    if (responseModel.status) {
      Get.back();
      await loadContractDetails(contractId);
      CustomSnackBar.success(successList: [responseModel.message.tr]);
      await loadContracts();
    } else {
      CustomSnackBar.error(errorList: [(responseModel.message.tr)]);
    }

    isSubmitLoading = false;
    update();
  }

  void clearData() {
    isLoading = false;
    commentController.text = '';
  }
}
