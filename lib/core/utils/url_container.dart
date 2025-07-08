class UrlContainer {
  static const String domainUrl = 'https://legumlex.com/accs';
  static const String baseUrl = '$domainUrl/customers_api/v1/';

  static RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  // Authentication
  static const String loginUrl = 'authentication';
  static const String registrationUrl = 'register';
  static const String logoutUrl = 'logout';

  // Dashboard
  static const String dashboardUrl = 'overview';
  static const String getClientMenuUrl = 'miscellaneous/group/client_menu';
  static const String miscellaneousDataUrl = 'miscellaneous/group';

  // Pages
  static const String projectsUrl = 'projects';
  static const String invoicesUrl = 'invoices';
  static const String contractsUrl = 'contracts';
  static const String estimatesUrl = 'estimates';
  static const String proposalsUrl = 'proposals';
  static const String ticketsUrl = 'tickets';
  static const String knowledgeBaseUrl = 'knowledge_base';
  static const String privacyPolicyUrl =
      'knowledge_base/article/privacy-policy';
}
