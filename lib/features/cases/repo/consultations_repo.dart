import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/method.dart';
import 'package:legumlex_customer/core/utils/url_container.dart';
import 'package:legumlex_customer/features/cases/model/consultation_model.dart';
import 'dart:convert';

class ConsultationsRepo {
  ApiClient apiClient;
  ConsultationsRepo({required this.apiClient});

  Future<ConsultationsResponse> getConsultations() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.consultationsUrl}';
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    
    if (responseModel.isSuccess) {
      final jsonData = json.decode(responseModel.responseJson);
      return ConsultationsResponse.fromJson(jsonData);
    } else {
      return ConsultationsResponse(
        status: false,
        message: responseModel.message,
      );
    }
  }

  Future<ConsultationsResponse> getConsultationById(int consultationId) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.consultationsUrl}/id/$consultationId';
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    
    if (responseModel.isSuccess) {
      final jsonData = json.decode(responseModel.responseJson);
      return ConsultationsResponse.fromJson(jsonData);
    } else {
      return ConsultationsResponse(
        status: false,
        message: responseModel.message,
      );
    }
  }
}