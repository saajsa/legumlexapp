class TicketDetailsModel {
  TicketDetailsModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  TicketDetailsModel.fromJson(dynamic json) {
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
    String? userId,
    String? name,
    String? email,
    String? subject,
    String? message,
    String? ticketKey,
    String? projectId,
    String? projectName,
    String? lastReply,
    String? clientRead,
    String? adminRead,
    String? assigned,
    String? dateCreated,
    String? company,
    String? profileImage,
    String? department,
    String? departmentName,
    String? priority,
    String? priorityName,
    String? service,
    String? serviceName,
    String? status,
    String? statusName,
    String? statusColor,
    String? userFirstName,
    String? userLastName,
    String? staffFirstName,
    String? staffLastName,
    List<Attachments>? attachments,
    List<TicketReplies>? ticketReplies,
  }) {
    _id = id;
    _userId = userId;
    _name = name;
    _email = email;
    _subject = subject;
    _message = message;
    _ticketKey = ticketKey;
    _projectId = projectId;
    _projectName = projectName;
    _lastReply = lastReply;
    _clientRead = clientRead;
    _adminRead = adminRead;
    _assigned = assigned;
    _dateCreated = dateCreated;
    _company = company;
    _profileImage = profileImage;
    _department = department;
    _departmentName = departmentName;
    _priority = priority;
    _priorityName = priorityName;
    _service = service;
    _serviceName = serviceName;
    _status = status;
    _statusName = statusName;
    _statusColor = statusColor;
    _userFirstName = userFirstName;
    _userLastName = userLastName;
    _staffFirstName = staffFirstName;
    _staffLastName = staffLastName;
    _attachments = attachments;
    _ticketReplies = ticketReplies;
  }

  Data.fromJson(dynamic json) {
    _id = json['ticketid'];
    _userId = json['userid'];
    _name = json['name'];
    _email = json['email'];
    _subject = json['subject'];
    _message = json['message'];
    _ticketKey = json['ticketkey'];
    _projectId = json['priorityid'];
    _projectName = json['project_name'];
    _lastReply = json['lastreply'];
    _clientRead = json['clientread'];
    _adminRead = json['adminread'];
    _assigned = json['assigned'];
    _dateCreated = json['datecreated'];
    _company = json['company'];
    _profileImage = json['profile_image'];
    _department = json['department'];
    _departmentName = json['department_name'];
    _priority = json['priority'];
    _priorityName = json['priority_name'];
    _service = json['service'];
    _serviceName = json['service_name'];
    _status = json['status'];
    _statusName = json['status_name'];
    _statusColor = json['statuscolor'];
    _userFirstName = json['user_firstname'];
    _userLastName = json['user_lastname'];
    _staffFirstName = json['staff_firstname'];
    _staffLastName = json['staff_lastname'];

    if (json['attachments'] != null) {
      _attachments = [];
      json['attachments'].forEach((v) {
        _attachments?.add(Attachments.fromJson(v));
      });
    }
    if (json['ticket_replies'] != null) {
      _ticketReplies = [];
      json['ticket_replies'].forEach((v) {
        _ticketReplies?.add(TicketReplies.fromJson(v));
      });
    }
  }

  String? _id;
  String? _userId;
  String? _name;
  String? _email;
  String? _subject;
  String? _message;
  String? _ticketKey;
  String? _projectId;
  String? _projectName;
  String? _lastReply;
  String? _clientRead;
  String? _adminRead;
  String? _assigned;
  String? _dateCreated;
  String? _company;
  String? _profileImage;
  String? _department;
  String? _departmentName;
  String? _priority;
  String? _priorityName;
  String? _service;
  String? _serviceName;
  String? _status;
  String? _statusName;
  String? _statusColor;
  String? _userFirstName;
  String? _userLastName;
  String? _staffFirstName;
  String? _staffLastName;
  List<Attachments>? _attachments;
  List<TicketReplies>? _ticketReplies;

  String? get id => _id;
  String? get userId => _userId;
  String? get name => _name;
  String? get email => _email;
  String? get subject => _subject;
  String? get message => _message;
  String? get ticketKey => _ticketKey;
  String? get projectId => _projectId;
  String? get projectName => _projectName;
  String? get lastReply => _lastReply;
  String? get clientRead => _clientRead;
  String? get adminRead => _adminRead;
  String? get assigned => _assigned;
  String? get dateCreated => _dateCreated;
  String? get company => _company;
  String? get profileImage => _profileImage;
  String? get department => _department;
  String? get departmentName => _departmentName;
  String? get priority => _priority;
  String? get priorityName => _priorityName;
  String? get service => _service;
  String? get serviceName => _serviceName;
  String? get status => _status;
  String? get statusName => _statusName;
  String? get statusColor => _statusColor;
  String? get userFirstName => _userFirstName;
  String? get userLastName => _userLastName;
  String? get staffFirstName => _staffFirstName;
  String? get staffLastName => _staffLastName;
  List<Attachments>? get attachments => _attachments;
  List<TicketReplies>? get ticketReplies => _ticketReplies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ticketid'] = _id;
    map['userid'] = _userId;
    map['name'] = _name;
    map['email'] = _email;
    map['subject'] = _subject;
    map['message'] = _message;
    map['ticketkey'] = _ticketKey;
    map['priorityid'] = _projectId;
    map['project_name'] = _projectName;
    map['lastreply'] = _lastReply;
    map['clientread'] = _clientRead;
    map['adminread'] = _adminRead;
    map['assigned'] = _assigned;
    map['datecreated'] = _dateCreated;
    map['company'] = _company;
    map['profile_image'] = _profileImage;
    map['department'] = _department;
    map['department_name'] = _departmentName;
    map['priority'] = _priority;
    map['priority_name'] = _priorityName;
    map['service'] = _service;
    map['service_name'] = _serviceName;
    map['status'] = _status;
    map['status_name'] = _statusName;
    map['statuscolor'] = _statusColor;
    map['user_firstname'] = _userFirstName;
    map['user_lastname'] = _userLastName;
    map['staff_firstname'] = _staffFirstName;
    map['staff_lastname'] = _staffLastName;
    if (_attachments != null) {
      map['attachments'] = _attachments?.map((v) => v.toJson()).toList();
    }
    if (_ticketReplies != null) {
      map['ticket_replies'] = _ticketReplies?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TicketReplies {
  TicketReplies({
    String? id,
    String? fromName,
    String? replyEmail,
    String? admin,
    String? userId,
    String? message,
    String? contactId,
    String? submitter,
    String? date,
    List<Attachments>? attachments,
  }) {
    _id = id;
    _fromName = fromName;
    _replyEmail = replyEmail;
    _admin = admin;
    _userId = userId;
    _message = message;
    _contactId = contactId;
    _submitter = submitter;
    _date = date;
    _attachments = attachments;
  }

  TicketReplies.fromJson(dynamic json) {
    _id = json['id'];
    _fromName = json['from_name'];
    _replyEmail = json['reply_email'];
    _admin = json['admin'];
    _userId = json['userid'];
    _message = json['message'];
    _contactId = json['contactid'];
    _submitter = json['submitter'];
    _date = json['date'];
    if (json['attachments'] != null) {
      _attachments = [];
      json['attachments'].forEach((v) {
        _attachments?.add(Attachments.fromJson(v));
      });
    }
  }

  String? _id;
  String? _fromName;
  String? _replyEmail;
  String? _admin;
  String? _userId;
  String? _message;
  String? _contactId;
  String? _submitter;
  String? _date;
  List<Attachments>? _attachments;

  String? get id => _id;
  String? get fromName => _fromName;
  String? get replyEmail => _replyEmail;
  String? get admin => _admin;
  String? get userId => _userId;
  String? get message => _message;
  String? get contactId => _contactId;
  String? get submitter => _submitter;
  String? get date => _date;
  List<Attachments>? get attachments => _attachments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['from_name'] = _fromName;
    map['reply_email'] = _replyEmail;
    map['admin'] = _admin;
    map['userid'] = _userId;
    map['message'] = _message;
    map['contactid'] = _contactId;
    map['submitter'] = _submitter;
    map['date'] = _date;
    if (_attachments != null) {
      map['attachments'] = _attachments?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Attachments {
  Attachments({
    String? id,
    String? ticketId,
    String? replyId,
    String? fileName,
    String? fileType,
    String? dateAdded,
  }) {
    _id = id;
    _ticketId = ticketId;
    _replyId = replyId;
    _fileName = fileName;
    _fileType = fileType;
    _dateAdded = dateAdded;
  }

  Attachments.fromJson(dynamic json) {
    _id = json['id'];
    _ticketId = json['ticketid'];
    _replyId = json['replyid'];
    _fileName = json['file_name'];
    _fileType = json['filetype'];
    _dateAdded = json['dateadded'];
  }

  String? _id;
  String? _ticketId;
  String? _replyId;
  String? _fileName;
  String? _fileType;
  String? _dateAdded;

  String? get id => _id;
  String? get ticketId => _ticketId;
  String? get replyId => _replyId;
  String? get fileName => _fileName;
  String? get fileType => _fileType;
  String? get dateAdded => _dateAdded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ticketid'] = _ticketId;
    map['replyid'] = _replyId;
    map['file_name'] = _fileName;
    map['filetype'] = _fileType;
    map['dateadded'] = _dateAdded;
    return map;
  }
}
