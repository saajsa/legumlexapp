import 'package:legumlex_customer/common/components/snack_bar/show_custom_snackbar.dart';
import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/route/route.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/features/auth/model/sign_up_model.dart';
import 'package:legumlex_customer/features/auth/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  AuthRepo registrationRepo;

  RegistrationController({required this.registrationRepo});

  bool isLoading = true;
  bool agreeTC = false;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode mobileFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode countryNameFocusNode = FocusNode();
  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode companyNameFocusNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();

  RegExp regex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  bool isSubmitLoading = false;

  signUpUser() async {
    String firstName = firstNameController.text.toString();
    String lastName = lastNameController.text.toString();
    String company = companyNameController.text.toString();
    String email = emailController.text.toString();
    String mobile = mobileController.text.toString();
    String password = passwordController.text.toString();
    String confirmPassword = cPasswordController.text.toString();

    if (firstName.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterFirstName.tr]);
    }
    if (lastName.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterLastName.tr]);
    }
    if (email.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterEmail.tr]);
    }
    if (company.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterCompanyName.tr]);
    }
    if (password.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterYourPassword.tr]);
    }

    if (password != confirmPassword) {
      CustomSnackBar.error(errorList: [LocalStrings.passwordMatchError.tr]);
    }

    if (!agreeTC) {
      CustomSnackBar.error(
        errorList: [LocalStrings.agreePolicyMessage.tr],
      );
      return;
    }

    isSubmitLoading = true;
    update();

    SignUpPostModel signUpPostModel = SignUpPostModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
      mobile: mobile,
      company: company,
      password: password,
      rPassword: confirmPassword,
    );

    ResponseModel responseModel =
        await registrationRepo.registerUser(signUpPostModel);
    if (responseModel.status) {
      CustomSnackBar.success(successList: [responseModel.message.tr]);
      Get.offAndToNamed(RouteHelper.loginScreen);
    } else {
      CustomSnackBar.error(errorList: [responseModel.message.tr]);
    }
    isSubmitLoading = false;
    update();
  }

  updateAgreeTC() {
    agreeTC = !agreeTC;
    update();
  }

  void closeAllController() {
    isLoading = false;
    emailController.text = '';
    mobileController.text = '';
    passwordController.text = '';
    cPasswordController.text = '';
    firstNameController.text = '';
    lastNameController.text = '';
    companyNameController.text = '';
  }

  clearAllData() {
    closeAllController();
  }

  void initData() async {
    isLoading = true;
    update();

    isLoading = false;
    update();
  }

  bool noInternet = false;
  void changeInternet(bool hasInternet) {
    noInternet = false;
    initData();
    update();
  }

  bool hasPasswordFocus = false;
  void changePasswordFocus(bool hasFocus) {
    hasPasswordFocus = hasFocus;
    update();
  }

  bool isActiveAccount = true;
  void changeState(bool activeState) {
    isActiveAccount = activeState;
    update();
  }
}
