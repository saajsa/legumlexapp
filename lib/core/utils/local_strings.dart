import 'package:legumlex_customer/common/models/language_model.dart';
import 'package:legumlex_customer/core/utils/images.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';

class LocalStrings {
  static const String appName = "Legum Lex";

  static List<LanguageModel> appLanguages = [
    LanguageModel(
        languageFlag: MyImages.english,
        languageName: "English",
        countryCode: "US",
        languageCode: "en"),
    LanguageModel(
        languageFlag: MyImages.arabic,
        languageName: "العربية",
        countryCode: "SA",
        languageCode: "ar"),
    LanguageModel(
        languageFlag: MyImages.spanish,
        languageName: "Español",
        countryCode: "ES",
        languageCode: "es"),
    LanguageModel(
        languageFlag: MyImages.frensh,
        languageName: "Français",
        countryCode: "FR",
        languageCode: "fr"),
    LanguageModel(
        languageFlag: MyImages.german,
        languageName: "Deutsch",
        countryCode: "DE",
        languageCode: "de"),
    LanguageModel(
        languageFlag: MyImages.hindi,
        languageName: "हिन्दी",
        countryCode: "HI",
        languageCode: "hi"),
  ];

  // Onboarding Screens
  static const String onboardTitle1 = "Onboarding one";
  static const String onboardSubTitle1 = "Onboarding One Description";
  static const String onboardTitle2 = "Onboarding Two";
  static const String onboardSubTitle2 = "Onboarding Two Description.";
  static const String onboardTitle3 = "Onboarding Three";
  static const String onboardSubTitle3 = "Onboarding Three Description.";
  static const String skip = "Skip";
  static const String next = "Next";
  static const String getStarted = "Get Started";

  // Login Screen
  static const String username = "Username";
  static const String usernameHint = "Enter username";
  static const String password = "Password";
  static const String passwordHint = "Enter password";
  static const String rememberMe = "Remember Me";
  static const String forgotPassword = "Forgot Password?";
  static const String signIn = "Sign In";
  static const String login = 'Login';
  static const String loginDesc = 'Login to your account';
  static const String doNotHaveAccount = "Don't have an account?";
  static const String createAnAccount = "Create an Account";
  static const String iAgreeWith = "I agree with the";
  static const String policies = 'Policies';
  static const String loginFailedTryAgain = 'Login failed,please try again';

  // Register Screen
  static const String enterName = "Enter Name";
  static const String firstName = "First Name";
  static const String enterFirstName = "Enter first name";
  static const String lastName = "Last Name";
  static const String last = "Last";
  static const String enterLastName = "Enter last name";
  static const String country = "Country";
  static const String enterYourCountry = "Enter your country";
  static const String mobileNumber = "Mobile Number";
  static const String emailAddress = "E-mail Address";
  static const String confirmPassword = "Confirm Password";
  static const String firstNameHint = "Enter first Name";
  static const String lastNameHint = "Enter last Name";
  static const String countryHint = "Select Country";
  static const String mobileNumberHint = "Your phone number";
  static const String emailAddressHint = "Enter email address";
  static const String emailAddressEmptyMsg = "Email address can't be empty";
  static const String confirmPasswordHint = "Enter confirm Password";
  static const String signUp = "Sign Up";
  static const String alreadyAccount = "Already have an account?";
  static const String signInNow = "Sign In Now";
  static const String signUpNow = "Sign Up Now";
  static const String companyName = "Legal Name of Company";
  static const String companyNameHint = "Enter legal name of company";
  static const String enterCompanyName = "Enter Company Name";
  static const String representativeFirstName = "Representative First Name";
  static const String representativeLastName = "Representative Last Name";
  static const String userName = "Username";
  static const String userNameHint = "Enter username";
  static const String email = "Email";
  static const String enterEmail = "Enter email";
  static RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const String invalidEmailMsg = "Enter valid email";
  static const String enterYourPassword = 'Enter your password';
  static const String invalidPassMsg =
      "Password must be contain 1 special character and number";
  static const String hasUpperLetter = "Has uppercase letter";
  static const String hasLowerLetter = "Has lowercase letter";
  static const String hasDigit = "Has digit";
  static const String hasSpecialChar = "Has special character";
  static const String minSixChar = "Min of 6 characters";
  static const String passwordMatchError = "Password doesn't match";
  static const String agreePolicyMessage =
      "You must agree with our privacy & policies";

