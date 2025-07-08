import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/method.dart';
import 'package:legumlex_customer/core/utils/url_container.dart';
import 'package:legumlex_customer/features/estimate/model/estimate_accept_model.dart';

class EstimateRepo {
  ApiClient apiClient;
  EstimateRepo({required this.apiClient});

  Future<ResponseModel> getAllEstimates() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.estimatesUrl}";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getEstimateDetails(estimateId) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.estimatesUrl}/id/$estimateId";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> acceptEstimate(
      estimateId, EstimateAcceptModel estimateAcceptModel) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.dashboardUrl}/group/accept_estimate/id/$estimateId";

    Map<String, String> params = {
      "acceptance_firstname": estimateAcceptModel.firstName,
      "acceptance_lastname": estimateAcceptModel.lastName,
      "acceptance_email": estimateAcceptModel.email,
      "acceptance_ip": estimateAcceptModel.ipAddress,
      "signature": estimateAcceptModel.signature,
    };

    ResponseModel responseModel = await apiClient
        .request(url, Method.postMethod, params, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> rejectEstimate(estimateId) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.dashboardUrl}/group/reject_estimate/id/$estimateId";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}
