import 'package:legumlex_customer/core/utils/urls.dart';
import 'package:legumlex_customer/features/cases/model/case_model.dart';
import 'package:legumlex_customer/features/cases/model/consultation_model.dart';
import 'package:legumlex_customer/features/cases/model/document_model.dart';
import 'package:legumlex_customer/features/cases/model/hearing_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CasesRepo {
  Future<CasesResponse> getCases() async {
    try {
      final response = await http.get(
        Uri.parse('${Urls.baseUrl}${Urls.casesUrl}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Urls.token}', // Assuming token is stored in Urls
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return CasesResponse.fromJson(jsonData);
      } else {
        return CasesResponse(
          status: false,
          message: 'Failed to load cases: ${response.statusCode}',
        );
      }
    } catch (e) {
      return CasesResponse(
        status: false,
        message: 'Error occurred while fetching cases: $e',
      );
    }
  }

  Future<CasesResponse> getCaseById(int caseId) async {
    try {
      final response = await http.get(
        Uri.parse('${Urls.baseUrl}${Urls.casesUrl}/id/$caseId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Urls.token}',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return CasesResponse.fromJson(jsonData);
      } else {
        return CasesResponse(
          status: false,
          message: 'Failed to load case: ${response.statusCode}',
        );
      }
    } catch (e) {
      return CasesResponse(
        status: false,
        message: 'Error occurred while fetching case: $e',
      );
    }
  }

  Future<HearingsResponse> getCaseHearings(int caseId) async {
    try {
      final response = await http.get(
        Uri.parse('${Urls.baseUrl}${Urls.casesUrl}/id/$caseId/group/hearings'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Urls.token}',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return HearingsResponse.fromJson(jsonData);
      } else {
        return HearingsResponse(
          status: false,
          message: 'Failed to load hearings: ${response.statusCode}',
        );
      }
    } catch (e) {
      return HearingsResponse(
        status: false,
        message: 'Error occurred while fetching hearings: $e',
      );
    }
  }

  Future<DocumentsResponse> getCaseDocuments(int caseId) async {
    try {
      final response = await http.get(
        Uri.parse('${Urls.baseUrl}${Urls.casesUrl}/id/$caseId/group/documents'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Urls.token}',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return DocumentsResponse.fromJson(jsonData);
      } else {
        return DocumentsResponse(
          status: false,
          message: 'Failed to load documents: ${response.statusCode}',
        );
      }
    } catch (e) {
      return DocumentsResponse(
        status: false,
        message: 'Error occurred while fetching documents: $e',
      );
    }
  }
}