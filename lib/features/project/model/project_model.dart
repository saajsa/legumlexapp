class ProjectsModel {
  ProjectsModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ProjectsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
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
    String? projectRatePerHour,
    String? addedFrom,
    String? contactNotification,
    String? notifyContacts,
    String? userId,
    String? company,
    String? vat,
    String? phoneNumber,
    String? country,
    String? city,
    String? zip,
    String? state,
    String? address,
    String? website,
    String? datecreated,
    String? active,
    String? billingStreet,
    String? billingCity,
    String? billingState,
    String? billingZip,
    String? billingCountry,
    String? shippingCountry,
    String? defaultLanguage,
    String? defaultCurrency,
    String? showPrimaryContact,
    String? registrationConfirmed,
    String? statusName,
    String? addedFromName,
  }) {
    _id = id;
    _name = name;
    _description = description;
    _status = status;
    _clientId = clientId;
    _billingType = billingType;
    _startDate = startDate;
    _deadline = deadline;
    _projectCreated = projectCreated;
    _progress = progress;
    _progressFromTasks = progressFromTasks;
    _projectRatePerHour = projectRatePerHour;
    _addedFrom = addedFrom;
    _contactNotification = contactNotification;
    _notifyContacts = notifyContacts;
    _userId = userId;
    _company = company;
    _vat = vat;
    _phoneNumber = phoneNumber;
    _country = country;
    _city = city;
    _zip = zip;
    _state = state;
    _address = address;
    _website = website;
    _datecreated = datecreated;
    _active = active;
    _billingStreet = billingStreet;
    _billingCity = billingCity;
    _billingState = billingState;
    _billingZip = billingZip;
    _billingCountry = billingCountry;
    _shippingCountry = shippingCountry;
    _defaultLanguage = defaultLanguage;
    _defaultCurrency = defaultCurrency;
    _showPrimaryContact = showPrimaryContact;
    _registrationConfirmed = registrationConfirmed;
    _statusName = statusName;
    _addedFromName = addedFromName;
  }
  Data.fromJson(dynamic json) {
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
    _projectRatePerHour = json['project_rate_per_hour'];
    _addedFrom = json['addedfrom'];
    _contactNotification = json['contact_notification'];
    _notifyContacts = json['notify_contacts'];
    _userId = json['userid'];
    _company = json['company'];
    _vat = json['vat'];
    _phoneNumber = json['phonenumber'];
    _country = json['country'];
    _city = json['city'];
    _zip = json['zip'];
    _state = json['state'];
    _address = json['address'];
    _website = json['website'];
    _datecreated = json['datecreated'];
    _active = json['active'];
    _billingStreet = json['billing_street'];
    _billingCity = json['billing_city'];
    _billingState = json['billing_state'];
    _billingZip = json['billing_zip'];
    _billingCountry = json['billing_country'];
    _shippingCountry = json['shipping_country'];
    _defaultLanguage = json['default_language'];
    _defaultCurrency = json['default_currency'];
    _showPrimaryContact = json['show_primary_contact'];
    _registrationConfirmed = json['registration_confirmed'];
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
  String? _projectRatePerHour;
  String? _addedFrom;
  String? _contactNotification;
  String? _notifyContacts;
  String? _userId;
  String? _company;
  String? _vat;
  String? _phoneNumber;
  String? _country;
  String? _city;
  String? _zip;
  String? _state;
  String? _address;
  String? _website;
  String? _datecreated;
  String? _active;
  String? _billingStreet;
  String? _billingCity;
  String? _billingState;
  String? _billingZip;
  String? _billingCountry;
  String? _shippingCountry;
  String? _defaultLanguage;
  String? _defaultCurrency;
  String? _showPrimaryContact;
  String? _registrationConfirmed;
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
  String? get projectRatePerHour => _projectRatePerHour;
  String? get addedFrom => _addedFrom;
  String? get contactNotification => _contactNotification;
  String? get notifyContacts => _notifyContacts;
  String? get userId => _userId;
  String? get company => _company;
  String? get vat => _vat;
  String? get phoneNumber => _phoneNumber;
  String? get country => _country;
  String? get city => _city;
  String? get zip => _zip;
  String? get state => _state;
  String? get address => _address;
  String? get website => _website;
  String? get datecreated => _datecreated;
  String? get active => _active;
  String? get billingStreet => _billingStreet;
  String? get billingCity => _billingCity;
  String? get billingState => _billingState;
  String? get billingZip => _billingZip;
  String? get billingCountry => _billingCountry;
  String? get shippingCountry => _shippingCountry;
  String? get defaultLanguage => _defaultLanguage;
  String? get defaultCurrency => _defaultCurrency;
  String? get showPrimaryContact => _showPrimaryContact;
  String? get registrationConfirmed => _registrationConfirmed;
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
    map['project_rate_per_hour'] = _projectRatePerHour;
    map['addedfrom'] = _addedFrom;
    map['contact_notification'] = _contactNotification;
    map['notify_contacts'] = _notifyContacts;
    map['userid'] = _userId;
    map['company'] = _company;
    map['vat'] = _vat;
    map['phonenumber'] = _phoneNumber;
    map['country'] = _country;
    map['city'] = _city;
    map['zip'] = _zip;
    map['state'] = _state;
    map['address'] = _address;
    map['website'] = _website;
    map['datecreated'] = _datecreated;
    map['active'] = _active;
    map['billing_street'] = _billingStreet;
    map['billing_city'] = _billingCity;
    map['billing_state'] = _billingState;
    map['billing_zip'] = _billingZip;
    map['billing_country'] = _billingCountry;
    map['shipping_country'] = _shippingCountry;
    map['default_language'] = _defaultLanguage;
    map['default_currency'] = _defaultCurrency;
    map['show_primary_contact'] = _showPrimaryContact;
    map['registration_confirmed'] = _registrationConfirmed;
    map['status_name'] = _statusName;
    map['addedfrom_name'] = _addedFromName;
    return map;
  }
}
