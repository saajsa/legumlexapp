class DashboardModel {
  DashboardModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  DashboardModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;

  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    String? clientId,
    String? clientName,
    String? contactFirstName,
    String? contactLastName,
    String? contactEmail,
    String? contactPhone,
    String? contactTitle,
    String? contactActive,
    String? contactImage,
    String? perfexLogo,
    String? perfexLogoDark,
    int? projectsNotStarted,
    int? projectsInProgress,
    int? projectsOnHold,
    int? projectsFinished,
    int? invoicesTotal,
    int? invoicesUnPaid,
    int? invoicesPaid,
    int? invoicesOverdue,
    int? invoicesPartiallyPaid,
    int? estimatesDraft,
    int? estimatesExpired,
    int? estimatesSent,
    int? estimatesDeclined,
    int? estimatesAccepted,
    int? proposalsOpen,
    int? proposalsDeclined,
    int? proposalsAccepted,
    int? proposalsSent,
    int? proposalsRevised,
    int? ticketsOpen,
    int? ticketsInProgress,
    int? ticketsAnswered,
    int? ticketsClosed,
    String? contactId,
    String? token,
    bool? clientLoggedIn,
    int? apiTime,
  }) {
    _clientId = clientId;
    _clientName = clientName;
    _contactFirstName = contactFirstName;
    _contactLastName = contactLastName;
    _contactEmail = contactEmail;
    _contactPhone = contactPhone;
    _contactTitle = contactTitle;
    _contactActive = contactActive;
    _contactImage = contactImage;
    _perfexLogo = perfexLogo;
    _perfexLogoDark = perfexLogoDark;
    _projectsNotStarted = projectsNotStarted;
    _projectsInProgress = projectsInProgress;
    _projectsOnHold = projectsOnHold;
    _projectsFinished = projectsFinished;
    _invoicesTotal = invoicesTotal;
    _invoicesUnPaid = invoicesUnPaid;
    _invoicesPaid = invoicesPaid;
    _invoicesOverdue = invoicesOverdue;
    _invoicesPartiallyPaid = invoicesPartiallyPaid;
    _estimatesDraft = estimatesDraft;
    _estimatesExpired = estimatesExpired;
    _estimatesSent = estimatesSent;
    _estimatesDeclined = estimatesDeclined;
    _estimatesAccepted = estimatesAccepted;
    _proposalsOpen = proposalsOpen;
    _proposalsDeclined = proposalsDeclined;
    _proposalsAccepted = proposalsAccepted;
    _proposalsSent = proposalsSent;
    _proposalsRevised = proposalsRevised;
    _ticketsOpen = ticketsOpen;
    _ticketsInProgress = ticketsInProgress;
    _ticketsAnswered = ticketsAnswered;
    _ticketsClosed = ticketsClosed;
    _contactId = contactId;
    _token = token;
    _clientLoggedIn = clientLoggedIn;
    _apiTime = apiTime;
  }

  Data.fromJson(dynamic json) {
    _clientId = json['client_id'];
    _clientName = json['client_name'];
    _contactFirstName = json['contact_firstname'];
    _contactLastName = json['contact_lastname'];
    _contactEmail = json['contact_email'];
    _contactPhone = json['contact_phone'];
    _contactTitle = json['contact_title'];
    _contactActive = json['contact_active'];
    _contactImage = json['contact_image'];
    _perfexLogo = json['perfex_logo'];
    _perfexLogoDark = json['perfex_logo_dark'];
    _projectsNotStarted = json['projects_notstarted'];
    _projectsInProgress = json['projects_inprogress'];
    _projectsOnHold = json['projects_onhold'];
    _projectsFinished = json['projects_finished'];
    _invoicesTotal = json['invoices_total'];
    _invoicesUnPaid = json['invoices_unpaid'];
    _invoicesPaid = json['invoices_paid'];
    _invoicesOverdue = json['invoices_overdue'];
    _invoicesPartiallyPaid = json['invoices_partilypaid'];
    _estimatesDraft = json['estimates_draft'];
    _estimatesExpired = json['estimates_expired'];
    _estimatesSent = json['estimates_sent'];
    _estimatesDeclined = json['estimates_declined'];
    _estimatesAccepted = json['estimates_accepted'];
    _proposalsOpen = json['proposals_open'];
    _proposalsDeclined = json['proposals_declined'];
    _proposalsAccepted = json['proposals_accepted'];
    _proposalsSent = json['proposals_sent'];
    _proposalsRevised = json['proposals_revised'];
    _ticketsOpen = json['tickets_open'];
    _ticketsInProgress = json['tickets_inprogress'];
    _ticketsAnswered = json['tickets_answered'];
    _ticketsClosed = json['tickets_closed'];
    _contactId = json['contact_id'];
    _token = json['token'];
    _clientLoggedIn = json['client_logged_in'];
    _apiTime = json['API_TIME'];
  }
  String? _clientId;
  String? _clientName;
  String? _contactFirstName;
  String? _contactLastName;
  String? _contactEmail;
  String? _contactPhone;
  String? _contactTitle;
  String? _contactActive;
  String? _contactImage;
  String? _perfexLogo;
  String? _perfexLogoDark;
  int? _projectsNotStarted;
  int? _projectsInProgress;
  int? _projectsOnHold;
  int? _projectsFinished;
  int? _invoicesTotal;
  int? _invoicesUnPaid;
  int? _invoicesPaid;
  int? _invoicesOverdue;
  int? _invoicesPartiallyPaid;
  int? _estimatesDraft;
  int? _estimatesExpired;
  int? _estimatesSent;
  int? _estimatesDeclined;
  int? _estimatesAccepted;
  int? _proposalsOpen;
  int? _proposalsDeclined;
  int? _proposalsAccepted;
  int? _proposalsSent;
  int? _proposalsRevised;
  int? _ticketsOpen;
  int? _ticketsInProgress;
  int? _ticketsAnswered;
  int? _ticketsClosed;
  String? _contactId;
  String? _token;
  bool? _clientLoggedIn;
  int? _apiTime;

  String? get clientId => _clientId;
  String? get clientName => _clientName;
  String? get contactFirstName => _contactFirstName;
  String? get contactLastName => _contactLastName;
  String? get contactEmail => _contactEmail;
  String? get contactPhone => _contactPhone;
  String? get contactTitle => _contactTitle;
  String? get contactActive => _contactActive;
  String? get contactImage => _contactImage;
  String? get perfexLogo => _perfexLogo;
  String? get perfexLogoDark => _perfexLogoDark;
  int? get projectsNotStarted => _projectsNotStarted;
  int? get projectsInProgress => _projectsInProgress;
  int? get projectsOnHold => _projectsOnHold;
  int? get projectsFinished => _projectsFinished;
  int? get invoicesTotal => _invoicesTotal;
  int? get invoicesUnPaid => _invoicesUnPaid;
  int? get invoicesPaid => _invoicesPaid;
  int? get invoicesOverdue => _invoicesOverdue;
  int? get invoicesPartiallyPaid => _invoicesPartiallyPaid;
  int? get estimatesDraft => _estimatesDraft;
  int? get estimatesExpired => _estimatesExpired;
  int? get estimatesSent => _estimatesSent;
  int? get estimatesDeclined => _estimatesDeclined;
  int? get estimatesAccepted => _estimatesAccepted;
  int? get proposalsOpen => _proposalsOpen;
  int? get proposalsDeclined => _proposalsDeclined;
  int? get proposalsAccepted => _proposalsAccepted;
  int? get proposalsSent => _proposalsSent;
  int? get proposalsRevised => _proposalsRevised;
  int? get ticketsOpen => _ticketsOpen;
  int? get ticketsInProgress => _ticketsInProgress;
  int? get ticketsAnswered => _ticketsAnswered;
  int? get ticketsClosed => _ticketsClosed;
  String? get contactId => _contactId;
  String? get token => _token;
  bool? get clientLoggedIn => _clientLoggedIn;
  int? get apiTime => _apiTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['client_id'] = _clientId;
    map['client_name'] = _clientName;
    map['contact_firstname'] = _contactFirstName;
    map['contact_lastname'] = _contactLastName;
    map['contact_email'] = _contactEmail;
    map['contact_phone'] = _contactPhone;
    map['contact_title'] = _contactTitle;
    map['contact_active'] = _contactActive;
    map['contact_image'] = _contactImage;
    map['perfex_logo'] = _perfexLogo;
    map['perfex_logo_dark'] = _perfexLogoDark;
    map['projects_notstarted'] = _projectsNotStarted;
    map['projects_inprogress'] = _projectsInProgress;
    map['projects_onhold'] = _projectsOnHold;
    map['projects_finished'] = _projectsFinished;
    map['invoices_unpaid'] = _invoicesTotal;
    map['invoices_unpaid'] = _invoicesUnPaid;
    map['invoices_paid'] = _invoicesPaid;
    map['invoices_overdue'] = _invoicesOverdue;
    map['invoices_partilypaid'] = _invoicesPartiallyPaid;
    map['estimates_draft'] = _estimatesDraft;
    map['estimates_expired'] = _estimatesExpired;
    map['estimates_sent'] = _estimatesSent;
    map['estimates_declined'] = _estimatesDeclined;
    map['estimates_accepted'] = _estimatesAccepted;
    map['proposals_open'] = _proposalsOpen;
    map['proposals_declined'] = _proposalsDeclined;
    map['proposals_accepted'] = _proposalsAccepted;
    map['proposals_sent'] = _proposalsSent;
    map['proposals_revised'] = _proposalsRevised;
    map['tickets_open'] = _ticketsOpen;
    map['tickets_inprogress'] = _ticketsInProgress;
    map['tickets_answered'] = _ticketsAnswered;
    map['tickets_closed'] = _ticketsClosed;
    map['contact_id'] = _contactId;
    map['token'] = _token;
    map['client_logged_in'] = _clientLoggedIn;
    map['API_TIME'] = _apiTime;
    return map;
  }
}