  // Change Password
  static const String changePassword = "Change Password";
  static const String currentPassword = "Current Password";
  static const String currentPasswordHint = "Enter current password";
  static const String saveNewPassword = "Save New Password";

  // OTP
  static const String otpVerify = "OTP";
  static const String enterOtpSent = "Enter the otp sent to ";
  static const String verify = "Verify";
  static const String requestAgain = "Request again";

  // Home
  static const String dashboard = "Dashboard";
  static const String welcome = 'Welcome';
  static const String quickInvoices = 'Quick Invoices';
  static const String quickChart = 'Legum Lex Chart';

  // Profile
  static const String viewProfile = "View Profile";
  static const String name = "Name";
  static const String phone = "Phone";
  static const String zipCode = "Zip Code";
  static const String enterYourZipCode = "Enter your zip code";
  static const String state = "State";
  static const String enterYourState = "Enter your state";
  static const String city = "City";
  static const String enterYourCity = "Enter your city";
  static const String editProfile = "Edit Profile";
  static const String updateProfile = "Update Profile";

  // Settings
  static const String profile = "Profile";
  static const String theme = "Theme";
  static const String notification = 'Notifications';
  static const String settings = "Settings";
  static const String helpAndSetting = "Help & Settings";
  static const String language = "Language";
  static const String selectLanguage = 'Select Language';
  static const String help = "Help";
  static const String faq = "FAQ";
  static const String terms = "Terms & Conditions";
  static const String privacyPolicy = "Privacy & Policy";
  static const String ourPrivacyPolicy = "Our Privacy Policy";
  static const String signOut = "Sign Out";
  static const String darkmode = "Dark Mode";
  static const String light = "Light";
  static const String exitTitle = "Are you sure you want to exit the app?";
  static const String logout = "Logout";
  static const String logoutTitle = "Log out";
  static const String logoutMSg =
      "Log out of this app by clicking the Log Out button.";
  static const String logoutSureWarningMSg =
      "Are you sure you want to log out from your account?";
  static const String logoutSuccessMsg = 'Sign Out Successfully';

  // Status
  static const String approved = "Approved";
  static const String accept = "Accept";
  static const String enabled = "Enabled";
  static const String disabled = "Disabled";
  static const String succeed = "Succeed";
  static const String pending = "Pending";
  static const String rejected = "Rejected";
  static const String reject = "Reject";
  static const String completed = "Completed";
  static const String paid = "Paid";
  static const String unpaid = "Unpaid";

  // Operations
  static const String isRequired = 'is required';
  static const String chooseFile = 'Choose File';
  static const String copy = "Copy";
  static const String view = "View";
  static const String viewAll = "View All";
  static const String edit = "Edit";
  static const String submit = "Submit";
  static const String dataNotFound = "Data not found";
  static const String seeAll = "See All";
  static const String showMore = "Show More";
  static const String more = "More";
  static const String status = "Status";
  static const String complete = "Completed";
  static const String cancel = "Cancel";
  static const String success = 'success';
  static const String fieldErrorMsg = "Please fill out this field";
  static const String requestSuccess = "Request Success";
  static const String badResponseMsg = 'Bad Response Format!';
  static const String serverError = 'Server Error';
  static const String unAuthorized = 'Unauthorized';
  static const String somethingWentWrong = 'Something went wrong';
  static const String noInternet = 'No internet connection';
  static const String noDataFound = 'Sorry! there are no data to show';
  static const String yes = "Yes";
  static const String no = "No";
  static const String retry = "Retry";
  static const String error = 'Error';
  static const String exit = 'Exit';
  static const String confirm = 'Confirm';

