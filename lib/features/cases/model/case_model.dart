class CaseModel {
  int? id;
  int? consultationId;
  String? caseTitle;
  String? caseNumber;
  String? dateFiled;
  String? dateCreated;
  int? clientId;
  int? courtRoomId;
  String? clientName;
  String? contactName;
  String? courtName;
  String? courtNo;
  String? judgeName;
  String? courtDisplay;
  String? nextHearingDate;
  int? documentCount;
  int? hearingCount;

  CaseModel({
    this.id,
    this.consultationId,
    this.caseTitle,
    this.caseNumber,
    this.dateFiled,
    this.dateCreated,
    this.clientId,
    this.courtRoomId,
    this.clientName,
    this.contactName,
    this.courtName,
    this.courtNo,
    this.judgeName,
    this.courtDisplay,
    this.nextHearingDate,
    this.documentCount,
    this.hearingCount,
  });

  CaseModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    consultationId = int.tryParse(json['consultation_id'].toString());
    caseTitle = json['case_title'];
    caseNumber = json['case_number'];
    dateFiled = json['date_filed'];
    dateCreated = json['date_created'];
    clientId = int.tryParse(json['client_id'].toString());
    courtRoomId = int.tryParse(json['court_room_id'].toString());
    clientName = json['client_name'];
    contactName = json['contact_name'];
    courtName = json['court_name'];
    courtNo = json['court_no'];
    judgeName = json['judge_name'];
    courtDisplay = json['court_display'];
    nextHearingDate = json['next_hearing_date'];
    documentCount = int.tryParse(json['document_count'].toString()) ?? 0;
    hearingCount = int.tryParse(json['hearing_count'].toString()) ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['consultation_id'] = consultationId;
    data['case_title'] = caseTitle;
    data['case_number'] = caseNumber;
    data['date_filed'] = dateFiled;
    data['date_created'] = dateCreated;
    data['client_id'] = clientId;
    data['court_room_id'] = courtRoomId;
    data['client_name'] = clientName;
    data['contact_name'] = contactName;
    data['court_name'] = courtName;
    data['court_no'] = courtNo;
    data['judge_name'] = judgeName;
    data['court_display'] = courtDisplay;
    data['next_hearing_date'] = nextHearingDate;
    data['document_count'] = documentCount;
    data['hearing_count'] = hearingCount;
    return data;
  }
}

class CasesResponse {
  bool? status;
  List<CaseModel>? data;
  String? message;

  CasesResponse({this.status, this.data, this.message});

  CasesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CaseModel>[];
      json['data'].forEach((v) {
        data!.add(CaseModel.fromJson(v));
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