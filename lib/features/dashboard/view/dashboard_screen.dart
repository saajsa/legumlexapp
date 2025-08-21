import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:legumlex_customer/common/components/app-bar/action_button_icon_widget.dart';
import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/will_pop_widget.dart';
import 'package:legumlex_customer/core/route/route.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/cases_theme.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/images.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/features/dashboard/controller/dashboard_controller.dart';
import 'package:legumlex_customer/features/dashboard/repo/dashboard_repo.dart';
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
          backgroundColor: CasesTheme.bgSecondary,
          appBar: _buildAppBar(controller),
          drawer: HomeDrawer(
            dashboardModel: controller.dashboardModel,
          ),
          body: controller.isLoading
              ? const Center(child: CustomLoader())
              : RefreshIndicator(
                  onRefresh: () async {
                    await controller.initialData(shouldLoad: false);
                  },
                  color: CasesTheme.primary,
                  child: _buildDashboardContent(controller),
                ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(DashboardController controller) {
    return AppBar(
      toolbarHeight: 60,
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
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CachedNetworkImage(
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
        ],
      ),
      actions: [
        ActionButtonIconWidget(
          pressed: () => Get.toNamed(RouteHelper.settingsScreen),
          icon: Icons.settings,
          size: 35,
          iconColor: Colors.white,
        ),
      ],
      backgroundColor: CasesTheme.primary,
      elevation: 0,
    );
  }

  Widget _buildDashboardContent(DashboardController controller) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeHeader(controller),
          const SizedBox(height: 24),
          _buildFilterPills(),
          const SizedBox(height: 24),
          _buildOverviewStats(controller),
          const SizedBox(height: 24),
          _buildQuickActions(),
          const SizedBox(height: 24),
          _buildRecentActivities(controller),
          const SizedBox(height: 24),
          _buildAnalyticsChart(controller),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader(DashboardController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CasesTheme.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [CasesTheme.shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${LocalStrings.welcome.tr} ${controller.dashboardModel.data?.contactFirstName ?? ''}',
            style: CasesTheme.headingLarge.copyWith(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${controller.dashboardModel.data?.contactTitle ?? ''} - ${controller.dashboardModel.data?.clientName ?? ''}',
            style: CasesTheme.bodyMedium.copyWith(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterPills() {
    final filters = [
      {'id': 'all', 'label': 'All Items'},
      {'id': 'projects', 'label': 'Projects'},
      {'id': 'invoices', 'label': 'Invoices'},
      {'id': 'cases', 'label': 'Cases'},
      {'id': 'consultations', 'label': 'Consultations'},
    ];

    return Container(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter['id'];
          
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedFilter = filter['id'];
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? CasesTheme.primary : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? CasesTheme.primary : CasesTheme.border,
                ),
              ),
              child: Text(
                filter['label'] as String,
                style: TextStyle(
                  color: isSelected ? Colors.white : CasesTheme.textLight,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOverviewStats(DashboardController controller) {
    final totalProjects = (controller.dashboardModel.data!.projectsNotStarted ?? 0) +
        (controller.dashboardModel.data!.projectsInProgress ?? 0) +
        (controller.dashboardModel.data!.projectsOnHold ?? 0) +
        (controller.dashboardModel.data!.projectsFinished ?? 0);

    final supportTickets = (controller.dashboardModel.data!.ticketsOpen ?? 0) +
        (controller.dashboardModel.data!.ticketsInProgress ?? 0) +
        (controller.dashboardModel.data!.ticketsAnswered ?? 0);

    final stats = [
      {
        'title': 'Total Projects',
        'count': totalProjects,
        'icon': Icons.work_outline,
        'color': CasesTheme.info,
        'onTap': () => Get.toNamed(RouteHelper.projectScreen),
      },
      {
        'title': 'Total Invoices',
        'count': controller.dashboardModel.data!.invoicesTotal ?? 0,
        'icon': Icons.receipt_long,
        'color': CasesTheme.success,
        'onTap': () => Get.toNamed(RouteHelper.invoiceScreen),
      },
      {
        'title': 'Active Cases',
        'count': 5, // Mock data
        'icon': Icons.gavel,
        'color': CasesTheme.warning,
        'onTap': () => Get.toNamed(RouteHelper.casesScreen),
      },
      {
        'title': 'Support Tickets',
        'count': supportTickets,
        'icon': Icons.support_agent,
        'color': CasesTheme.danger,
        'onTap': () => Get.toNamed(RouteHelper.ticketScreen),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview Statistics',
          style: CasesTheme.heading2xl,
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = (constraints.maxWidth - 24) / 2;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              itemCount: stats.length,
              itemBuilder: (context, index) {
                final stat = stats[index];
                return _buildStatCard(
                  stat['title'] as String,
                  stat['count'] as int,
                  stat['icon'] as IconData,
                  stat['color'] as Color,
                  stat['onTap'] as VoidCallback,
                );
              },
            );
          },
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: CasesTheme.border),
          boxShadow: const [CasesTheme.shadowSm],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  count.toString(),
                  style: CasesTheme.headingLarge.copyWith(
                    fontSize: 28,
                    color: color,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: CasesTheme.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {
        'title': 'New Case',
        'description': 'Create a new legal case',
        'icon': Icons.add_circle,
        'color': CasesTheme.success,
        'onTap': () => Get.toNamed(RouteHelper.casesScreen),
      },
      {
        'title': 'Upload Documents',
        'description': 'Upload case documents',
        'icon': Icons.upload_file,
        'color': CasesTheme.info,
        'onTap': () => Get.toNamed(RouteHelper.casesScreen),
      },
      {
        'title': 'Schedule Hearing',
        'description': 'Schedule a court hearing',
        'icon': Icons.event_available,
        'color': CasesTheme.warning,
        'onTap': () => Get.toNamed(RouteHelper.casesScreen),
      },
      {
        'title': 'Generate Report',
        'description': 'Create case reports',
        'icon': Icons.assessment,
        'color': CasesTheme.danger,
        'onTap': () => Get.toNamed(RouteHelper.casesScreen),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: CasesTheme.heading2xl,
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = (constraints.maxWidth - 16) / 2;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.8,
              ),
              itemCount: actions.length,
              itemBuilder: (context, index) {
                final action = actions[index];
                return _buildQuickActionCard(
                  action['title'] as String,
                  action['description'] as String,
                  action['icon'] as IconData,
                  action['color'] as Color,
                  action['onTap'] as VoidCallback,
                );
              },
            );
          },
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: CasesTheme.border),
          boxShadow: const [CasesTheme.shadowSm],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: CasesTheme.headingLg.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: CasesTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivities(DashboardController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activities',
          style: CasesTheme.heading2xl,
        ),
        const SizedBox(height: 16),
        if (selectedFilter == 'all' || selectedFilter == 'projects') ...[
          _buildActivitySection(
            'Recent Projects',
            () => Get.toNamed(RouteHelper.projectScreen),
            _buildProjectPreview(controller),
          ),
          const SizedBox(height: 24),
        ],
        if (selectedFilter == 'all' || selectedFilter == 'invoices') ...[
          _buildActivitySection(
            'Recent Invoices',
            () => Get.toNamed(RouteHelper.invoiceScreen),
            _buildInvoicePreview(controller),
          ),
          const SizedBox(height: 24),
        ],
        if (selectedFilter == 'all' || selectedFilter == 'cases') ...[
          _buildActivitySection(
            'Recent Cases',
            () => Get.toNamed(RouteHelper.casesScreen),
            _buildCasePreview(),
          ),
          const SizedBox(height: 24),
        ],
        if (selectedFilter == 'all' || selectedFilter == 'consultations') ...[
          _buildActivitySection(
            'Recent Consultations',
            () => Get.toNamed(RouteHelper.casesScreen),
            _buildConsultationPreview(),
          ),
        ],
      ],
    );
  }

  Widget _buildActivitySection(String title, VoidCallback onViewAll, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: CasesTheme.headingXl,
            ),
            TextButton(
              onPressed: onViewAll,
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
        const SizedBox(height: 12),
        content,
      ],
    );
  }

  Widget _buildProjectPreview(DashboardController controller) {
    final projects = [
      {
        'name': 'Legal Case Management System',
        'client': controller.dashboardModel.data!.clientName ?? 'Unknown Client',
        'status': 'In Progress',
        'progress': 75.0,
        'date': '2024-01-15',
      },
      {
        'name': 'Contract Review & Drafting',
        'client': controller.dashboardModel.data!.clientName ?? 'Unknown Client',
        'status': 'Pending',
        'progress': 25.0,
        'date': '2024-02-01',
      },
    ];

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: projects.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final project = projects[index];
          return Container(
            width: 300,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: CasesTheme.border),
              boxShadow: const [CasesTheme.shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  project['name'] as String,
                  style: CasesTheme.headingLg.copyWith(fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  project['client'] as String,
                  style: CasesTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: (project['progress'] as double) / 100,
                        backgroundColor: CasesTheme.border,
                        color: CasesTheme.getStatusColor(project['status'] as String),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${(project['progress'] as double).toInt()}%',
                      style: CasesTheme.captionSmall,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInvoicePreview(DashboardController controller) {
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

    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: invoices.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final invoice = invoices[index];
          final isPaid = invoice['status'] == 'paid';
          
          return Container(
            width: 280,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: CasesTheme.border),
              boxShadow: const [CasesTheme.shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isPaid ? CasesTheme.successBg : CasesTheme.warningBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    isPaid ? Icons.check_circle : Icons.pending,
                    color: isPaid ? CasesTheme.success : CasesTheme.warning,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        invoice['number'] as String,
                        style: CasesTheme.headingLg.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        invoice['client'] as String,
                        style: CasesTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      invoice['amount'] as String,
                      style: CasesTheme.headingLg.copyWith(
                        fontSize: 16,
                        color: CasesTheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      invoice['date'] as String,
                      style: CasesTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCasePreview() {
    final cases = [
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

    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: cases.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final caseItem = cases[index];
          
          return Container(
            width: 300,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: CasesTheme.border),
              boxShadow: const [CasesTheme.shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  caseItem['title'] as String,
                  style: CasesTheme.headingLg.copyWith(fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  caseItem['number'] as String,
                  style: CasesTheme.bodySmall.copyWith(
                    color: CasesTheme.textLight,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        caseItem['client'] as String,
                        style: CasesTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (caseItem['nextHearing'] != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: CasesTheme.warningBg,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Next: ${caseItem['nextHearing']}',
                          style: CasesTheme.captionSmall.copyWith(
                            color: CasesTheme.warning,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildConsultationPreview() {
    final consultations = [
      {
        'tag': 'Contract Review Consultation',
        'phase': 'consultation',
        'client': 'ABC Corporation',
        'note': 'Initial consultation for reviewing employment contracts and policies.',
        'date': '2024-01-20',
        'documents': 5,
      },
      {
        'tag': 'Legal Advisory Session',
        'phase': 'litigation',
        'client': 'XYZ Ltd',
        'note': 'Ongoing consultation regarding intellectual property disputes.',
        'date': '2024-01-18',
        'documents': 3,
      },
    ];

    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: consultations.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final consultation = consultations[index];
          final phaseColor = CasesTheme.getStatusColor(consultation['phase'] as String);
          final phaseBgColor = CasesTheme.getStatusBackgroundColor(consultation['phase'] as String);
          
          return Container(
            width: 300,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: CasesTheme.border),
              boxShadow: const [CasesTheme.shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        consultation['tag'] as String,
                        style: CasesTheme.headingLg.copyWith(fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: phaseBgColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        consultation['phase'] as String,
                        style: CasesTheme.captionSmall.copyWith(
                          color: phaseColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  consultation['client'] as String,
                  style: CasesTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  consultation['note'] as String,
                  style: CasesTheme.bodySmall.copyWith(
                    color: CasesTheme.textLight,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnalyticsChart(DashboardController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CasesTheme.border),
        boxShadow: const [CasesTheme.shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalStrings.quickChart.tr,
            style: CasesTheme.heading2xl,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 250,
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
        ],
      ),
    );
  }
}