  // Contract
  static const String contracts = 'Contracts';
  static const String contract = 'Contract';
  static const String contractSummery = 'Contract Summery';
  static const String contractDetails = 'Contract Details';
  static const String sign = 'Sign';
  static const String signContract = 'Sign Contract';
  static const String signature = 'Signature';
  static const String pleaseAddSignature = 'Please Add Signature!';
  static const String clear = 'Clear';
  static const String signed = 'Signed';
  static const String notSigned = 'Not Signed';
  static const String contractValue = 'Contract Value';
  static const String startDate = 'Start Date';
  static const String endDate = 'End Date';
  static const String contractType = 'Contract Type';
  static const String noContent = 'No Content';

  // Estimate
  static const String estimates = 'Estimates';
  static const String estimate = 'Estimate';
  static const String estimateSummery = 'Estimate Summery';
  static const String estimateDetails = 'Estimate Details';
  static const String sent = 'Sent';
  static const String expired = 'Expired';
  static const String accepted = 'Accepted';
  static const String declined = 'Declined';
  static const String draft = 'Draft';
  static const String to = 'To';
  static const String estimateDate = 'Estimate Date';
  static const String expiryDate = 'Expiry Date';
  static const String referenceNo = 'Reference No';
  static const String subtotal = 'Subtotal';
  static const String total = 'Total';
  static const String clientNote = 'Client Note';
  static const String signatureConfirmationOfIdentity =
      'Signature & Confirmation Of Identity';
  static const String entersignature = "Enter Signature";
  static const String rejectEstimate = "Reject Estimate";
  static const String rejectEstimateConfirm =
      "Are you sure you want to reject this estimate?";

  // Project
  static const String project = 'Project';
  static const String projects = 'Projects';
  static const String projectSummery = 'Project Summery';
  static const String notStarted = 'Not Started';
  static const String inProgress = 'In Progress';
  static const String onHold = 'On Hold';
  static const String finished = 'Finished';
  static const String cancelled = "Cancelled";
  static const String filter = 'Filter';
  static const String projectDetails = 'Project Details';
  static const String description = 'Description';
  static const String customer = 'Customer';
  static const String billingType = 'Billing Type';
  static const String fixedRate = 'Fixed Rate';
  static const String projectHours = 'Project Hours';
  static const String taskHours = 'Task Hours';
  static const String totalRate = 'Total Rate';
  static const String hours = 'Hours';
  static const String deadline = 'Deadline';
  static const String logged = 'Logged';
  static const String totalExpenses = 'Total Expenses';
  static const String billableExpenses = 'Billable Expenses';
  static const String billedExpenses = 'Billed Expenses';
  static const String unbilledExpenses = 'Unbilled Expenses';
  static const String projectProgress = 'Project Progress';
  static const String openTasks = 'Open Tasks';
  static const String daysLeft = 'Days Left';
  static const String overview = 'Overview';
  static const String discussion = 'Discussion';
  static const String comment = 'Comment';
  static const String comments = 'Comments';
  static const String addComment = 'Add Comment';
  static const String discussionDetails = 'Discussion Details';
  static const String tasks = 'Tasks';
  static const String taskDetails = 'Task Details';

