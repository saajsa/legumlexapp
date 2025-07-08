class InvoiceDetailsModel {
  InvoiceDetailsModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  InvoiceDetailsModel.fromJson(dynamic json) {
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
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    String? id,
    String? number,
    String? prefix,
    String? numberFormat,
    String? dateCreated,
    String? date,
    String? dueDate,
    String? currency,
    String? subtotal,
    String? totalTax,
    String? total,
    String? adjustment,
    String? addedfrom,
    String? status,
    String? clientNote,
    String? adminNote,
    String? discountPercent,
    String? discountTotal,
    String? discountType,
    String? recurring,
    String? billingStreet,
    String? billingCity,
    String? billingState,
    String? billingZip,
    String? billingCountry,
    String? includeShipping,
    String? showShippingOnInvoice,
    String? showQuantityAs,
    String? projectId,
    String? currencySymbol,
    String? currencyName,
    String? decimalSeparator,
    String? thousandSeparator,
    String? currencyPlacement,
    String? totalLefttoPay,
    ProjectData? projectData,
    ClientData? clientData,
    List<Items>? items,
    List<Payments>? payments,
    List<Attachments>? attachments,
    String? statusName,
    String? addedFromName,
  }) {
    _id = id;
    _number = number;
    _prefix = prefix;
    _numberFormat = numberFormat;
    _dateCreated = dateCreated;
    _date = date;
    _dueDate = dueDate;
    _currency = currency;
    _subtotal = subtotal;
    _totalTax = totalTax;
    _total = total;
    _adjustment = adjustment;
    _addedfrom = addedfrom;
    _status = status;
    _clientNote = clientNote;
    _adminNote = adminNote;
    _discountPercent = discountPercent;
    _discountTotal = discountTotal;
    _discountType = discountType;
    _recurring = recurring;
    _billingStreet = billingStreet;
    _billingCity = billingCity;
    _billingState = billingState;
    _billingZip = billingZip;
    _billingCountry = billingCountry;
    _includeShipping = includeShipping;
    _showShippingOnInvoice = showShippingOnInvoice;
    _showQuantityAs = showQuantityAs;
    _projectId = projectId;
    _currencySymbol = currencySymbol;
    _currencyName = currencyName;
    _decimalSeparator = decimalSeparator;
    _thousandSeparator = thousandSeparator;
    _currencyPlacement = currencyPlacement;
    _totalLefttoPay = totalLefttoPay;
    _projectData = projectData;
    _clientData = clientData;
    _items = items;
    _payments = payments;
    _attachments = attachments;
    _statusName = statusName;
    _addedFromName = addedFromName;
  }

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _number = json['number'];
    _prefix = json['prefix'];
    _numberFormat = json['number_format'];
    _dateCreated = json['datecreated'];
    _date = json['date'];
    _dueDate = json['duedate'];
    _currency = json['currency'];
    _subtotal = json['subtotal'];
    _totalTax = json['total_tax'];
    _total = json['total'];
    _adjustment = json['adjustment'];
    _addedfrom = json['addedfrom'];
    _status = json['status'];
    _clientNote = json['clientnote'];
    _adminNote = json['adminnote'];
    _discountPercent = json['discount_percent'];
    _discountTotal = json['discount_total'];
    _discountType = json['discount_type'];
    _recurring = json['recurring'];
    _billingStreet = json['billing_street'];
    _billingCity = json['billing_city'];
    _billingState = json['billing_state'];
    _billingZip = json['billing_zip'];
    _billingCountry = json['billing_country'];
    _includeShipping = json['include_shipping'];
    _showShippingOnInvoice = json['show_shipping_on_invoice'];
    _showQuantityAs = json['show_quantity_as'];
    _projectId = json['project_id'];
    _currencySymbol = json['symbol'];
    _currencyName = json['name'];
    _decimalSeparator = json['decimal_separator'];
    _thousandSeparator = json['thousand_separator'];
    _currencyPlacement = json['placement'];
    _totalLefttoPay = json['total_left_to_pay'];
    _addedFromName = json['addedfrom_name'];
    _statusName = json['status_name'];
    _clientData = ClientData.fromJson(json['client']);

    if (json['project_data'] != null) {
      _projectData = ProjectData.fromJson(json['project_data']);
    }

    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
    if (json['attachments'] != null) {
      _attachments = [];
      json['attachments'].forEach((v) {
        _attachments?.add(Attachments.fromJson(v));
      });
    }
    if (json['payments'] != null) {
      _payments = [];
      json['payments'].forEach((v) {
        _payments?.add(Payments.fromJson(v));
      });
    }
  }

  String? _id;
  String? _number;
  String? _prefix;
  String? _numberFormat;
  String? _dateCreated;
  String? _date;
  String? _dueDate;
  String? _currency;
  String? _subtotal;
  String? _totalTax;
  String? _total;
  String? _adjustment;
  String? _addedfrom;
  String? _status;
  String? _clientNote;
  String? _adminNote;
  String? _discountPercent;
  String? _discountTotal;
  String? _discountType;
  String? _recurring;
  String? _billingStreet;
  String? _billingCity;
  String? _billingState;
  String? _billingZip;
  String? _billingCountry;
  String? _includeShipping;
  String? _showShippingOnInvoice;
  String? _showQuantityAs;
  String? _projectId;
  String? _currencySymbol;
  String? _currencyName;
  String? _decimalSeparator;
  String? _thousandSeparator;
  String? _currencyPlacement;
  String? _totalLefttoPay;
  ProjectData? _projectData;
  ClientData? _clientData;
  List<Items>? _items;
  List<Payments>? _payments;
  List<Attachments>? _attachments;
  String? _statusName;
  String? _addedFromName;

  String? get id => _id;
  String? get number => _number;
  String? get prefix => _prefix;
  String? get numberFormat => _numberFormat;
  String? get dateCreated => _dateCreated;
  String? get date => _date;
  String? get dueDate => _dueDate;
  String? get currency => _currency;
  String? get subtotal => _subtotal;
  String? get totalTax => _totalTax;
  String? get total => _total;
  String? get adjustment => _adjustment;
  String? get addedfrom => _addedfrom;
  String? get status => _status;
  String? get clientNote => _clientNote;
  String? get adminNote => _adminNote;
  String? get discountPercent => _discountPercent;
  String? get discountTotal => _discountTotal;
  String? get discountType => _discountType;
  String? get recurring => _recurring;
  String? get billingStreet => _billingStreet;
  String? get billingCity => _billingCity;
  String? get billingState => _billingState;
  String? get billingZip => _billingZip;
  String? get billingCountry => _billingCountry;
  String? get includeShipping => _includeShipping;
  String? get showShippingOnInvoice => _showShippingOnInvoice;
  String? get showQuantityAs => _showQuantityAs;
  String? get projectId => _projectId;
  String? get currencySymbol => _currencySymbol;
  String? get currencyName => _currencyName;
  String? get decimalSeparator => _decimalSeparator;
  String? get thousandSeparator => _thousandSeparator;
  String? get currencyPlacement => _currencyPlacement;
  String? get totalLefttoPay => _totalLefttoPay;
  String? get statusName => _statusName;
  String? get addedFromName => _addedFromName;
  ProjectData? get projectData => _projectData;
  ClientData? get clientData => _clientData;
  List<Items>? get items => _items;
  List<Payments>? get payments => _payments;
  List<Attachments>? get attachments => _attachments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    _id = map['id'];
    _number = map['number'];
    _prefix = map['prefix'];
    _numberFormat = map['number_format'];
    _dateCreated = map['datecreated'];
    _date = map['date'];
    _dueDate = map['duedate'];
    _currency = map['currency'];
    _subtotal = map['subtotal'];
    _totalTax = map['total_tax'];
    _total = map['total'];
    _adjustment = map['adjustment'];
    _addedfrom = map['addedfrom'];
    _status = map['status'];
    _clientNote = map['clientnote'];
    _adminNote = map['adminnote'];
    _discountPercent = map['discount_percent'];
    _discountTotal = map['discount_total'];
    _discountType = map['discount_type'];
    _recurring = map['recurring'];
    _billingStreet = map['billing_street'];
    _billingCity = map['billing_city'];
    _billingState = map['billing_state'];
    _billingZip = map['billing_zip'];
    _billingCountry = map['billing_country'];
    _includeShipping = map['include_shipping'];
    _showShippingOnInvoice = map['show_shipping_on_invoice'];
    _showQuantityAs = map['show_quantity_as'];
    _projectId = map['project_id'];
    _currencySymbol = map['symbol'];
    _currencyName = map['name'];
    _decimalSeparator = map['decimal_separator'];
    _thousandSeparator = map['thousand_separator'];
    _currencyPlacement = map['placement'];
    _totalLefttoPay = map['total_left_to_pay'];
    _addedFromName = map['addedfrom_name'];
    _statusName = map['status_name'];
    if (_projectData != null) {
      map['project_data'] = _projectData?.toJson();
    }
    if (_clientData != null) {
      map['client'] = _clientData?.toJson();
    }
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    if (_attachments != null) {
      map['attachments'] = _attachments?.map((v) => v.toJson()).toList();
    }
    if (_payments != null) {
      map['payments'] = _payments?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ProjectData {
  ProjectData({
    String? id,
    String? name,
    String? description,
    String? status,
  }) {
    _id = id;
    _name = name;
    _description = description;
    _status = status;
  }

  ProjectData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _status = json['status'];
  }

  String? _id;
  String? _name;
  String? _description;
  String? _status;

  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['status'] = _status;
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
  }

  ClientData.fromJson(Map<String, dynamic> json) {
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
    return map;
  }
}

