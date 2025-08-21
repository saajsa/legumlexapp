class ConsultationModel {
  int? id;
  int? clientId;
  int? contactId;
  String? tag;
  String? note;
  String? dateAdded;
  String? phase;
  String? clientName;
  String? contactName;
  int? documentCount;

  ConsultationModel({
    this.id,
    this.clientId,
    this.contactId,
    this.tag,
    this.note,
    this.dateAdded,
    this.phase,
    this.clientName,
    this.contactName,
    this.documentCount,
  });

  ConsultationModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    clientId = int.tryParse(json['client_id'].toString());
    contactId = int.tryParse(json['contact_id'].toString());
    tag = json['tag'];
    note = json['note'];
    dateAdded = json['date_added'];
    phase = json['phase'];
    clientName = json['client_name'];
    contactName = json['contact_name'];
    documentCount = int.tryParse(json['document_count'].toString()) ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_id'] = clientId;
    data['contact_id'] = contactId;
    data['tag'] = tag;
    data['note'] = note;
    data['date_added'] = dateAdded;
    data['phase'] = phase;
    data['client_name'] = clientName;
    data['contact_name'] = contactName;
    data['document_count'] = documentCount;
    return data;
  }
}

class ConsultationsResponse {
  bool? status;
  List<ConsultationModel>? data;
  String? message;

  ConsultationsResponse({this.status, this.data, this.message});

  ConsultationsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ConsultationModel>[];
      json['data'].forEach((v) {
        data!.add(ConsultationModel.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}