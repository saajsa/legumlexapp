class HearingModel {
  int? id;
  int? caseId;
  String? date;
  String? time;
  String? hearingPurpose;
  String? description;
  String? status;

  HearingModel({
    this.id,
    this.caseId,
    this.date,
    this.time,
    this.hearingPurpose,
    this.description,
    this.status,
  });

  HearingModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    caseId = int.tryParse(json['case_id'].toString());
    date = json['date'];
    time = json['time'];
    hearingPurpose = json['hearing_purpose'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['case_id'] = caseId;
    data['date'] = date;
    data['time'] = time;
    data['hearing_purpose'] = hearingPurpose;
    data['description'] = description;
    data['status'] = status;
    return data;
  }
}

class HearingsResponse {
  bool? status;
  List<HearingModel>? data;
  String? message;

  HearingsResponse({this.status, this.data, this.message});

  HearingsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <HearingModel>[];
      json['data'].forEach((v) {
        data!.add(HearingModel.fromJson(v));
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