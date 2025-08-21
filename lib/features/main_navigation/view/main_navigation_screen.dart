import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/features/dashboard/view/dashboard_screen.dart';
import 'package:legumlex_customer/features/invoice/view/invoice_screen.dart';
import 'package:legumlex_customer/features/main_navigation/controller/main_navigation_controller.dart';
import 'package:legumlex_customer/features/main_navigation/repo/main_navigation_repo.dart';
import 'package:legumlex_customer/features/profile/view/profile_screen.dart';
import 'package:legumlex_customer/features/project/view/projects_screen.dart';
import 'package:legumlex_customer/features/ticket/view/ticket_screen.dart';
import 'package:legumlex_customer/features/cases/view/cases_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(MainNavigationRepo(apiClient: Get.find()));
    Get.put(MainNavigationController(repo: Get.find()));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainNavigationController>(
      builder: (controller) {
        // Show loading indicator while permissions are loading
        if (controller.isLoading || !controller.permissionsLoaded) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading permissions...'),
                ],
              ),
            ),
          );
        }
        
        print('=== BUILDING NAVIGATION ===');
        print('Projects enabled: ${controller.isProjectsEnable}');
        print('Cases enabled: ${controller.isCasesEnable}');
        
        // Build navigation items based on enabled features
        List<Widget> navigationItems = [];
        List<Widget> screens = [];
        
        // Keep track of current tab count to reset index if needed
        int tabCount = 0;
        
        // Dashboard (always available)
        navigationItems.add(
          Icon(
            Icons.dashboard_rounded,
            size: 28,
            color: ColorResources.accentColor,
          ),
        );
        screens.add(const DashboardScreen());
        tabCount++;
        
        // Projects (if enabled)
        if (controller.isProjectsEnable) {
          navigationItems.add(
            Icon(
              Icons.work_outline_rounded,
              size: 28,
              color: ColorResources.primaryColor,
            ),
          );
          screens.add(const ProjectsScreen());
          tabCount++;
        }
        
        // Invoices (if enabled)
        if (controller.isInvoicesEnable) {
          navigationItems.add(
            Icon(
              Icons.receipt_long_rounded,
              size: 28,
              color: ColorResources.secondaryColor,
            ),
          );
          screens.add(const InvoicesScreen());
          tabCount++;
        }
        
        // Tickets (if enabled)
        if (controller.isSupportEnable) {
          navigationItems.add(
            Icon(
              Icons.support_agent_rounded,
              size: 28,
              color: const Color(0xFF9EB952),
            ),
          );
          screens.add(const TicketsScreen());
          tabCount++;
        }
        
        // Cases (if enabled)
        if (controller.isCasesEnable) {
          navigationItems.add(
            Icon(
              Icons.gavel_rounded,
              size: 28,
              color: const Color(0xFFE67E22), // Orange color for Cases
            ),
          );
          screens.add(const CasesScreen());
          tabCount++;
        }
        
        // Profile (always available)
        navigationItems.add(
          Icon(
            Icons.person_outline_rounded,
            size: 28,
            color: const Color(0xFF6B7280),
          ),
        );
        screens.add(const ProfileScreen());
        tabCount++;
        
        // Reset current index if it's out of bounds
        if (_currentIndex >= tabCount) {
          print('Resetting current index from $_currentIndex to 0 (tabCount: $tabCount)');
          _currentIndex = 0;
        }
        
        print('Final tab count: $tabCount, Current index: $_currentIndex');

        return Scaffold(
          body: PageView(
            controller: _pageController,
            children: screens,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            buttonBackgroundColor: Colors.white,
            color: ColorResources.primaryColor,
            height: 70,
            animationDuration: const Duration(milliseconds: 400),
            animationCurve: Curves.easeInOutCubic,
            index: _currentIndex,
            letIndexChange: (index) => true,
            items: navigationItems,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOutCubic,
              );
            },
          ),
        );
      },
    );
  }
}