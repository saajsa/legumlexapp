import 'package:legumlex_customer/features/auth/view/login_screen.dart';
import 'package:legumlex_customer/features/auth/view/registration_screen.dart';
import 'package:legumlex_customer/features/contract/view/contract_comments_screen.dart';
import 'package:legumlex_customer/features/contract/view/contract_details_screen.dart';
import 'package:legumlex_customer/features/contract/view/contracts_screen.dart';
import 'package:legumlex_customer/features/dashboard/view/dashboard_screen.dart';
import 'package:legumlex_customer/features/estimate/view/estimate_details_screen.dart';
import 'package:legumlex_customer/features/estimate/view/estimate_screen.dart';
import 'package:legumlex_customer/features/invoice/view/invoice_details_screen.dart';
import 'package:legumlex_customer/features/invoice/view/invoice_screen.dart';
import 'package:legumlex_customer/features/knowledge/view/knowledge_base_screen.dart';
import 'package:legumlex_customer/features/menu/view/menu_screen.dart';
import 'package:legumlex_customer/features/onboarding/view/onboard_intro_screen.dart';
import 'package:legumlex_customer/features/privacy/view/privacy_policy_screen.dart';
import 'package:legumlex_customer/features/profile/view/profile_screen.dart';
import 'package:legumlex_customer/features/project/view/project_details_screen.dart';
import 'package:legumlex_customer/features/project/view/projects_screen.dart';
import 'package:legumlex_customer/features/proposal/view/proposal_comments_screen.dart';
import 'package:legumlex_customer/features/proposal/view/proposal_details_screen.dart';
import 'package:legumlex_customer/features/proposal/view/proposal_screen.dart';
import 'package:legumlex_customer/features/splash/view/splash_screen.dart';
import 'package:legumlex_customer/features/ticket/view/ticket_details_screen.dart';
import 'package:legumlex_customer/features/ticket/view/ticket_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashScreen = "/splash_screen";
  static const String onboardScreen = '/onboard_screen';
  static const String loginScreen = "/login_screen";
  static const String registrationScreen = "/registration_screen";

  static const String dashboardScreen = "/dashboard_screen";
  static const String projectScreen = "/project_screen";
  static const String projectDetailsScreen = "/project_details_screen";
  static const String invoiceScreen = "/invoice_screen";
  static const String invoiceDetailsScreen = "/invoice_details_screen";
  static const String contractScreen = "/contract_screen";
  static const String contractDetailsScreen = "/contract_details_screen";
  static const String contractCommentsScreen = "/contract_comments_screen";
  static const String ticketScreen = "/ticket_screen";
  static const String ticketDetailsScreen = "/ticket_details_screen";
  static const String estimateScreen = "/estimate_screen";
  static const String estimateDetailsScreen = "/estimate_details_screen";
  static const String proposalScreen = "/proposal_screen";
  static const String proposalDetailsScreen = "/proposal_details_screen";
  static const String proposalCommentsScreen = "/proposal_comments_screen";
  static const String knowledgeScreen = "/knowledge_screen";
  static const String settingsScreen = "/settings_screen";
  static const String profileScreen = "/profile_screen";
  static const String privacyScreen = "/privacy_screen";

  List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardScreen, page: () => const OnBoardIntroScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: registrationScreen, page: () => const RegistrationScreen()),
    GetPage(name: dashboardScreen, page: () => const DashboardScreen()),
    GetPage(name: projectScreen, page: () => const ProjectsScreen()),
    GetPage(
        name: projectDetailsScreen,
        page: () => ProjectDetailsScreen(id: Get.arguments)),
    GetPage(name: invoiceScreen, page: () => const InvoicesScreen()),
    GetPage(
        name: invoiceDetailsScreen,
        page: () => InvoiceDetailsScreen(id: Get.arguments)),
    GetPage(name: contractScreen, page: () => const ContractsScreen()),
    GetPage(
        name: contractDetailsScreen,
        page: () => ContractDetailsScreen(id: Get.arguments)),
    GetPage(
        name: contractCommentsScreen,
        page: () => ContractCommentsScreen(id: Get.arguments)),
    GetPage(name: ticketScreen, page: () => const TicketsScreen()),
    GetPage(
        name: ticketDetailsScreen,
        page: () => TicketDetailsScreen(id: Get.arguments)),
    GetPage(name: estimateScreen, page: () => const EstimateScreen()),
    GetPage(
        name: estimateDetailsScreen,
        page: () => EstimateDetailsScreen(id: Get.arguments)),
    GetPage(name: knowledgeScreen, page: () => const KnowledgeBaseScreen()),
    GetPage(name: proposalScreen, page: () => const ProposalScreen()),
    GetPage(
        name: proposalDetailsScreen,
        page: () => ProposalDetailsScreen(id: Get.arguments)),
    GetPage(
        name: proposalCommentsScreen,
        page: () => ProposalCommentsScreen(id: Get.arguments)),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: settingsScreen, page: () => const MenuScreen()),
    GetPage(name: privacyScreen, page: () => const PrivacyPolicyScreen()),
  ];
}
