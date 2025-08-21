import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:legumlex_customer/common/components/app-bar/action_button_icon_widget.dart';
import 'package:legumlex_customer/common/components/circle_image_button.dart';
import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/will_pop_widget.dart';

import 'package:legumlex_customer/core/route/route.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/cases_theme.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/images.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/core/utils/style.dart';

import 'package:legumlex_customer/features/dashboard/controller/dashboard_controller.dart';
import 'package:legumlex_customer/features/dashboard/repo/dashboard_repo.dart';
import 'package:legumlex_customer/features/dashboard/widget/cases_dashboard_layout.dart';
import 'package:legumlex_customer/features/dashboard/widget/cases_card.dart';
import 'package:legumlex_customer/features/dashboard/widget/cases_status_badge.dart';
import 'package:legumlex_customer/features/dashboard/widget/dashboard_case_preview.dart';
import 'package:legumlex_customer/features/dashboard/widget/dashboard_consultation_preview.dart';
import 'package:legumlex_customer/features/dashboard/widget/dashboard_invoice_preview.dart';
import 'package:legumlex_customer/features/dashboard/widget/dashboard_project_preview.dart';
import 'package:legumlex_customer/features/dashboard/widget/drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? selectedFilter = 'all';

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
              },
            ),
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
                  color: CasesTheme.primary,
                  child: CasesDashboardLayout(
                    title:
                        '${LocalStrings.welcome.tr} ${controller.dashboardModel.data?.contactFirstName ?? ''}',
                    subtitle:
                        '${controller.dashboardModel.data?.contactTitle ?? ''} - ${controller.dashboardModel.data?.clientName ?? ''}',
                    children: [
                      _buildUserProfileSection(controller),
                      _buildFilterPills(),
                      _buildOverviewStats(controller),
                      _buildRecentActivities(controller),
                      _buildQuickActions(),
                      _buildAnalyticsChart(controller),
                      const SizedBox(height: Dimensions.space20),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  // Profile overview (Cases-styled)
  Widget _buildUserProfileSection(DashboardController controller) {
    return CasesCard.info(
      title: 'Profile Overview',
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: CasesTheme.bgTertiary,
            radius: 35,
            child: CircleImageWidget(
              imagePath: '${controller.dashboardModel.data!.contactImage}',
              isAsset: false,
              isProfile: true,
              width: 70,
              height: 70,
            ),
          ),
          const SizedBox(width: CasesTheme.spacingLg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${controller.dashboardModel.data!.contactFirstName} ${controller.dashboardModel.data!.contactLastName ?? ''}',
                  style: CasesTheme.headingLg,
                ),
                const SizedBox(height: 4),
                Text(
                  controller.dashboardModel.data!.contactEmail ?? '',
                  style: CasesTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  controller.dashboardModel.data!.contactPhone ?? '',
                  style: CasesTheme.bodySmall,
                ),
              ],
            ),
          ),
          const CasesStatusBadge.active(text: 'Active'),
        ],
      ),
    );
  }

  // Filter pills (All, Projects, Invoices, Cases, Consultations)
  Widget _buildFilterPills() {
    return Container(
      margin: const EdgeInsets.only(bottom: CasesTheme.spacingLg),
      child: CasesFilterPills(
        selectedPill: selectedFilter,
        onPillSelected: (pill) {
          setState(() {
            selectedFilter = pill;
          });
        },
        pills: const [
          CasesFilterPill(id: 'all', label: 'All Items'),
          CasesFilterPill(id: 'projects', label: 'Projects'),
          CasesFilterPill(id: 'invoices', label: 'Invoices'),
          CasesFilterPill(id: 'cases', label: 'Cases'),
          CasesFilterPill(id: 'consultations', label: 'Consultations'),
        ],
      ),
    );
  }

  // Overview statistics in Cases grid/cards
  Widget _buildOverviewStats(DashboardController controller) {
    final totalProjects = (controller.dashboardModel.data!.projectsNotStarted ?? 0) +
        (controller.dashboardModel.data!.projectsInProgress ?? 0) +
        (controller.dashboardModel.data!.projectsOnHold ?? 0) +
        (controller.dashboardModel.data!.projectsFinished ?? 0);

    final supportTickets = (controller.dashboardModel.data!.ticketsOpen ?? 0) +
        (controller.dashboardModel.data!.ticketsInProgress ?? 0) +
        (controller.dashboardModel.data!.ticketsAnswered ?? 0);

    return Column(
      children: [
        const CasesSectionHeader(
          title: 'Overview Statistics',
        ),
        CasesGridLayout.dashboard(
          children: [
            _buildStatCard(
              'Total Projects',
              totalProjects,
              Icons.work_outline,
              CasesTheme.info,
              () => Get.toNamed(RouteHelper.projectScreen),
            ),
            _buildStatCard(
              'Total Invoices',
              controller.dashboardModel.data!.invoicesTotal ?? 0,
              Icons.receipt_long,
              CasesTheme.success,
              () => Get.toNamed(RouteHelper.invoiceScreen),
            ),
            _buildStatCard(
              'Active Cases',
              5, // Mock data; not available from dashboardModel
              Icons.gavel,
              CasesTheme.warning,
              () => Get.toNamed(RouteHelper.casesScreen),
            ),
            _buildStatCard(
              'Support Tickets',
              supportTickets,
              Icons.support_agent,
              CasesTheme.danger,
              () => Get.toNamed(RouteHelper.ticketScreen),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    int count,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return CasesCard.stat(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      count.toString(),
                      style: CasesTheme.headingLarge.copyWith(fontSize: 32),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: CasesTheme.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                icon,
                size: 32,
                color: color.withValues(alpha: 0.3),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Recent activities sections (Projects, Invoices, Cases, Consultations)
  Widget _buildRecentActivities(DashboardController controller) {
    return Column(
      children: [
        // Projects
        if (selectedFilter == 'all' || selectedFilter == 'projects') ...[
          CasesSectionHeader(
            title: 'Recent Projects',
            actions: [
              TextButton(
                onPressed: () => Get.toNamed(RouteHelper.projectScreen),
                child: Text(
                  LocalStrings.viewAll.tr,
                  style: CasesTheme.bodySmall.copyWith(
                    color: CasesTheme.info,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: const EdgeInsets.only(right: CasesTheme.spacingMd),
                  child: _buildProjectPreview(index, controller),
                );
              },
            ),
          ),
        ],

        // Invoices
        if (selectedFilter == 'all' || selectedFilter == 'invoices') ...[
          CasesSectionHeader(
            title: 'Recent Invoices',
            actions: [
              TextButton(
                onPressed: () => Get.toNamed(RouteHelper.invoiceScreen),
                child: Text(
                  LocalStrings.viewAll.tr,
                  style: CasesTheme.bodySmall.copyWith(
                    color: CasesTheme.info,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  margin: const EdgeInsets.only(right: CasesTheme.spacingMd),
                  child: _buildInvoicePreview(index, controller),
                );
              },
            ),
          ),
        ],

        // Cases
        if (selectedFilter == 'all' || selectedFilter == 'cases') ...[
          CasesSectionHeader(
            title: 'Recent Cases',
            actions: [
              TextButton(
                onPressed: () => Get.toNamed(RouteHelper.casesScreen),
                child: Text(
                  LocalStrings.viewAll.tr,
                  style: CasesTheme.bodySmall.copyWith(
                    color: CasesTheme.info,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  margin: const EdgeInsets.only(right: CasesTheme.spacingMd),
                  child: _buildCasePreview(index),
                );
              },
            ),
          ),
        ],

        // Consultations
        if (selectedFilter == 'all' || selectedFilter == 'consultations') ...[
          CasesSectionHeader(
            title: 'Recent Consultations',
            actions: [
              TextButton(
                onPressed: () => Get.toNamed(RouteHelper.casesScreen),
                child: Text(
                  LocalStrings.viewAll.tr,
                  style: CasesTheme.bodySmall.copyWith(
                    color: CasesTheme.info,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: const EdgeInsets.only(right: CasesTheme.spacingMd),
                  child: _buildConsultationPreview(index),
                );
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildProjectPreview(int index, DashboardController controller) {
    final projects = [
      {
        'name': 'Legal Case Management System',
        'client': controller.dashboardModel.data!.clientName ?? 'Unknown Client',
        'status': '2',
        'progress': 75.0,
        'date': '2024-01-15',
      },
      {
        'name': 'Contract Review & Drafting',
        'client': controller.dashboardModel.data!.clientName ?? 'Unknown Client',
        'status': '1',
        'progress': 25.0,
        'date': '2024-02-01',
      },
    ];

    final project = projects[index];
    return DashboardProjectPreview(
      projectName: project['name'] as String,
      clientName: project['client'] as String,
      status: project['status'] as String,
      progress: project['progress'] as double,
      startDate: project['date'] as String,
      onTap: () => Get.toNamed(RouteHelper.projectScreen),
    );
  }

  Widget _buildInvoicePreview(int index, DashboardController controller) {
    final invoices = [
      {
        'number': 'INV-2024-001',
        'client': controller.dashboardModel.data!.clientName ?? 'Unknown Client',
        'amount': '\$2,500.00',
        'status': 'unpaid',
        'date': '2024-01-15',
      },
      {
        'number': 'INV-2024-002',
        'client': controller.dashboardModel.data!.clientName ?? 'Unknown Client',
        'amount': '\$1,200.00',
        'status': 'paid',
        'date': '2024-01-10',
      },
    ];

    final invoice = invoices[index];
    return DashboardInvoicePreview(
      invoiceNumber: invoice['number'] as String,
      clientName: invoice['client'] as String,
      amount: invoice['amount'] as String,
      status: invoice['status'] as String,
      date: invoice['date'] as String,
      onTap: () => Get.toNamed(RouteHelper.invoiceScreen),
    );
  }

  Widget _buildCasePreview(int index) {
    final caseData = [
      {
        'title': 'Smith vs. Johnson Contract Dispute',
        'number': 'CASE-2024-001',
        'client': 'Smith Corporation',
        'court': 'Superior Court of California',
        'nextHearing': '2024-02-15',
        'documents': 12,
      },
      {
        'title': 'Property Rights Litigation',
        'number': 'CASE-2024-002',
        'client': 'Johnson & Associates',
        'court': 'District Court',
        'nextHearing': null,
        'documents': 8,
      },
    ];

    final caseItem = caseData[index];
    return DashboardCasePreview(
      caseTitle: caseItem['title'] as String,
      caseNumber: caseItem['number'] as String,
      clientName: caseItem['client'] as String,
      courtDisplay: caseItem['court'] as String,
      nextHearingDate: caseItem['nextHearing'] as String?,
      documentCount: caseItem['documents'] as int,
      onTap: () => Get.toNamed(RouteHelper.casesScreen),
    );
  }

  Widget _buildConsultationPreview(int index) {
    final consultations = [
      {
        'tag': 'Contract Review Consultation',
        'phase': 'consultation',
        'client': 'ABC Corporation',
        'note':
            'Initial consultation for reviewing employment contracts and policies.',
        'date': '2024-01-20',
        'documents': 5,
      },
      {
        'tag': 'Legal Advisory Session',
        'phase': 'litigation',
        'client': 'XYZ Ltd',
        'note':
            'Ongoing consultation regarding intellectual property disputes.',
        'date': '2024-01-18',
        'documents': 3,
      },
    ];

    final consultation = consultations[index];
    return DashboardConsultationPreview(
      tag: consultation['tag'] as String,
      phase: consultation['phase'] as String,
      clientName: consultation['client'] as String,
      note: consultation['note'] as String,
      dateAdded: consultation['date'] as String,
      documentCount: consultation['documents'] as int,
      onTap: () => Get.toNamed(RouteHelper.casesScreen),
    );
  }

  // Quick actions section
  Widget _buildQuickActions() {
    return Column(
      children: [
        const CasesSectionHeader(
          title: 'Quick Actions',
        ),
        CasesGridLayout.twoColumn(
          children: [
            _buildQuickActionCard(
              'New Case',
              'Create a new legal case',
              Icons.add_circle,
              CasesTheme.success,
              () => Get.toNamed(RouteHelper.casesScreen),
            ),
            _buildQuickActionCard(
              'Upload Documents',
              'Upload case documents',
              Icons.upload_file,
              CasesTheme.info,
              () => Get.toNamed(RouteHelper.casesScreen),
            ),
            _buildQuickActionCard(
              'Schedule Hearing',
              'Schedule a court hearing',
              Icons.event_available,
              CasesTheme.warning,
              () => Get.toNamed(RouteHelper.casesScreen),
            ),
            _buildQuickActionCard(
              'Generate Report',
              'Create case reports',
              Icons.assessment,
              CasesTheme.danger,
              () => Get.toNamed(RouteHelper.casesScreen),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return CasesCard.compact(
      onTap: onTap,
      leftBorderColor: color,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: CasesTheme.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CasesTheme.headingLg.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: CasesTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Chart section (Cases-styled container)
  Widget _buildAnalyticsChart(DashboardController controller) {
    return Column(
      children: [
        CasesSectionHeader(
          title: LocalStrings.quickChart.tr,
        ),
        CasesContentSection(
          child: SizedBox(
            height: 300,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              series: controller.invoicesChart(),
              primaryXAxis: const CategoryAxis(
                arrangeByIndex: true,
                labelStyle: TextStyle(
                  fontFamily: CasesTheme.fontFamily,
                  fontSize: CasesTheme.fontSizeSm,
                  color: CasesTheme.textLight,
                ),
                majorGridLines: MajorGridLines(width: 0),
                labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                edgeLabelPlacement: EdgeLabelPlacement.shift,
              ),
              primaryYAxis: const NumericAxis(
                labelFormat: '{value}',
                interval: 2,
                labelStyle: TextStyle(
                  fontFamily: CasesTheme.fontFamily,
                  fontSize: CasesTheme.fontSizeSm,
                  color: CasesTheme.textLight,
                ),
                axisLine: AxisLine(width: 0),
                majorTickLines: MajorTickLines(size: 0),
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
            ),
          ),
        ),
      ],
    );
  }
}
