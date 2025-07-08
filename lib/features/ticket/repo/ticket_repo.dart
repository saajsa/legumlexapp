import 'dart:convert';
import 'package:legumlex_customer/common/components/snack_bar/show_custom_snackbar.dart';
import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/method.dart';
import 'package:legumlex_customer/core/utils/url_container.dart';
import 'package:legumlex_customer/features/ticket/model/ticket_create_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TicketRepo {
  ApiClient apiClient;
  TicketRepo({required this.apiClient});

  Future<ResponseModel> getAllTickets() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.ticketsUrl}";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getTicketPriorities() async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.miscellaneousDataUrl}/get_ticket_priorities";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getTicketDepartments() async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.miscellaneousDataUrl}/departments";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<bool> createTicket(TicketCreateModel ticketModel) async {
    apiClient.initToken();

    String url = "${UrlContainer.baseUrl}${UrlContainer.ticketsUrl}";

    var request = http.MultipartRequest('POST', Uri.parse(url));
    Map<String, String> params = {
      "subject": ticketModel.subject,
      "department": ticketModel.department,
      "priority": ticketModel.priority,
      "message": ticketModel.description,
    };

    request.headers.addAll(<String, String>{'Authorization': apiClient.token});
    if (ticketModel.image != null) {
      request.files.add(http.MultipartFile(
          'Attachment',
          ticketModel.image!.readAsBytes().asStream(),
          ticketModel.image!.lengthSync(),
          filename: ticketModel.image!.path.split('/').last));
    }
    request.fields.addAll(params);

    http.StreamedResponse response = await request.send();

    String jsonResponse = await response.stream.bytesToString();
    ResponseModel responseModel = jsonDecode(jsonResponse);

    if (kDebugMode) {
      print(response.statusCode);
      print(params);
      print(jsonResponse);
      print(url.toString());
    }

    if (responseModel.status) {
      CustomSnackBar.success(successList: [responseModel.message.tr]);
      return true;
    } else {
      CustomSnackBar.error(errorList: [responseModel.message.tr]);
      return false;
    }
  }

  Future<ResponseModel> getTicketDetails(ticketId) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.ticketsUrl}/id/$ticketId";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> postTicketReply(ticketId, String message) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.ticketsUrl}/add_reply/$ticketId";

    Map<String, String> params = {"message": message};

    ResponseModel responseModel = await apiClient
        .request(url, Method.postMethod, params, passHeader: true);
    return responseModel;
  }
}