class Items {
  Items({
    String? id,
    String? relId,
    String? relType,
    String? description,
    String? longDescription,
    String? qty,
    String? rate,
    String? unit,
    String? itemOrder,
  }) {
    _id = id;
    _relId = relId;
    _relType = relType;
    _description = description;
    _longDescription = longDescription;
    _qty = qty;
    _rate = rate;
    _unit = unit;
    _itemOrder = itemOrder;
  }

  Items.fromJson(dynamic json) {
    _id = json['id'];
    _relId = json['rel_id'];
    _relType = json['rel_type'];
    _description = json['description'];
    _longDescription = json['long_description'];
    _qty = json['qty'];
    _rate = json['rate'];
    _unit = json['unit'];
    _itemOrder = json['item_order'];
  }

  String? _id;
  String? _relId;
  String? _relType;
  String? _description;
  String? _longDescription;
  String? _qty;
  String? _rate;
  String? _unit;
  String? _itemOrder;

  String? get id => _id;
  String? get relId => _relId;
  String? get relType => _relType;
  String? get description => _description;
  String? get longDescription => _longDescription;
  String? get qty => _qty;
  String? get rate => _rate;
  String? get unit => _unit;
  String? get itemOrder => _itemOrder;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['rel_id'] = _relId;
    map['rel_type'] = _relType;
    map['description'] = _description;
    map['long_description'] = _longDescription;
    map['qty'] = _qty;
    map['rate'] = _rate;
    map['unit'] = _unit;
    map['item_order'] = _itemOrder;
    return map;
  }
}

