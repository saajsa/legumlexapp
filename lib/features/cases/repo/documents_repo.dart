import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/method.dart';
import 'package:legumlex_customer/core/utils/url_container.dart';
import 'package:legumlex_customer/features/cases/model/document_model.dart';
import 'dart:convert';

class DocumentsRepo {
  ApiClient apiClient;
  DocumentsRepo({required this.apiClient});

  Future<DocumentsResponse> getDocuments() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.documentsUrl}';
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    
    if (responseModel.isSuccess) {
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