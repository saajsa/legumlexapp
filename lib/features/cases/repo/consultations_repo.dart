import 'package:legumlexapp/core/utils/urls.dart';
import 'package:legumlexapp/features/cases/model/consultation_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConsultationsRepo {
  Future<ConsultationsResponse> getConsultations() async {
    try {
      final response = await http.get(
        Uri.parse('${Urls.baseUrl}${Urls.consultationsUrl}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Urls.token}',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ConsultationsResponse.fromJson(jsonData);
      } else {
        return ConsultationsResponse(
          status: false,
          message: 'Failed to load consultations: ${response.statusCode}',
        );
      }
    } catch (e) {
      return ConsultationsResponse(
        status: false,
        message: 'Error occurred while fetching consultations: $e',
      );
    }
  }

  Future<ConsultationsResponse> getConsultationById(int consultationId) async {
    try {
      final response = await http.get(
        Uri.parse('${Urls.baseUrl}${Urls.consultationsUrl}/id/$consultationId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Urls.token}',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ConsultationsResponse.fromJson(jsonData);
      } else {
        return ConsultationsResponse(
          status: false,
          message: 'Failed to load consultation: ${response.statusCode}',
        );
      }
    } catch (e) {
      return ConsultationsResponse(
        status: false,
        message: 'Error occurred while fetching consultation: $e',
      );
    }
  }
}