class Payments {
  Payments({
    String? id,
    String? invoiceId,
    String? amount,
    String? paymentMode,
    String? paymentMethod,
    String? date,
    String? dateRecorded,
    String? note,
    String? transactionId,
    String? methodName,
    String? methodDescription,
    String? showOnPdf,
    String? invoicesOnly,
    String? expensesOnly,
    String? selectedByDefault,
    String? active,
    String? paymentId,
  }) {
    _id = id;
    _invoiceId = invoiceId;
    _amount = amount;
    _paymentMode = paymentMode;
    _paymentMethod = paymentMethod;
    _date = date;
    _dateRecorded = dateRecorded;
    _note = note;
    _transactionId = transactionId;
    _methodName = methodName;
    _methodDescription = methodDescription;
    _showOnPdf = showOnPdf;
    _invoicesOnly = invoicesOnly;
    _expensesOnly = expensesOnly;
    _selectedByDefault = selectedByDefault;
    _active = active;
    _paymentId = paymentId;
  }

  Payments.fromJson(dynamic json) {
    _id = json['id'];
    _invoiceId = json['invoiceid'];
    _amount = json['amount'];
    _paymentMode = json['paymentmode'];
    _paymentMethod = json['paymentmethod'];
    _date = json['date'];
    _dateRecorded = json['daterecorded'];
    _note = json['note'];
    _transactionId = json['transactionid'];
    _methodName = json['name'];
    _methodDescription = json['description'];
    _showOnPdf = json['show_on_pdf'];
    _invoicesOnly = json['invoices_only'];
    _expensesOnly = json['expenses_only'];
    _selectedByDefault = json['selected_by_default'];
    _active = json['active'];
    _paymentId = json['paymentid'];
  }

  String? _id;
  String? _invoiceId;
  String? _amount;
  String? _paymentMode;
  String? _paymentMethod;
  String? _date;
  String? _dateRecorded;
  String? _note;
  String? _transactionId;
  String? _methodName;
  String? _methodDescription;
  String? _showOnPdf;
  String? _invoicesOnly;
  String? _expensesOnly;
  String? _selectedByDefault;
  String? _active;
  String? _paymentId;

