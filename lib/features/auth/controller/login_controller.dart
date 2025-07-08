import 'dart:convert';
import 'package:legumlex_customer/common/components/snack_bar/show_custom_snackbar.dart';
import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/helper/shared_preference_helper.dart';
import 'package:legumlex_customer/core/route/route.dart';
import 'package:legumlex_customer/features/auth/model/login_response_model.dart';
import 'package:legumlex_customer/features/auth/repo/auth_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  AuthRepo loginRepo;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  TextEditingController emailController =
      TextEditingController(text: 'manjeet.kaur55555@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: 'm.kaur55555');

  String? email;
  String? password;
  bool remember = false;

  LoginController({required this.loginRepo});

  Future<void> checkAndGotoNextStep(LoginModel responseModel) async {
    if (remember) {
      await loginRepo.apiClient.sharedPreferences
          .setBool(SharedPreferenceHelper.rememberMeKey, true);
    } else {
      await loginRepo.apiClient.sharedPreferences
          .setBool(SharedPreferenceHelper.rememberMeKey, false);
    }

    await loginRepo.apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.userIdKey,
        responseModel.data?.contactId.toString() ?? '-1');
    await loginRepo.apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.accessTokenKey,
        responseModel.data?.accessToken ?? '');

    Get.offAndToNamed(RouteHelper.dashboardScreen);

    if (remember) {
      changeRememberMe();
    }
  }

  bool isSubmitLoading = false;
  void loginUser() async {
    isSubmitLoading = true;
    update();

    ResponseModel responseModel = await loginRepo.loginUser(
        emailController.text.toString(), passwordController.text.toString());

    if (responseModel.status) {
      LoginModel loginModel =
          LoginModel.fromJson(jsonDecode(responseModel.responseJson));
      checkAndGotoNextStep(loginModel);
    } else {
      CustomSnackBar.error(errorList: [responseModel.message.tr]);
    }
    isSubmitLoading = false;
    update();
  }

  changeRememberMe() {
    remember = !remember;
    update();
  }

  void clearTextField() {
    emailController.text = '';
    passwordController.text = '';
    if (remember) {
      remember = false;
    }
    update();
  }
}