  // Add New Task
  static const String createNewTask = 'Create New Task';
  static const String taskTitle = 'Task Title';
  static const String enterTaskTitle = 'Please, Enter Task Title.';
  static const String taskNameFieldErrorMsg = "Please, fill up Task Name field";
  static const String taskStartDate = 'Start Date';
  static const String enterTaskStartDate = 'Please, Enter Task Start Date.';
  static const String taskDueDate = 'Due Date';
  static const String enterTaskDueDate = 'Please, Enter Task Due Date.';
  static const String priorityHigh = 'High';
  static const String priorityMedium = 'Medium';
  static const String priorityLow = 'Low';
  static const String assignees = 'Assignees';
  static const String selectAssignees = 'Select Assignees';
  static const String taskPriorityFieldErrorMsg =
      "Please, select your Task Priority";
  static const String taskStartDateFieldErrorMsg =
      "Please, fill up Start Date field";
  static const String taskDueDateFieldErrorMsg =
      "Please, fill up Due Date field";
  static const String taskDescriptionFieldErrorMsg =
      "Please, fill up Task Description field";
  static const String editTask = 'Edit Task';
  static const String taskUpdateErrorMsg = "You're Not Allowed to Update Tasks";

  // Invoice
  static const String invoice = 'Invoice';
  static const String invoices = 'Invoices';
  static const String invoiceDetails = 'Invoice Details';
  static const String invoiceSummery = 'Invoice Summery';
  static const String overdue = 'Overdue';
  static const String partialyPaid = 'Partially Paid';
  static const String billTo = 'Bill to';
  static const String invoiceDate = 'Invoice Date';
  static const String dueDate = 'Due Date';
  static const String totalPaid = 'Total Paid';
  static const String amountDue = 'Amount Due';
  static const String transactions = 'Transactions';
  static const String id = 'ID';
  static const String qty = 'Qty';
  static const String item = 'Item';
  static const String rate = 'Rate';
  static const String paymentMode = 'Payment Mode';
  static const String date = 'Date';
  static const String amount = 'Amount';
  static const String company = 'Company';
  static const String payment = 'Payment';
  static const String adminNote = 'Admin Note';
  static const String tax = 'Tax';
  static const String discount = 'Discount';
  static const String items = 'Items';

  // Proposal
  static const String proposal = 'Proposal';
  static const String proposals = 'Proposals';
  static const String proposalDetails = 'Proposal Details';
  static const String proposalSummery = 'Proposal Summery';
  static const String openTill = 'Open till';
  static const String totalTax = 'Total Tax';
  static const String adjustment = 'Adjustment';
  static const String revised = 'Revised';
  static const String enterComment = 'Please, Enter Proposal Comment.';
  static const String staff = 'Staff';

  // Ticket
  static const String ticket = 'Ticket';
  static const String tickets = 'Tickets';
  static const String ticketDetails = 'Ticket Details';
  static const String ticketSummery = 'Ticket Summery';
  static const String open = 'Open';
  static const String answered = 'Answered';
  static const String closed = 'Closed';
  static const String reply = 'Reply';
  static const String ticketLinked = 'This Ticket is Linked to the Project';
  static const String department = 'Department';
  static const String selectDepartment = 'Select Department';
  static const String contact = 'Contact';
  static const String submitted = 'Submitted';
  static const String priority = 'Priority';
  static const String selectPriority = 'Select Priority';
  static const String service = 'Service';
  static const String createNewTicket = 'Create New Ticket';
  static const String subject = 'Subject';
  static const String enterTicketSubject = 'Please, Enter Ticket Subject.';
  static const String enterTicketDescription =
      "Please, fill up Ticket Description field";
  static const String ticketReply = 'Add Ticket Reply';
  static const String ticketReplies = 'Ticket Replies';
  static const String ticketMessage = 'Message';
  static const String enterTicketReply = 'Please, Enter Ticket Reply.';
  static const String attachment = "Attachment";
  static const String selectTicketAttachment = "No File Attached";

  // KNOWLEDGE_BASE
  static const String knowledgeBase = 'Knowledge Base';
  static const String knowledgeBaseDetails = 'Knowledge Base Details';
}

class Messages extends Translations {
  final Map<String, Map<String, String>> languages;
  Messages({required this.languages});

  @override
  Map<String, Map<String, String>> get keys {
    return languages;
  }
}
