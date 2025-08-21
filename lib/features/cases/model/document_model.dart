class DocumentModel {
  int? id;
  String? fileName;
  String? fileType;
  String? dateAdded;
  int? relId;
  String? relType;
  String? caseTitle;
  String? documentContext;

  DocumentModel({
    this.id,
    this.fileName,
    this.fileType,
    this.dateAdded,
    this.relId,
    this.relType,
    this.caseTitle,
    this.documentContext,
  });

  DocumentModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    fileName = json['file_name'];
    fileType = json['filetype'];
    dateAdded = json['dateadded'];
    relId = int.tryParse(json['rel_id'].toString());
    relType = json['rel_type'];
    caseTitle = json['case_title'];
    documentContext = json['document_context'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['file_name'] = fileName;
    data['filetype'] = fileType;
    data['dateadded'] = dateAdded;
    data['rel_id'] = relId;
    data['rel_type'] = relType;
    data['case_title'] = caseTitle;
    data['document_context'] = documentContext;
    return data;
  }
}

class DocumentsResponse {
  bool? status;
  List<DocumentModel>? data;
  String? message;

  DocumentsResponse({this.status, this.data, this.message});

  DocumentsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DocumentModel>[];
      json['data'].forEach((v) {
        data!.add(DocumentModel.fromJson(v));
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