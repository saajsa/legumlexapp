class InvoicesModel {
  InvoicesModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  InvoicesModel.fromJson(dynamic json) {
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
    String? number,
    String? prefix,
    String? numberFormat,
    String? date,
    String? duedate,
    String? subtotal,
    String? totalTax,
    String? total,
    String? addedFrom,
    String? status,
    String? clientNote,
    String? adminNote,
    String? discountPercent,
    String? discountTotal,
    String? discountType,
    String? recurring,
    String? projectId,
    String? currency,
    String? currencySymbol,
    String? currencyName,
    String? currencyplacement,
    String? decimalSeparator,
    String? thousandSeparator,
    String? clientName,
    String? projectName,
    String? addedFromName,
    String? statusName,
  }) {
    _id = id;
    _number = number;
    _prefix = prefix;
    _numberFormat = numberFormat;
    _date = date;
    _duedate = duedate;
    _subtotal = subtotal;
    _totalTax = totalTax;
    _total = total;
    _addedFrom = addedFrom;
    _status = status;
    _clientNote = clientNote;
    _adminNote = adminNote;
    _discountPercent = discountPercent;
    _discountTotal = discountTotal;
    _discountType = discountType;
    _recurring = recurring;
    _projectId = projectId;
    _currency = currency;
    _currencySymbol = currencySymbol;
    _currencyName = currencyName;
    _currencyplacement = currencyplacement;
    _decimalSeparator = decimalSeparator;
    _thousandSeparator = thousandSeparator;
    _clientName = clientName;
    _projectName = projectName;
    _addedFromName = addedFromName;
    _statusName = statusName;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _number = json['number'];
    _prefix = json['prefix'];
    _numberFormat = json['number_format'];
    _date = json['date'];
    _duedate = json['duedate'];
    _subtotal = json['subtotal'];
    _totalTax = json['total_tax'];
    _total = json['total'];
    _addedFrom = json['addedfrom'];
    _status = json['status'];
    _clientNote = json['clientnote'];
    _adminNote = json['adminnote'];
    _discountPercent = json['discount_percent'];
    _discountTotal = json['discount_total'];
    _discountType = json['discount_type'];
    _recurring = json['recurring'];
    _projectId = json['project_id'];
    _currency = json['currency'];
    _currencySymbol = json['symbol'];
    _currencyName = json['name'];
    _currencyplacement = json['placement'];
    _decimalSeparator = json['decimal_separator'];
    _thousandSeparator = json['thousand_separator'];
    _clientName = json['client_name'];
    _projectName = json['project_name'];
    _addedFromName = json['addedfrom_name'];
    _statusName = json['status_name'];
  }

  String? _id;
  String? _number;
  String? _prefix;
  String? _numberFormat;
  String? _date;
  String? _duedate;
  String? _subtotal;
  String? _totalTax;
  String? _total;
  String? _addedFrom;
  String? _status;
  String? _clientNote;
  String? _adminNote;
  String? _discountPercent;
  String? _discountTotal;
  String? _discountType;
  String? _recurring;
  String? _projectId;
  String? _currency;
  String? _currencySymbol;
  String? _currencyName;
  String? _currencyplacement;
  String? _decimalSeparator;
  String? _thousandSeparator;
  String? _clientName;
  String? _projectName;
  String? _addedFromName;
  String? _statusName;

  String? get id => _id;
  String? get number => _number;
  String? get prefix => _prefix;
  String? get numberFormat => _numberFormat;
  String? get date => _date;
  String? get duedate => _duedate;
  String? get subtotal => _subtotal;
  String? get totalTax => _totalTax;
  String? get total => _total;
  String? get addedFrom => _addedFrom;
  String? get status => _status;
  String? get clientNote => _clientNote;
  String? get adminNote => _adminNote;
  String? get discountPercent => _discountPercent;
  String? get discountTotal => _discountTotal;
  String? get discountType => _discountType;
  String? get recurring => _recurring;
  String? get projectId => _projectId;
  String? get currency => _currency;
  String? get currencySymbol => _currencySymbol;
  String? get currencyName => _currencyName;
  String? get currencyplacement => _currencyplacement;
  String? get decimalSeparator => _decimalSeparator;
  String? get thousandSeparator => _thousandSeparator;
  String? get clientName => _clientName;
  String? get projectName => _projectName;
  String? get addedFromName => _addedFromName;
  String? get statusName => _statusName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['number'] = _number;
    map['prefix'] = _prefix;
    map['number_format'] = _numberFormat;
    map['date'] = _date;
    map['duedate'] = _duedate;
    map['subtotal'] = _subtotal;
    map['total_tax'] = _totalTax;
    map['total'] = _total;
    map['addedfrom'] = _addedFrom;
    map['status'] = _status;
    map['clientnote'] = _clientNote;
    map['adminnote'] = _adminNote;
    map['discount_percent'] = _discountPercent;
    map['discount_total'] = _discountTotal;
    map['discount_type'] = _discountType;
    map['recurring'] = _recurring;
    map['project_id'] = _projectId;
    map['currency'] = _currency;
    map['symbol'] = _currencySymbol;
    map['name'] = _currencyName;
    map['placement'] = _currencyplacement;
    map['decimal_separator'] = _decimalSeparator;
    map['thousand_separator'] = _thousandSeparator;
    map['client_name'] = _clientName;
    map['project_name'] = _projectName;
    map['addedfrom_name'] = _addedFromName;
    map['status_name'] = _statusName;
    return map;
  }
}
