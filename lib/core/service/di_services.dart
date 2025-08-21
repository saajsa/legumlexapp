import 'package:legumlex_customer/common/controllers/localization_controller.dart';
import 'package:legumlex_customer/common/controllers/theme_controller.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/features/cases/controller/cases_controller.dart';
import 'package:legumlex_customer/features/cases/controller/consultations_controller.dart';
import 'package:legumlex_customer/features/cases/controller/documents_controller.dart';
import 'package:legumlex_customer/features/cases/repo/cases_repo.dart';
import 'package:legumlex_customer/features/cases/repo/consultations_repo.dart';
import 'package:legumlex_customer/features/cases/repo/documents_repo.dart';
import 'package:legumlex_customer/features/splash/controller/splash_controller.dart';
import 'package:legumlex_customer/features/splash/repo/splash_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, Map<String, String>>> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences, fenix: true);
  Get.lazyPut(() => ApiClient(sharedPreferences: Get.find()));
  Get.lazyPut(() => CasesRepo());
  Get.lazyPut(() => ConsultationsRepo());
  Get.lazyPut(() => DocumentsRepo());
  Get.lazyPut(() => SplashRepo(apiClient: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(
      apiClient: Get.find(), localizationController: Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => CasesController());
  Get.lazyPut(() => ConsultationsController());
  Get.lazyPut(() => DocumentsController());

  Map<String, Map<String, String>> language = {};
  language['en_US'] = {'': ''};

  return language;
}
