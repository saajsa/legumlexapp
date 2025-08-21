import 'package:cached_network_image/cached_network_image.dart';
import 'package:legumlex_customer/common/components/app-bar/action_button_icon_widget.dart';
import 'package:legumlex_customer/common/components/circle_image_button.dart';
import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/will_pop_widget.dart';
import 'package:legumlex_customer/core/route/route.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/images.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:legumlex_customer/features/dashboard/controller/dashboard_controller.dart';
import 'package:legumlex_customer/features/dashboard/repo/dashboard_repo.dart';
import 'package:legumlex_customer/features/dashboard/widget/dashboard_summary_card.dart';
import 'package:legumlex_customer/features/dashboard/widget/dashboard_section.dart';
import 'package:legumlex_customer/features/dashboard/widget/dashboard_invoice_preview.dart';
import 'package:legumlex_customer/features/dashboard/widget/dashboard_project_preview.dart';
import 'package:legumlex_customer/features/dashboard/widget/dashboard_case_preview.dart';
import 'package:legumlex_customer/features/dashboard/widget/dashboard_consultation_preview.dart';
import 'package:legumlex_customer/features/dashboard/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DashboardRepo(apiClient: Get.find()));
    final controller = Get.put(DashboardController(dashboardRepo: Get.find()));
    controller.isLoading = true;

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: "",
      child: GetBuilder<DashboardController>(
        builder: (controller) => Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            toolbarHeight: 50,
            leading: Builder(builder: (context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu_rounded,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            }),
            centerTitle: true,
            title: CachedNetworkImage(
                imageUrl: controller.dashboardModel.data?.perfexLogo ?? '',
                height: 30,
                errorWidget: (ctx, object, trx) {
                  return Image.asset(
                    MyImages.appLogo,
                    height: 30,
                    color: Colors.white,
                  );
                },
                placeholder: (ctx, trx) {
                  return Image.asset(
                    MyImages.appLogo,
                    height: 30,
                    color: Colors.white,
                  );
                }),
            actions: [
              ActionButtonIconWidget(
                pressed: () => Get.toNamed(RouteHelper.settingsScreen),
                icon: Icons.settings,
                size: 35,
                iconColor: Colors.white,
              ),
            ],
          ),
          drawer: HomeDrawer(
            dashboardModel: controller.dashboardModel,
          ),
          body: controller.isLoading
              ? const CustomLoader()
              : RefreshIndicator(
                  onRefresh: () async {
                    await controller.initialData(shouldLoad: false);
                  },
                  color: Theme.of(context).primaryColor,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(Dimensions.space15),
                    child: Column(
                      children: [
                        // Profile Section
                        Container(
                          padding: const EdgeInsets.all(Dimensions.space20),
                          margin: const EdgeInsets.only(bottom: Dimensions.space20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(Dimensions.cardRadius),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorResources.blueGreyColor,
                                radius: 40,
                                child: CircleImageWidget(
                                  imagePath: '${controller.dashboardModel.data!.contactImage}',
                                  isAsset: false,
                                  isProfile: true,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                              const SizedBox(width: Dimensions.space20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: '${LocalStrings.welcome.tr} ',
                                          style: regularLarge.copyWith(
                                            color: Theme.of(context).textTheme.bodyMedium!.color,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: controller.dashboardModel.data!.contactFirstName,
                                          style: regularLarge.copyWith(
                                            color: ColorResources.secondaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ])
                                    ),
                                    const SizedBox(height: Dimensions.space5),
                                    Text(
                                      '${controller.dashboardModel.data!.contactTitle} - ${controller.dashboardModel.data!.clientName}',
                                      style: regularSmall.copyWith(
                                        color: ColorResources.blueGreyColor,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                        // Summary Cards Row
                        Row(
                          children: [
                            Expanded(
                              child: DashboardSummaryCard(
                                title: 'Total Projects',
                                count: ((controller.dashboardModel.data!.projectsNotStarted ?? 0) +
                                       (controller.dashboardModel.data!.projectsInProgress ?? 0) +
                                       (controller.dashboardModel.data!.projectsOnHold ?? 0) +
                                       (controller.dashboardModel.data!.projectsFinished ?? 0)).toString(),
                                icon: Icons.work_outline,
                                iconColor: ColorResources.blueColor,
                                backgroundColor: ColorResources.blueColor,
                                onTap: () => Get.toNamed(RouteHelper.projectScreen),
                                subItems: [
                                  {'label': 'In Progress', 'value': controller.dashboardModel.data!.projectsInProgress ?? 0, 'color': ColorResources.redColor},
                                  {'label': 'Finished', 'value': controller.dashboardModel.data!.projectsFinished ?? 0, 'color': ColorResources.greenColor},
                                ],
                              ),
                            ),
                            const SizedBox(width: Dimensions.space12),
                            Expanded(
                              child: DashboardSummaryCard(
                                title: 'Total Invoices',
                                count: (controller.dashboardModel.data!.invoicesTotal ?? 0).toString(),
                                icon: Icons.receipt_long,
                                iconColor: ColorResources.greenColor,
                                backgroundColor: ColorResources.greenColor,
                                onTap: () => Get.toNamed(RouteHelper.invoiceScreen),
                                subItems: [
                                  {'label': 'Unpaid', 'value': controller.dashboardModel.data!.invoicesUnPaid ?? 0, 'color': ColorResources.redColor},
                                  {'label': 'Paid', 'value': controller.dashboardModel.data!.invoicesPaid ?? 0, 'color': ColorResources.greenColor},
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimensions.space12),
                        Row(
                          children: [
                            Expanded(
                              child: DashboardSummaryCard(
                                title: 'Cases',
                                count: '0', // Since no case data in dashboard model
                                icon: Icons.gavel,
                                iconColor: ColorResources.secondaryColor,
                                backgroundColor: ColorResources.secondaryColor,
                                onTap: () => Get.toNamed(RouteHelper.casesScreen),
                              ),
                            ),
                            const SizedBox(width: Dimensions.space12),
                            Expanded(
                              child: DashboardSummaryCard(
                                title: 'Support Tickets',
                                count: ((controller.dashboardModel.data!.ticketsOpen ?? 0) +
                                       (controller.dashboardModel.data!.ticketsInProgress ?? 0) +
                                       (controller.dashboardModel.data!.ticketsAnswered ?? 0) +
                                       (controller.dashboardModel.data!.ticketsClosed ?? 0)).toString(),
                                icon: Icons.support_agent,
                                iconColor: ColorResources.purpleColor,
                                backgroundColor: ColorResources.purpleColor,
                                onTap: () => Get.toNamed(RouteHelper.ticketScreen),
                                subItems: [
                                  {'label': 'Open', 'value': controller.dashboardModel.data!.ticketsOpen ?? 0, 'color': ColorResources.redColor},
                                  {'label': 'Closed', 'value': controller.dashboardModel.data!.ticketsClosed ?? 0, 'color': ColorResources.greenColor},
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimensions.space25),

                        // Recent Projects Section
                        DashboardSection(
                          title: LocalStrings.projectSummery.tr,
                          onViewAll: () => Get.toNamed(RouteHelper.projectScreen),
                          children: _buildProjectPreviews(controller),
                        ),

                        // Recent Invoices Section
                        DashboardSection(
                          title: LocalStrings.quickInvoices.tr,
                          onViewAll: () => Get.toNamed(RouteHelper.invoiceScreen),
                          children: _buildInvoicePreviews(controller),
                        ),

                        // Recent Cases Section
                        DashboardSection(
                          title: 'Recent Cases',
                          onViewAll: () => Get.toNamed(RouteHelper.casesScreen),
                          children: _buildCasePreviews(),
                        ),

                        // Recent Consultations Section
                        DashboardSection(
                          title: 'Recent Consultations',
                          onViewAll: () => Get.toNamed(RouteHelper.casesScreen),
                          children: _buildConsultationPreviews(),
                        ),

                        // Chart Section
                        Container(
                          margin: const EdgeInsets.only(top: Dimensions.space10),
                          padding: const EdgeInsets.all(Dimensions.space15),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(Dimensions.cardRadius),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: SfCartesianChart(
                            title: ChartTitle(
                              text: LocalStrings.quickChart.tr,
                              textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            plotAreaBorderWidth: 0,
                            series: controller.invoicesChart(),
                            primaryXAxis: const CategoryAxis(
                              arrangeByIndex: true,
                              labelStyle: regularSmall,
                              majorGridLines: MajorGridLines(width: 0),
                              labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                            ),
                            primaryYAxis: const NumericAxis(
                              labelFormat: '{value}',
                              interval: 2,
                              labelStyle: regularSmall,
                              axisLine: AxisLine(width: 0),
                              majorTickLines: MajorTickLines(size: 0),
                            ),
                            tooltipBehavior: TooltipBehavior(enable: true),
                          ),
                        ),
                        const SizedBox(height: Dimensions.space20),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  List<Widget> _buildProjectPreviews(DashboardController controller) {
    // Mock project data since we don't have individual project data in dashboard API
    return [
      DashboardProjectPreview(
        projectName: 'Legal Case Management System',
        clientName: controller.dashboardModel.data!.clientName ?? 'Unknown Client',
        status: '2', // In Progress
        progress: 75.0,
        startDate: '2024-01-15',
        onTap: () => Get.toNamed(RouteHelper.projectScreen),
      ),
      DashboardProjectPreview(
        projectName: 'Contract Review & Drafting',
        clientName: controller.dashboardModel.data!.clientName ?? 'Unknown Client',
        status: '1', // Not Started
        progress: 25.0,
        startDate: '2024-02-01',
        onTap: () => Get.toNamed(RouteHelper.projectScreen),
      ),
    ];
  }

  List<Widget> _buildInvoicePreviews(DashboardController controller) {
    // Mock invoice data since we don't have individual invoice data in dashboard API
    return [
      DashboardInvoicePreview(
        invoiceNumber: 'INV-2024-001',
        clientName: controller.dashboardModel.data!.clientName ?? 'Unknown Client',
        amount: '\$2,500.00',
        status: 'unpaid',
        date: '2024-01-15',
        onTap: () => Get.toNamed(RouteHelper.invoiceScreen),
      ),
      DashboardInvoicePreview(
        invoiceNumber: 'INV-2024-002',
        clientName: controller.dashboardModel.data!.clientName ?? 'Unknown Client',
        amount: '\$1,200.00',
        status: 'paid',
        date: '2024-01-10',
        onTap: () => Get.toNamed(RouteHelper.invoiceScreen),
      ),
    ];
  }

  List<Widget> _buildCasePreviews() {
    // Mock case data
    return [
      DashboardCasePreview(
        caseTitle: 'Smith vs. Johnson Contract Dispute',
        caseNumber: 'CASE-2024-001',
        clientName: 'Smith Corporation',
        courtDisplay: 'Superior Court of California',
        nextHearingDate: '2024-02-15',
        documentCount: 12,
        onTap: () => Get.toNamed(RouteHelper.casesScreen),
      ),
      DashboardCasePreview(
        caseTitle: 'Property Rights Litigation',
        caseNumber: 'CASE-2024-002',
        clientName: 'Johnson & Associates',
        courtDisplay: 'District Court',
        documentCount: 8,
        onTap: () => Get.toNamed(RouteHelper.casesScreen),
      ),
    ];
  }

  List<Widget> _buildConsultationPreviews() {
    // Mock consultation data
    return [
      DashboardConsultationPreview(
        tag: 'Contract Review Consultation',
        phase: 'consultation',
        clientName: 'ABC Corporation',
        note: 'Initial consultation for reviewing employment contracts and policies.',
        dateAdded: '2024-01-20',
        documentCount: 5,
        onTap: () => Get.toNamed(RouteHelper.casesScreen),
      ),
      DashboardConsultationPreview(
        tag: 'Legal Advisory Session',
        phase: 'litigation',
        clientName: 'XYZ Ltd',
        note: 'Ongoing consultation regarding intellectual property disputes.',
        dateAdded: '2024-01-18',
        documentCount: 3,
        onTap: () => Get.toNamed(RouteHelper.casesScreen),
      ),
    ];
  }
}
