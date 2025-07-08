class ProposalsModel {
  ProposalsModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ProposalsModel.fromJson(dynamic json) {
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
    String? subject,
    String? content,
    String? addedFrom,
    String? dateCreated,
    String? total,
    String? subtotal,
    String? totalTax,
    String? adjustment,
    String? discountPercent,
    String? discountTotal,
    String? discountType,
    String? showQuantityAs,
    String? currency,
    String? openTill,
    String? date,
    String? relId,
    String? relType,
    String? assigned,
    String? hash,
    String? proposalTo,
    String? projectId,
    String? country,
    String? zip,
    String? state,
    String? city,
    String? address,
    String? email,
    String? phone,
    String? allowComments,
    String? status,
    String? estimateId,
    String? invoiceId,
    String? dateConverted,
    String? pipelineOrder,
    String? isExpiryNotified,
    String? acceptanceFirstname,
    String? acceptanceLastname,
    String? acceptanceEmail,
    String? acceptanceDate,
    String? acceptanceIp,
    String? signature,
    String? shortLink,
    String? symbol,
    String? name,
    String? decimalSeparator,
    String? thousandSeparator,
    String? placement,
    String? isDefault,
    String? currencyId,
    String? currencyName,
    String? clientName,
    String? projectName,
    String? addedFromName,
    String? statusName,
  }) {
    _id = id;
    _subject = subject;
    _content = content;
    _addedFrom = addedFrom;
    _dateCreated = dateCreated;
    _total = total;
    _subtotal = subtotal;
    _totalTax = totalTax;
    _adjustment = adjustment;
    _discountPercent = discountPercent;
    _discountTotal = discountTotal;
    _discountType = discountType;
    _showQuantityAs = showQuantityAs;
    _currency = currency;
    _openTill = openTill;
    _date = date;
    _relId = relId;
    _relType = relType;
    _assigned = assigned;
    _hash = hash;
    _proposalTo = proposalTo;
    _projectId = projectId;
    _country = country;
    _zip = zip;
    _state = state;
    _city = city;
    _address = address;
    _email = email;
    _phone = phone;
    _allowComments = allowComments;
    _status = status;
    _estimateId = estimateId;
    _invoiceId = invoiceId;
    _dateConverted = dateConverted;
    _pipelineOrder = pipelineOrder;
    _isExpiryNotified = isExpiryNotified;
    _acceptanceFirstname = acceptanceFirstname;
    _acceptanceLastname = acceptanceLastname;
    _acceptanceEmail = acceptanceEmail;
    _acceptanceDate = acceptanceDate;
    _acceptanceIp = acceptanceIp;
    _signature = signature;
    _shortLink = shortLink;
    _symbol = symbol;
    _name = name;
    _decimalSeparator = decimalSeparator;
    _thousandSeparator = thousandSeparator;
    _placement = placement;
    _isDefault = isDefault;
    _currencyId = currencyId;
    _currencyName = currencyName;
    _clientName = clientName;
    _projectName = projectName;
    _addedFromName = addedFromName;
    _statusName = statusName;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _subject = json['subject'];
    _content = json['content'];
    _addedFrom = json['addedfrom'];
    _dateCreated = json['datecreated'];
    _total = json['total'];
    _subtotal = json['subtotal'];
    _totalTax = json['total_tax'];
    _adjustment = json['adjustment'];
    _discountPercent = json['discount_percent'];
    _discountTotal = json['discount_total'];
    _discountType = json['discount_type'];
    _showQuantityAs = json['show_quantity_as'];
    _currency = json['currency'];
    _openTill = json['open_till'];
    _date = json['date'];
    _relId = json['rel_id'];
    _relType = json['rel_type'];
    _assigned = json['assigned'];
    _hash = json['hash'];
    _proposalTo = json['proposal_to'];
    _projectId = json['project_id'];
    _country = json['country'];
    _zip = json['zip'];
    _state = json['state'];
    _city = json['city'];
    _address = json['address'];
    _email = json['email'];
    _phone = json['phone'];
    _allowComments = json['allow_comments'];
    _status = json['status'];
    _estimateId = json['estimate_id'];
    _invoiceId = json['invoice_id'];
    _dateConverted = json['date_converted'];
    _pipelineOrder = json['pipeline_order'];
    _isExpiryNotified = json['is_expiry_notified'];
    _acceptanceFirstname = json['acceptance_firstname'];
    _acceptanceLastname = json['acceptance_lastname'];
    _acceptanceEmail = json['acceptance_email'];
    _acceptanceDate = json['acceptance_date'];
    _acceptanceIp = json['acceptance_ip'];
    _signature = json['signature'];
    _shortLink = json['short_link'];
    _symbol = json['symbol'];
    _name = json['name'];
    _decimalSeparator = json['decimal_separator'];
    _thousandSeparator = json['thousand_separator'];
    _placement = json['placement'];
    _isDefault = json['isdefault'];
    _currencyId = json['currencyid'];
    _currencyName = json['currency_name'];
    _clientName = json['client_name'];
    _projectName = json['project_name'];
    _addedFromName = json['addedfrom_name'];
    _statusName = json['status_name'];
  }

  String? _id;
  String? _subject;
  String? _content;
  String? _addedFrom;
  String? _dateCreated;
  String? _total;
  String? _subtotal;
  String? _totalTax;
  String? _adjustment;
  String? _discountPercent;
  String? _discountTotal;
  String? _discountType;
  String? _showQuantityAs;
  String? _currency;
  String? _openTill;
  String? _date;
  String? _relId;
  String? _relType;
  String? _assigned;
  String? _hash;
  String? _proposalTo;
  String? _projectId;
  String? _country;
  String? _zip;
  String? _state;
  String? _city;
  String? _address;
  String? _email;
  String? _phone;
  String? _allowComments;
  String? _status;
  String? _estimateId;
  String? _invoiceId;
  String? _dateConverted;
  String? _pipelineOrder;
  String? _isExpiryNotified;
  String? _acceptanceFirstname;
  String? _acceptanceLastname;
  String? _acceptanceEmail;
  String? _acceptanceDate;
  String? _acceptanceIp;
  String? _signature;
  String? _shortLink;
  String? _symbol;
  String? _name;
  String? _decimalSeparator;
  String? _thousandSeparator;
  String? _placement;
  String? _isDefault;
  String? _currencyId;
  String? _currencyName;
  String? _clientName;
  String? _projectName;
  String? _addedFromName;
  String? _statusName;

  String? get id => _id;
  String? get subject => _subject;
  String? get content => _content;
  String? get addedFrom => _addedFrom;
  String? get dateCreated => _dateCreated;
  String? get total => _total;
  String? get subtotal => _subtotal;
  String? get totalTax => _totalTax;
  String? get adjustment => _adjustment;
  String? get discountPercent => _discountPercent;
  String? get discountTotal => _discountTotal;
  String? get discountType => _discountType;
  String? get showQuantityAs => _showQuantityAs;
  String? get currency => _currency;
  String? get openTill => _openTill;
  String? get date => _date;
  String? get relId => _relId;
  String? get relType => _relType;
  String? get assigned => _assigned;
  String? get hash => _hash;
  String? get proposalTo => _proposalTo;
  String? get projectId => _projectId;
  String? get country => _country;
  String? get zip => _zip;
  String? get state => _state;
  String? get city => _city;
  String? get address => _address;
  String? get email => _email;
  String? get phone => _phone;
  String? get allowComments => _allowComments;
  String? get status => _status;
  String? get estimateId => _estimateId;
  String? get invoiceId => _invoiceId;
  String? get dateConverted => _dateConverted;
  String? get pipelineOrder => _pipelineOrder;
  String? get isExpiryNotified => _isExpiryNotified;
  String? get acceptanceFirstname => _acceptanceFirstname;
  String? get acceptanceLastname => _acceptanceLastname;
  String? get acceptanceEmail => _acceptanceEmail;
  String? get acceptanceDate => _acceptanceDate;
  String? get acceptanceIp => _acceptanceIp;
  String? get signature => _signature;
  String? get shortLink => _shortLink;
  String? get symbol => _symbol;
  String? get name => _name;
  String? get decimalSeparator => _decimalSeparator;
  String? get thousandSeparator => _thousandSeparator;
  String? get placement => _placement;
  String? get isDefault => _isDefault;
  String? get currencyId => _currencyId;
  String? get currencyName => _currencyName;
  String? get clientName => _clientName;
  String? get projectName => _projectName;
  String? get addedFromName => _addedFromName;
  String? get statusName => _statusName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['subject'] = _subject;
    map['content'] = _content;
    map['addedfrom'] = _addedFrom;
    map['datecreated'] = _dateCreated;
    map['total'] = _total;
    map['subtotal'] = _subtotal;
    map['total_tax'] = _totalTax;
    map['adjustment'] = _adjustment;
    map['discount_percent'] = _discountPercent;
    map['discount_total'] = _discountTotal;
    map['discount_type'] = _discountType;
    map['show_quantity_as'] = _showQuantityAs;
    map['currency'] = _currency;
    map['open_till'] = _openTill;
    map['date'] = _date;
    map['rel_id'] = _relId;
    map['rel_type'] = _relType;
    map['assigned'] = _assigned;
    map['hash'] = _hash;
    map['proposal_to'] = _proposalTo;
    map['project_id'] = _projectId;
    map['country'] = _country;
    map['zip'] = _zip;
    map['state'] = _state;
    map['city'] = _city;
    map['address'] = _address;
    map['email'] = _email;
    map['phone'] = _phone;
    map['allow_comments'] = _allowComments;
    map['status'] = _status;
    map['estimate_id'] = _estimateId;
    map['invoice_id'] = _invoiceId;
    map['date_converted'] = _dateConverted;
    map['pipeline_order'] = _pipelineOrder;
    map['is_expiry_notified'] = _isExpiryNotified;
    map['acceptance_firstname'] = _acceptanceFirstname;
    map['acceptance_lastname'] = _acceptanceLastname;
    map['acceptance_email'] = _acceptanceEmail;
    map['acceptance_date'] = _acceptanceDate;
    map['acceptance_ip'] = _acceptanceIp;
    map['signature'] = _signature;
    map['short_link'] = _shortLink;
    map['symbol'] = _symbol;
    map['name'] = _name;
    map['decimal_separator'] = _decimalSeparator;
    map['thousand_separator'] = _thousandSeparator;
    map['placement'] = _placement;
    map['isdefault'] = _isDefault;
    map['currencyid'] = _currencyId;
    map['currency_name'] = _currencyName;
    map['client_name'] = _clientName;
    map['project_name'] = _projectName;
    map['addedfrom_name'] = _addedFromName;
    map['status_name'] = _statusName;
    return map;
  }
}
