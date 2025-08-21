import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/method.dart';
import 'package:legumlex_customer/core/utils/url_container.dart';
import 'package:legumlex_customer/features/cases/model/case_model.dart';
import 'package:legumlex_customer/features/cases/model/document_model.dart';
import 'package:legumlex_customer/features/cases/model/hearing_model.dart';
import 'dart:convert';

class CasesRepo {
  ApiClient apiClient;
  CasesRepo({required this.apiClient});

  Future<CasesResponse> getCases() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.casesUrl}';
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    
    if (responseModel.status) {
      final jsonData = json.decode(responseModel.responseJson);
      return CasesResponse.fromJson(jsonData);
    } else {
      return CasesResponse(
        status: false,
        message: responseModel.message,
      );
    }
  }

  Future<CasesResponse> getCaseById(int caseId) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.casesUrl}/id/$caseId';
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    
    if (responseModel.status) {
      final jsonData = json.decode(responseModel.responseJson);
      return CasesResponse.fromJson(jsonData);
    } else {
      return CasesResponse(
        status: false,
        message: responseModel.message,
      );
    }
  }

  Future<HearingsResponse> getCaseHearings(int caseId) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.casesUrl}/id/$caseId/group/hearings';
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    
    if (responseModel.status) {
      final jsonData = json.decode(responseModel.responseJson);
      return HearingsResponse.fromJson(jsonData);
    } else {
      return HearingsResponse(
        status: false,
        message: responseModel.message,
      );
    }
  }

  Future<DocumentsResponse> getCaseDocuments(int caseId) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.casesUrl}/id/$caseId/group/documents';
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    
    if (responseModel.status) {
      final jsonData = json.decode(responseModel.responseJson);
      return DocumentsResponse.fromJson(jsonData);
    } else {
      return DocumentsResponse(
        status: false,
        message: responseModel.message,
      );
    }
  }
}