class ProjectDetailsModel {
  ProjectDetailsModel({
    bool? status,
    String? message,
    ProjectDetails? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ProjectDetailsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? ProjectDetails.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  ProjectDetails? _data;

  bool? get status => _status;
  String? get message => _message;
  ProjectDetails? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class ProjectDetails {
  ProjectDetails({
    String? id,
    String? name,
    String? description,
    String? status,
    String? clientId,
    String? billingType,
    String? startDate,
    String? deadline,
    String? projectCreated,
    String? progress,
    String? progressFromTasks,
    String? projectCost,
    String? projectRatePerHour,
    String? addedFrom,
    String? contactNotification,
    String? notifyContacts,
    Settings? settings,
    ClientData? clientData,
    List<ProjectMembers>? projectMembers,
    String? statusName,
    String? addedFromName,
  }) {
    _id = id;
    _name = name;
    _description = description;
    _status = status;
    _clientId = clientId;
    _billingType = billingType;
    _deadline = deadline;
    _deadline = deadline;
    _projectCreated = projectCreated;
    _progress = progress;
    _progressFromTasks = progressFromTasks;
    _projectCost = projectCost;
    _projectRatePerHour = projectRatePerHour;
    _addedFrom = addedFrom;
    _contactNotification = contactNotification;
    _notifyContacts = notifyContacts;
    _settings = settings;
    _clientData = clientData;
    _projectMembers = projectMembers;
    _statusName = statusName;
    _addedFromName = addedFromName;
  }

  ProjectDetails.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _status = json['status'];
    _clientId = json['clientid'];
    _billingType = json['billing_type'];
    _startDate = json['start_date'];
    _deadline = json['deadline'];
    _projectCreated = json['project_created'];
    _progress = json['progress'];
    _progressFromTasks = json['progress_from_tasks'];
    _projectCost = json['project_cost'];
    _projectRatePerHour = json['project_rate_per_hour'];
    _addedFrom = json['addedfrom'];
    _contactNotification = json['contact_notification'];
    _notifyContacts = json['notify_contacts'];
    _settings = Settings.fromJson(json['settings']);
    _clientData = ClientData.fromJson(json['client_data']);
    if (json['project_members'] != null) {
      _projectMembers = [];
      json['project_members'].forEach((v) {
        _projectMembers?.add(ProjectMembers.fromJson(v));
      });
    }
    _statusName = json['status_name'];
    _addedFromName = json['addedfrom_name'];
  }

  String? _id;
  String? _name;
  String? _description;
  String? _status;
  String? _clientId;
  String? _billingType;
  String? _startDate;
  String? _deadline;
  String? _projectCreated;
  String? _progress;
  String? _progressFromTasks;
  String? _projectCost;
  String? _projectRatePerHour;
  String? _addedFrom;
  String? _contactNotification;
  String? _notifyContacts;
  Settings? _settings;
  ClientData? _clientData;
  List<ProjectMembers>? _projectMembers;
  String? _statusName;
  String? _addedFromName;

  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get status => _status;
  String? get clientId => _clientId;
  String? get billingType => _billingType;
  String? get startDate => _startDate;
  String? get deadline => _deadline;
  String? get projectCreated => _projectCreated;
  String? get progress => _progress;
  String? get progressFromTasks => _progressFromTasks;
  String? get projectCost => _projectCost;
  String? get projectRatePerHour => _projectRatePerHour;
  String? get addedFrom => _addedFrom;
  String? get contactNotification => _contactNotification;
  String? get notifyContacts => _notifyContacts;
  Settings? get settings => _settings;
  ClientData? get clientData => _clientData;
  List<ProjectMembers>? get projectMembers => _projectMembers;
  String? get statusName => _statusName;
  String? get addedFromName => _addedFromName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['status'] = _status;
    map['clientid'] = _clientId;
    map['billing_type'] = _billingType;
    map['start_date'] = _startDate;
    map['deadline'] = _deadline;
    map['project_created'] = _projectCreated;
    map['progress'] = _progress;
    map['progress_from_tasks'] = _progressFromTasks;
    map['project_cost'] = _projectCost;
    map['project_rate_per_hour'] = _projectRatePerHour;
    map['addedfrom'] = _addedFrom;
    map['contact_notification'] = _contactNotification;
    map['notify_contacts'] = _notifyContacts;
    map['status_name'] = _statusName;
    map['addedfrom_name'] = _addedFromName;
    if (_settings != null) {
      map['settings'] = _settings?.toJson();
    }
    if (_clientData != null) {
      map['client_data'] = _clientData?.toJson();
    }
    if (_projectMembers != null) {
      map['project_members'] = _projectMembers?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Settings {
  Settings({
    String? viewTasks,
    String? createTasks,
    String? editTasks,
    String? commentOnTasks,
    String? viewTaskComments,
    String? viewTaskAttachments,
    String? viewTaskChecklistItems,
    String? uploadOnTasks,
    String? viewTaskTotalLoggedTime,
    String? viewFinanceOverview,
    String? uploadFiles,
    String? openDiscussions,
    String? viewMilestones,
    String? viewGantt,
    String? viewTimeSheets,
    String? viewActivityLog,
    String? viewTeamMembers,
    String? hideTasksOnMainTasksTable,
    AvailableFeatures? availableFeatures,
  }) {
    _viewTasks = viewTasks;
    _createTasks = createTasks;
    _editTasks = editTasks;
    _commentOnTasks = commentOnTasks;
    _viewTaskComments = viewTaskComments;
    _viewTaskAttachments = viewTaskAttachments;
    _viewTaskChecklistItems = viewTaskChecklistItems;
    _uploadOnTasks = uploadOnTasks;
    _viewTaskTotalLoggedTime = viewTaskTotalLoggedTime;
    _viewFinanceOverview = viewFinanceOverview;
    _uploadFiles = uploadFiles;
    _openDiscussions = openDiscussions;
    _viewMilestones = viewMilestones;
    _viewGantt = viewGantt;
    _viewTimeSheets = viewTimeSheets;
    _viewActivityLog = viewActivityLog;
    _viewTeamMembers = viewTeamMembers;
    _hideTasksOnMainTasksTable = hideTasksOnMainTasksTable;
    _availableFeatures = availableFeatures;
  }

  Settings.fromJson(dynamic json) {
    _viewTasks = json['view_tasks'];
    _createTasks = json['create_tasks'];
    _editTasks = json['edit_tasks'];
    _commentOnTasks = json['comment_on_tasks'];
    _viewTaskComments = json['view_task_comments'];
    _viewTaskAttachments = json['view_task_attachments'];
    _viewTaskChecklistItems = json['view_task_checklist_items'];
    _uploadOnTasks = json['upload_on_tasks'];
    _viewTaskTotalLoggedTime = json['view_task_total_logged_time'];
    _viewFinanceOverview = json['view_finance_overview'];
    _uploadFiles = json['upload_files'];
    _openDiscussions = json['open_discussions'];
    _viewMilestones = json['view_milestones'];
    _viewGantt = json['view_gantt'];
    _viewTimeSheets = json['view_timesheets'];
    _viewActivityLog = json['view_activity_log'];
    _viewTeamMembers = json['view_team_members'];
    _hideTasksOnMainTasksTable = json['hide_tasks_on_main_tasks_table'];
    _availableFeatures = json['available_features'] != null
        ? AvailableFeatures.fromJson(json['available_features'])
        : null;
  }
  String? _viewTasks;
  String? _createTasks;
  String? _editTasks;
  String? _commentOnTasks;
  String? _viewTaskComments;
  String? _viewTaskAttachments;
  String? _viewTaskChecklistItems;
  String? _uploadOnTasks;
  String? _viewTaskTotalLoggedTime;
  String? _viewFinanceOverview;
  String? _uploadFiles;
  String? _openDiscussions;
  String? _viewMilestones;
  String? _viewGantt;
  String? _viewTimeSheets;
  String? _viewActivityLog;
  String? _viewTeamMembers;
  String? _hideTasksOnMainTasksTable;
  AvailableFeatures? _availableFeatures;

  String? get viewTasks => _viewTasks;
  String? get createTasks => _createTasks;
  String? get editTasks => _editTasks;
  String? get commentOnTasks => _commentOnTasks;
  String? get viewTaskComments => _viewTaskComments;
  String? get viewTaskAttachments => _viewTaskAttachments;
  String? get viewTaskChecklistItems => _viewTaskChecklistItems;
  String? get uploadOnTasks => _uploadOnTasks;
  String? get viewTaskTotalLoggedTime => _viewTaskTotalLoggedTime;
  String? get viewFinanceOverview => _viewFinanceOverview;
  String? get uploadFiles => _uploadFiles;
  String? get openDiscussions => _openDiscussions;
  String? get viewMilestones => _viewMilestones;
  String? get viewGantt => _viewGantt;
  String? get viewTimeSheets => _viewTimeSheets;
  String? get viewActivityLog => _viewActivityLog;
  String? get viewTeamMembers => _viewTeamMembers;
  String? get hideTasksOnMainTasksTable => _hideTasksOnMainTasksTable;
  AvailableFeatures? get availableFeatures => _availableFeatures;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    _viewTasks = map['view_tasks'];
    _createTasks = map['create_tasks'];
    _editTasks = map['edit_tasks'];
    _commentOnTasks = map['comment_on_tasks'];
    _viewTaskComments = map['view_task_comments'];
    _viewTaskAttachments = map['view_task_attachments'];
    _viewTaskChecklistItems = map['view_task_checklist_items'];
    _uploadOnTasks = map['upload_on_tasks'];
    _viewTaskTotalLoggedTime = map['view_task_total_logged_time'];
    _viewFinanceOverview = map['view_finance_overview'];
    _uploadFiles = map['upload_files'];
    _openDiscussions = map['open_discussions'];
    _viewMilestones = map['view_milestones'];
    _viewGantt = map['view_gantt'];
    _viewTimeSheets = map['view_timesheets'];
    _viewActivityLog = map['view_activity_log'];
    _viewTeamMembers = map['view_team_members'];
    _hideTasksOnMainTasksTable = map['hide_tasks_on_main_tasks_table'];
    if (_availableFeatures != null) {
      map['available_features'] = _availableFeatures?.toJson();
    }
    return map;
  }
}

class AvailableFeatures {
  AvailableFeatures({
    int? projectOverview,
    int? projectTasks,
    int? projectTimeSheets,
    int? projectMilestones,
    int? projectFiles,
    int? projectDiscussions,
    int? projectGantt,
    int? projectTickets,
    int? projectContracts,
    int? projectProposals,
    int? projectEstimates,
    int? projectInvoices,
    int? projectSubscriptions,
    int? projectExpenses,
    int? projectCreditNotes,
    int? projectNotes,
    int? projectActivity,
  }) {
    _projectOverview = projectOverview;
    _projectTasks = projectTasks;
    _projectTimeSheets = projectTimeSheets;
    _projectMilestones = projectMilestones;
    _projectFiles = projectFiles;
    _projectDiscussions = projectDiscussions;
    _projectGantt = projectGantt;
    _projectTickets = projectTickets;
    _projectContracts = projectContracts;
    _projectProposals = projectProposals;
    _projectEstimates = projectEstimates;
    _projectInvoices = projectInvoices;
    _projectSubscriptions = projectSubscriptions;
    _projectExpenses = projectExpenses;
    _projectCreditNotes = projectCreditNotes;
    _projectNotes = projectNotes;
    _projectActivity = projectActivity;
  }

  AvailableFeatures.fromJson(dynamic json) {
    _projectOverview = json['project_overview'];
    _projectTasks = json['project_tasks'];
    _projectTimeSheets = json['project_timesheets'];
    _projectMilestones = json['project_milestones'];
    _projectFiles = json['project_files'];
    _projectDiscussions = json['project_discussions'];
    _projectGantt = json['project_gantt'];
    _projectTickets = json['project_tickets'];
    _projectContracts = json['project_contracts'];
    _projectProposals = json['project_proposals'];
    _projectEstimates = json['project_estimates'];
    _projectInvoices = json['project_invoices'];
    _projectSubscriptions = json['project_subscriptions'];
    _projectExpenses = json['project_expenses'];
    _projectCreditNotes = json['project_credit_notes'];
    _projectNotes = json['project_notes'];
    _projectActivity = json['project_activity'];
  }
  int? _projectOverview;
  int? _projectTasks;
  int? _projectTimeSheets;
  int? _projectMilestones;
  int? _projectFiles;
  int? _projectDiscussions;
  int? _projectGantt;
  int? _projectTickets;
  int? _projectContracts;
  int? _projectProposals;
  int? _projectEstimates;
  int? _projectInvoices;
  int? _projectSubscriptions;
  int? _projectExpenses;
  int? _projectCreditNotes;
  int? _projectNotes;
  int? _projectActivity;

  int? get projectOverview => _projectOverview;
  int? get projectTasks => _projectTasks;
  int? get projectTimeSheets => _projectTimeSheets;
  int? get projectMilestones => _projectMilestones;
  int? get projectFiles => _projectFiles;
  int? get projectDiscussions => _projectDiscussions;
  int? get projectGantt => _projectGantt;
  int? get projectTickets => _projectTickets;
  int? get projectContracts => _projectContracts;
  int? get projectProposals => _projectProposals;
  int? get projectEstimates => _projectEstimates;
  int? get projectInvoices => _projectInvoices;
  int? get projectSubscriptions => _projectSubscriptions;
  int? get projectExpenses => _projectExpenses;
  int? get projectCreditNotes => _projectCreditNotes;
  int? get projectNotes => _projectNotes;
  int? get projectActivity => _projectActivity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['project_overview'] = _projectOverview;
    map['project_tasks'] = _projectTasks;
    map['project_timesheets'] = _projectTimeSheets;
    map['project_milestones'] = _projectMilestones;
    map['project_files'] = _projectFiles;
    map['project_discussions'] = _projectDiscussions;
    map['project_gantt'] = _projectGantt;
    map['project_tickets'] = _projectTickets;
    map['project_contracts'] = _projectContracts;
    map['project_proposals'] = _projectProposals;
    map['project_estimates'] = _projectEstimates;
    map['project_invoices'] = _projectInvoices;
    map['project_subscriptions'] = _projectSubscriptions;
    map['project_expenses'] = _projectExpenses;
    map['project_credit_notes'] = _projectCreditNotes;
    map['project_notes'] = _projectNotes;
    map['project_activity'] = _projectActivity;
    return map;
  }
}

class ClientData {
  ClientData({
    String? userid,
    String? company,
    String? phoneNumber,
    String? country,
    String? city,
    String? zip,
    String? state,
    String? address,
    String? website,
    String? dateCreated,
    String? active,
    String? billingStreet,
    String? billingCity,
    String? billingState,
    String? billingZip,
    String? billingCountry,
    String? shippingStreet,
    String? shippingCity,
    String? shippingState,
    String? shippingZip,
    String? shippingCountry,
    String? defaultLanguage,
    String? defaultCurrency,
    String? showPrimaryContact,
    String? registrationConfirmed,
    String? addedFrom,
  }) {
    _userid = userid;
    _company = company;
    _phoneNumber = phoneNumber;
    _country = country;
    _city = city;
    _zip = zip;
    _state = state;
    _address = address;
    _website = website;
    _dateCreated = dateCreated;
    _active = active;
    _billingStreet = billingStreet;
    _billingCity = billingCity;
    _billingState = billingState;
    _billingZip = billingZip;
    _billingCountry = billingCountry;
    _shippingStreet = shippingStreet;
    _shippingCity = shippingCity;
    _shippingState = shippingState;
    _shippingZip = shippingZip;
    _shippingCountry = shippingCountry;
    _defaultLanguage = defaultLanguage;
    _defaultCurrency = defaultCurrency;
    _showPrimaryContact = showPrimaryContact;
    _registrationConfirmed = registrationConfirmed;
    _addedFrom = addedFrom;
  }

  ClientData.fromJson(dynamic json) {
    _userid = json['userid'];
    _company = json['company'];
    _phoneNumber = json['phonenumber'];
    _country = json['country'];
    _city = json['city'];
    _zip = json['zip'];
    _state = json['state'];
    _address = json['address'];
    _website = json['website'];
    _dateCreated = json['datecreated'];
    _active = json['active'];
    _billingStreet = json['billing_street'];
    _billingCity = json['billing_city'];
    _billingState = json['billing_state'];
    _billingZip = json['billing_zip'];
    _billingCountry = json['billing_country'];
    _shippingStreet = json['shipping_street'];
    _shippingCity = json['shipping_city'];
    _shippingState = json['shipping_state'];
    _shippingZip = json['shipping_zip'];
    _shippingCountry = json['shipping_country'];
    _defaultLanguage = json['default_language'];
    _defaultCurrency = json['default_currency'];
    _showPrimaryContact = json['show_primary_contact'];
    _registrationConfirmed = json['registration_confirmed'];
    _addedFrom = json['addedfrom'];
  }
  String? _userid;
  String? _company;
  String? _phoneNumber;
  String? _country;
  String? _city;
  String? _zip;
  String? _state;
  String? _address;
  String? _website;
  String? _dateCreated;
  String? _active;
  String? _billingStreet;
  String? _billingCity;
  String? _billingState;
  String? _billingZip;
  String? _billingCountry;
  String? _shippingStreet;
  String? _shippingCity;
  String? _shippingState;
  String? _shippingZip;
  String? _shippingCountry;
  String? _defaultLanguage;
  String? _defaultCurrency;
  String? _showPrimaryContact;
  String? _registrationConfirmed;
  String? _addedFrom;

  String? get userid => _userid;
  String? get company => _company;
  String? get phoneNumber => _phoneNumber;
  String? get country => _country;
  String? get city => _city;
  String? get zip => _zip;
  String? get state => _state;
  String? get address => _address;
  String? get website => _website;
  String? get dateCreated => _dateCreated;
  String? get active => _active;
  String? get billingStreet => _billingStreet;
  String? get billingCity => _billingCity;
  String? get billingState => _billingState;
  String? get billingZip => _billingZip;
  String? get billingCountry => _billingCountry;
  String? get shippingStreet => _shippingStreet;
  String? get shippingCity => _shippingCity;
  String? get shippingState => _shippingState;
  String? get shippingZip => _shippingZip;
  String? get shippingCountry => _shippingCountry;
  String? get defaultLanguage => _defaultLanguage;
  String? get defaultCurrency => _defaultCurrency;
  String? get showPrimaryContact => _showPrimaryContact;
  String? get registrationConfirmed => _registrationConfirmed;
  String? get addedFrom => _addedFrom;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userid'] = _userid;
    map['company'] = _company;
    map['phonenumber'] = _phoneNumber;
    map['country'] = _country;
    map['city'] = _city;
    map['zip'] = _zip;
    map['state'] = _state;
    map['address'] = _address;
    map['website'] = _website;
    map['datecreated'] = _dateCreated;
    map['active'] = _active;
    map['billing_street'] = _billingStreet;
    map['billing_city'] = _billingCity;
    map['billing_state'] = _billingState;
    map['billing_zip'] = _billingZip;
    map['billing_country'] = _billingCountry;
    map['shipping_street'] = _shippingStreet;
    map['shipping_city'] = _shippingCity;
    map['shipping_state'] = _shippingState;
    map['shipping_zip'] = _shippingZip;
    map['shipping_country'] = _shippingCountry;
    map['default_language'] = _defaultLanguage;
    map['default_currency'] = _defaultCurrency;
    map['show_primary_contact'] = _showPrimaryContact;
    map['registration_confirmed'] = _registrationConfirmed;
    map['addedfrom'] = _addedFrom;
    return map;
  }
}

class ProjectMembers {
  ProjectMembers({
    String? email,
    String? projectId,
    String? staffId,
    String? staffName,
  }) {
    _email = email;
    _projectId = projectId;
    _staffId = staffId;
    _staffName = staffName;
  }

  ProjectMembers.fromJson(dynamic json) {
    _email = json['email'].toString();
    _projectId = json['project_id'];
    _staffId = json['staff_id'];
    _staffName = json['staff_name'].toString();
  }
  String? _email;
  String? _projectId;
  String? _staffId;
  String? _staffName;

  String? get email => _email;
  String? get projectId => _projectId;
  String? get staffId => _staffId;
  String? get staffName => _staffName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['project_id'] = _projectId;
    map['staff_id'] = _staffId;
    map['staff_name'] = _staffName;
    return map;
  }
}
