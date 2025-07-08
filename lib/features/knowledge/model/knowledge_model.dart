class KnowledgeBasesModel {
  KnowledgeBasesModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  KnowledgeBasesModel.fromJson(dynamic json) {
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
    String? groupId,
    String? name,
    String? groupSlug,
    String? description,
    String? active,
    String? color,
    String? groupOrder,
    List<Articles>? articles,
  }) {
    _groupId = groupId;
    _name = name;
    _groupSlug = groupSlug;
    _description = description;
    _active = active;
    _color = color;
    _groupOrder = groupOrder;
    _articles = articles;
  }

  Data.fromJson(dynamic json) {
    _groupId = json['groupid'];
    _name = json['name'];
    _groupSlug = json['group_slug'];
    _description = json['description'];
    _active = json['active'];
    _color = json['color'];
    _groupOrder = json['group_order'];

    if (json['articles'] != null) {
      _articles = [];
      json['articles'].forEach((v) {
        _articles?.add(Articles.fromJson(v));
      });
    }
  }

  String? _groupId;
  String? _name;
  String? _groupSlug;
  String? _description;
  String? _active;
  String? _color;
  String? _groupOrder;
  List<Articles>? _articles;

  String? get groupId => _groupId;
  String? get name => _name;
  String? get groupSlug => _groupSlug;
  String? get description => _description;
  String? get active => _active;
  String? get color => _color;
  String? get groupOrder => _groupOrder;
  List<Articles>? get articles => _articles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['groupid'] = _groupId;
    map['name'] = _name;
    map['group_slug'] = _groupSlug;
    map['description'] = _description;
    map['active'] = _active;
    map['color'] = _color;
    map['group_order'] = _groupOrder;
    if (_articles != null) {
      map['articles'] = _articles?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Articles {
  Articles({
    String? slug,
    String? subject,
    String? description,
    String? activeArticle,
    String? articleGroup,
    String? articleId,
    String? staffArticle,
    String? dateCreated,
  }) {
    _slug = slug;
    _subject = subject;
    _description = description;
    _activeArticle = activeArticle;
    _articleGroup = articleGroup;
    _articleId = articleId;
    _staffArticle = staffArticle;
    _dateCreated = dateCreated;
  }

  Articles.fromJson(dynamic json) {
    _slug = json['slug'];
    _subject = json['subject'];
    _description = json['description'];
    _activeArticle = json['active_article'];
    _articleGroup = json['articlegroup'];
    _articleId = json['articleid'];
    _staffArticle = json['staff_article'];
    _dateCreated = json['datecreated'];
  }

  String? _slug;
  String? _subject;
  String? _description;
  String? _activeArticle;
  String? _articleGroup;
  String? _articleId;
  String? _staffArticle;
  String? _dateCreated;

  String? get slug => _slug;
  String? get subject => _subject;
  String? get description => _description;
  String? get activeArticle => _activeArticle;
  String? get articleGroup => _articleGroup;
  String? get articleId => _articleId;
  String? get staffArticle => _staffArticle;
  String? get dateCreated => _dateCreated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['slug'] = _slug;
    map['subject'] = _subject;
    map['description'] = _description;
    map['active_article'] = _activeArticle;
    map['articlegroup'] = _articleGroup;
    map['articleid'] = _articleId;
    map['staff_article'] = _staffArticle;
    map['datecreated'] = _dateCreated;
    return map;
  }
}
