import 'dart:async';
import 'dart:convert';
import 'package:legumlex_customer/common/components/snack_bar/show_custom_snackbar.dart';
import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/features/invoice/model/invoice_details_model.dart';
import 'package:legumlex_customer/features/invoice/model/invoice_model.dart';
import 'package:legumlex_customer/features/invoice/repo/invoice_repo.dart';
import 'package:get/get.dart';

class InvoiceController extends GetxController {
  InvoiceRepo invoiceRepo;
  InvoiceController({required this.invoiceRepo});

  bool isLoading = true;
  InvoicesModel invoicesModel = InvoicesModel();
  InvoiceDetailsModel invoiceDetailsModel = InvoiceDetailsModel();

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = shouldLoad ? true : false;
    update();

    await loadInvoices();
    isLoading = false;
    update();
  }

  Future<void> loadInvoices() async {
    ResponseModel responseModel = await invoiceRepo.getAllInvoices();
    if (responseModel.status) {
      invoicesModel =
          InvoicesModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {
      CustomSnackBar.error(errorList: [responseModel.message.tr]);
    }
    isLoading = false;
    update();
  }

  Future<void> loadInvoiceDetails(projectId) async {
    ResponseModel responseModel =
        await invoiceRepo.getInvoiceDetails(projectId);
    if (responseModel.status) {
      invoiceDetailsModel =
          InvoiceDetailsModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();
  }
}
