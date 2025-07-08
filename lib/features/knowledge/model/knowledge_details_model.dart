class KnowledgeBaseDetailsModel {
  KnowledgeBaseDetailsModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  KnowledgeBaseDetailsModel.fromJson(dynamic json) {
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
    String? slug,
    String? articleId,
    String? articleGroup,
    String? subject,
    String? description,
    String? activeArticle,
    String? activeGroup,
    String? groupName,
    String? staffArticle,
  }) {
    _slug = slug;
    _subject = subject;
    _description = description;
    _activeArticle = activeArticle;
    _articleGroup = articleGroup;
    _articleId = articleId;
    _activeGroup = activeGroup;
    _staffArticle = staffArticle;
    _groupName = groupName;
  }

  Data.fromJson(dynamic json) {
    _slug = json['slug'];
    _subject = json['subject'];
    _description = json['description'];
    _activeArticle = json['active_article'];
    _articleGroup = json['articlegroup'];
    _articleId = json['articleid'];
    _staffArticle = json['staff_article'];
    _activeGroup = json['active_group'];
    _groupName = json['group_name'];
  }

  String? _slug;
  String? _articleId;
  String? _articleGroup;
  String? _subject;
  String? _description;
  String? _activeArticle;
  String? _activeGroup;
  String? _groupName;
  String? _staffArticle;

  String? get slug => _slug;
  String? get subject => _subject;
  String? get description => _description;
  String? get activeArticle => _activeArticle;
  String? get articleGroup => _articleGroup;
  String? get articleId => _articleId;
  String? get activeGroup => _activeGroup;
  String? get staffArticle => _staffArticle;
  String? get groupName => _groupName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['slug'] = _slug;
    map['subject'] = _subject;
    map['description'] = _description;
    map['active_article'] = _activeArticle;
    map['articlegroup'] = _articleGroup;
    map['articleid'] = _articleId;
    map['staff_article'] = _staffArticle;
    map['active_group'] = _activeGroup;
    map['group_name'] = _groupName;
    return map;
  }
}