  String? get id => _id;
  String? get invoiceId => _invoiceId;
  String? get amount => _amount;
  String? get paymentMode => _paymentMode;
  String? get paymentMethod => _paymentMethod;
  String? get date => _date;
  String? get dateRecorded => _dateRecorded;
  String? get note => _note;
  String? get transactionId => _transactionId;
  String? get methodName => _methodName;
  String? get methodDescription => _methodDescription;
  String? get showOnPdf => _showOnPdf;
  String? get invoicesOnly => _invoicesOnly;
  String? get expensesOnly => _expensesOnly;
  String? get selectedByDefault => _selectedByDefault;
  String? get active => _active;
  String? get paymentId => _paymentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['invoiceid'] = _invoiceId;
    map['amount'] = _amount;
    map['paymentmode'] = _paymentMode;
    map['paymentmethod'] = _paymentMethod;
    map['date'] = _date;
    map['daterecorded'] = _dateRecorded;
    map['note'] = _note;
    map['transactionid'] = _transactionId;
    map['name'] = _methodName;
    map['description'] = _methodDescription;
    map['show_on_pdf'] = _showOnPdf;
    map['invoices_only'] = _invoicesOnly;
    map['expenses_only'] = _expensesOnly;
    map['selected_by_default'] = _selectedByDefault;
    map['active'] = _active;
    map['paymentid'] = _paymentId;
    return map;
  }
}

class Attachments {
  Attachments({
    String? id,
    String? relId,
    String? relType,
    String? fileName,
    String? fileType,
    String? visibleToCustomer,
    String? attachmentKey,
    String? external,
    String? externalLink,
    String? thumbnailLink,
    String? staffId,
    String? contactId,
    String? taskCommentId,
    String? dateAdded,
  }) {
    _id = id;
    _relId = relId;
    _relType = relType;
    _fileName = fileName;
    _fileType = fileType;
    _visibleToCustomer = visibleToCustomer;
    _attachmentKey = attachmentKey;
    _external = external;
    _externalLink = externalLink;
    _thumbnailLink = thumbnailLink;
    _staffId = staffId;
    _contactId = contactId;
    _taskCommentId = taskCommentId;
    _dateAdded = dateAdded;
  }

  Attachments.fromJson(dynamic json) {
    _id = json['id'];
    _relId = json['rel_id'];
    _relType = json['rel_type'];
    _fileName = json['file_name'];
    _fileType = json['filetype'];
    _visibleToCustomer = json['visible_to_customer'];
    _attachmentKey = json['attachment_key'];
    _external = json['external'];
    _externalLink = json['external_link'];
    _thumbnailLink = json['thumbnail_link'];
    _staffId = json['staffid'];
    _contactId = json['contact_id'];
    _taskCommentId = json['task_comment_id'];
    _dateAdded = json['dateadded'];
  }

  String? _id;
  String? _relId;
  String? _relType;
  String? _fileName;
  String? _fileType;
  String? _visibleToCustomer;
  String? _attachmentKey;
  String? _external;
  String? _externalLink;
  String? _thumbnailLink;
  String? _staffId;
  String? _contactId;
  String? _taskCommentId;
  String? _dateAdded;

  String? get id => _id;
  String? get relId => _relId;
  String? get relType => _relType;
  String? get fileName => _fileName;
  String? get fileType => _fileType;
  String? get visibleToCustomer => _visibleToCustomer;
  String? get attachmentKey => _attachmentKey;
  String? get external => _external;
  String? get externalLink => _externalLink;
  String? get thumbnailLink => _thumbnailLink;
  String? get staffId => _staffId;
  String? get contactId => _contactId;
  String? get taskCommentId => _taskCommentId;
  String? get dateAdded => _dateAdded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['rel_id'] = _relId;
    map['rel_type'] = _relType;
    map['file_name'] = _fileName;
    map['filetype'] = _fileType;
    map['visible_to_customer'] = _visibleToCustomer;
    map['attachment_key'] = _attachmentKey;
    map['external'] = _external;
    map['external_link'] = _externalLink;
    map['thumbnail_link'] = _thumbnailLink;
    map['staffid'] = _staffId;
    map['contact_id'] = _contactId;
    map['task_comment_id'] = _taskCommentId;
    map['dateadded'] = _dateAdded;
    return map;
  }
}
