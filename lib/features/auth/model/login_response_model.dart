class LoginModel {
  LoginModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  LoginModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'].toString();
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
    String? contactId,
    bool? clientLoggedIn,
    String? apiTime,
    String? accessToken,
  }) {
    _clientId = clientId;
    _contactId = contactId;
    _clientLoggedIn = clientLoggedIn;
    _apiTime = apiTime;
    _accessToken = accessToken;
  }

  Data.fromJson(dynamic json) {
    _clientId = json['client_id'];
    _contactId = json['contact_id'];
    _clientLoggedIn = json['client_logged_in'];
    _apiTime = json['API_TIME'].toString();
    _accessToken = json['token'];
  }
  String? _clientId;
  String? _contactId;
  bool? _clientLoggedIn;
  String? _apiTime;
  String? _accessToken;

  String? get clientId => _clientId;
  String? get contactId => _contactId;
  bool? get clientLoggedIn => _clientLoggedIn;
  String? get apiTime => _apiTime;
  String? get accessToken => _accessToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['client_id'] = _clientId;
    map['contact_id'] = _contactId;
    map['client_logged_in'] = _clientLoggedIn;
    map['API_TIME'] = _apiTime;
    map['token'] = _accessToken;
    return map;
  }
}
