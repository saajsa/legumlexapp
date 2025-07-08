import 'dart:convert';

import 'package:legumlex_customer/common/controllers/localization_controller.dart';
import 'package:legumlex_customer/core/helper/shared_preference_helper.dart';
import 'package:legumlex_customer/core/route/route.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  ApiClient apiClient;
  LocalizationController localizationController;
  bool isLoading = true;

  SplashController(
      {required this.apiClient, required this.localizationController});

  gotoNextPage() async {
    await loadLanguage();
    bool isRemember = apiClient.sharedPreferences
            .getBool(SharedPreferenceHelper.rememberMeKey) ??
        false;
    bool isOnBoard = apiClient.sharedPreferences
            .getBool(SharedPreferenceHelper.onboardKey) ??
        false;
    noInternet = false;
    update();

    getData(isRemember, isOnBoard);
  }

  bool noInternet = false;
  void getData(bool isRemember, bool isOnBoard) async {
    isLoading = false;
    update();

    if (isOnBoard == false) {
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAndToNamed(RouteHelper.onboardScreen);
      });
    } else {
      if (isRemember) {
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAndToNamed(RouteHelper.dashboardScreen);
        });
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAndToNamed(RouteHelper.loginScreen);
        });
      }
    }
  }

  Future<bool> initSharedData() {
    if (!apiClient.sharedPreferences
        .containsKey(SharedPreferenceHelper.countryCode)) {
      return apiClient.sharedPreferences.setString(
          SharedPreferenceHelper.countryCode,
          LocalStrings.appLanguages[0].countryCode);
    }
    if (!apiClient.sharedPreferences
        .containsKey(SharedPreferenceHelper.languageCode)) {
      return apiClient.sharedPreferences.setString(
          SharedPreferenceHelper.languageCode,
          LocalStrings.appLanguages[0].languageCode);
    }
    return Future.value(true);
  }

  Future<void> loadLanguage() async {
    localizationController.loadCurrentLanguage();
    String languageCode = localizationController.locale.languageCode;
    Map<String, Map<String, String>> language = {};
    final String response =
        await rootBundle.loadString('assets/lang/$languageCode.json');
    var resJson = jsonDecode(response);
    saveLanguageList(response);
    var value = resJson as Map<String, dynamic>;
    Map<String, String> json = {};
    value.forEach((key, value) {
      json[key] = value.toString();
    });
    language[
            '${localizationController.locale.languageCode}_${localizationController.locale.countryCode}'] =
        json;
    Get.addTranslations(Messages(languages: language).keys);
  }

  void saveLanguageList(String languageJson) async {
    await apiClient.sharedPreferences
        .setString(SharedPreferenceHelper.languageListKey, languageJson);
    return;
  }
}
