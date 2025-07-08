import 'package:legumlex_customer/common/components/app-bar/custom_appbar.dart';
import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/no_data.dart';
import 'package:legumlex_customer/common/components/text/text_icon.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:legumlex_customer/features/dashboard/controller/dashboard_controller.dart';
import 'package:legumlex_customer/features/dashboard/repo/dashboard_repo.dart';
import 'package:legumlex_customer/features/dashboard/widget/custom_container.dart';
import 'package:legumlex_customer/features/invoice/controller/invoice_controller.dart';
import 'package:legumlex_customer/features/invoice/repo/invoice_repo.dart';
import 'package:legumlex_customer/features/invoice/widget/invoice_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(InvoiceRepo(apiClient: Get.find()));
    final controller = Get.put(InvoiceController(invoiceRepo: Get.find()));
    Get.put(DashboardRepo(apiClient: Get.find()));
    final homeController =
        Get.put(DashboardController(dashboardRepo: Get.find()));
    controller.isLoading = true;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialData();
      homeController.initialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocalStrings.invoices.tr,
      ),
      body: GetBuilder<DashboardController>(builder: (dashboardController) {
        return GetBuilder<InvoiceController>(
          builder: (controller) {
            return controller.isLoading
                ? const CustomLoader()
                : RefreshIndicator(
                    onRefresh: () async {
                      await controller.initialData(shouldLoad: false);
                      await dashboardController.initialData();
                    },
                    color: Theme.of(context).primaryColor,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          ExpansionTile(
                            title: Row(
                              children: [
                                Container(
                                  width: Dimensions.space3,
                                  height: Dimensions.space15,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: Dimensions.space5),
                                Text(
                                  LocalStrings.invoiceSummery.tr,
                                  style: regularLarge.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color),
                                ),
                              ],
                            ),
                            shape: const Border(),
                            initiallyExpanded: true,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.space15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CustomContainer(
                                            name: LocalStrings.paid.tr,
                                            number: dashboardController
                                                .dashboardModel
                                                .data!
                                                .invoicesPaid
                                                .toString(),
                                            color: ColorResources.greenColor),
                                        const SizedBox(
                                            width: Dimensions.space10),
                                        CustomContainer(
                                            name: LocalStrings.unpaid.tr,
                                            number: dashboardController
                                                .dashboardModel
                                                .data!
                                                .invoicesUnPaid
                                                .toString(),
                                            color: ColorResources.colorOrange),
                                      ],
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    Row(
                                      children: [
                                        CustomContainer(
                                            name: LocalStrings.overdue.tr,
                                            number: dashboardController
                                                .dashboardModel
                                                .data!
                                                .invoicesOverdue
                                                .toString(),
                                            color: ColorResources.redColor),
                                        const SizedBox(
                                            width: Dimensions.space10),
                                        CustomContainer(
                                            name: LocalStrings.partialyPaid.tr,
                                            number: dashboardController
                                                .dashboardModel
                                                .data!
                                                .invoicesPartiallyPaid
                                                .toString(),
                                            color: ColorResources.blueColor),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(Dimensions.space15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocalStrings.invoices.tr,
                                  style: regularLarge.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: TextIcon(
                                      text: LocalStrings.filter.tr,
                                      icon: Icons.sort_outlined),
                                ),
                              ],
                            ),
                          ),
                          controller.invoicesModel.status!
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.space15),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return InvoiceCard(
                                      index: index,
                                      invoiceModel: controller.invoicesModel,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                          height: Dimensions.space10),
                                  itemCount:
                                      controller.invoicesModel.data!.length)
                              : const NoDataWidget(),
                        ],
                      ),
                    ),
                  );
          },
        );
      }),
    );
  }
}
