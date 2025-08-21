import 'package:legumlex_customer/core/utils/urls.dart';
import 'package:legumlex_customer/features/cases/model/document_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DocumentsRepo {
  Future<DocumentsResponse> getDocuments() async {
    try {
      final response = await http.get(
        Uri.parse('${Urls.baseUrl}${Urls.documentsUrl}'),
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