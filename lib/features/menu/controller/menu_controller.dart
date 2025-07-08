import 'dart:convert';
import 'package:legumlex_customer/common/components/snack_bar/show_custom_snackbar.dart';
import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/route/route.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/features/menu/model/menu_model.dart';
import 'package:legumlex_customer/features/menu/repo/menu_repo.dart';
import 'package:get/get.dart';

class MyMenuController extends GetxController {
  MenuRepo menuRepo;
  MyMenuController({required this.menuRepo});

  bool logoutLoading = false;
  bool isLoading = true;
  bool noInternet = false;

  void loadData() async {
    isLoading = true;
    update();
    await loadClientMenu();
    isLoading = false;
    update();
  }

  Future<void> logout() async {
    logoutLoading = true;
    update();

    await menuRepo.logout();
    CustomSnackBar.success(successList: [LocalStrings.logoutSuccessMsg.tr]);

    logoutLoading = false;
    update();
    Get.offAllNamed(RouteHelper.loginScreen);
  }

  bool isInvoicesEnable = true;
  bool isEstimatesEnable = true;
  bool isContractsEnable = true;
  bool isProposalsEnable = true;
  bool isSupportEnable = true;
  bool isProjectsEnable = true;
  MenuModel menuModel = MenuModel();

  Future<void> loadClientMenu() async {
    ResponseModel responseModel = await menuRepo.getClientMenu();
    if (responseModel.status) {
      menuModel = MenuModel.fromJson(jsonDecode(responseModel.responseJson));
      isInvoicesEnable = menuModel.data!.any((item) => item.name == 'Invoices');
      isEstimatesEnable =
          menuModel.data!.any((item) => item.name == 'Estimates');
      isContractsEnable =
          menuModel.data!.any((item) => item.name == 'Contracts');
      isProposalsEnable =
          menuModel.data!.any((item) => item.name == 'Proposals');
      isSupportEnable = menuModel.data!.any((item) => item.name == 'Support');
      isProjectsEnable = menuModel.data!.any((item) => item.name == 'Projects');
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();
  }
}
