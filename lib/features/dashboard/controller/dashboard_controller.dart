import 'dart:async';
import 'dart:convert';
import 'package:legumlex_customer/common/components/snack_bar/show_custom_snackbar.dart';
import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/features/dashboard/model/chart_model.dart';
import 'package:legumlex_customer/features/dashboard/model/dashboard_model.dart';
import 'package:legumlex_customer/features/dashboard/repo/dashboard_repo.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardController extends GetxController {
  DashboardRepo dashboardRepo;
  DashboardController({required this.dashboardRepo});

  bool isLoading = true;

  String username = "";
  String email = "";
  String imagePath = "";

  DashboardModel dashboardModel = DashboardModel();

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = shouldLoad ? true : false;
    update();

    await loadData();
    isLoading = false;
    update();
  }

  Future<void> loadData() async {
    ResponseModel responseModel = await dashboardRepo.getData();
    if (responseModel.status) {
      dashboardModel =
          DashboardModel.fromJson(jsonDecode(responseModel.responseJson));

      if (dashboardModel.status!) {
        username = dashboardModel.data?.clientName ?? "";
        email = dashboardModel.data?.contactEmail ?? "";
        imagePath = dashboardModel.data?.contactImage ?? '';
      } else {
        CustomSnackBar.error(errorList: [dashboardModel.message!]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();
  }

  bool isVisibleItem = false;
  void visibleItem() {
    isVisibleItem = !isVisibleItem;
    update();
  }

  void gotoNextRoute(String routeName) {
    Get.toNamed(routeName)?.then((value) {
      loadData();
    });
  }

  List<ColumnSeries<ChartDataModel, String>> invoicesChart() {
    return <ColumnSeries<ChartDataModel, String>>[
      ColumnSeries<ChartDataModel, String>(
        dataSource: <ChartDataModel>[
          ChartDataModel(
            x: LocalStrings.unpaid.tr,
            yValue: dashboardModel.data!.invoicesUnPaid,
            pointColor: ColorResources.redColor,
          ),
          ChartDataModel(
            x: LocalStrings.paid.tr,
            yValue: dashboardModel.data!.invoicesPaid,
            pointColor: ColorResources.greenColor,
          ),
          ChartDataModel(
            x: LocalStrings.overdue.tr,
            yValue: dashboardModel.data!.invoicesOverdue,
            pointColor: ColorResources.colorOrange,
          ),
          ChartDataModel(
            x: LocalStrings.partialyPaid.tr,
            yValue: dashboardModel.data!.invoicesPartiallyPaid,
            pointColor: ColorResources.getGreyText(),
          ),
        ],
        name: LocalStrings.invoices.tr,
        xValueMapper: (ChartDataModel data, _) => data.x as String,
        yValueMapper: (ChartDataModel data, _) => data.yValue,
        pointColorMapper: (ChartDataModel data, _) => data.pointColor,
        dataLabelSettings: const DataLabelSettings(isVisible: true),
      )
    ];
  }
}
