import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/method.dart';
import 'package:legumlex_customer/core/utils/url_container.dart';

class ProposalRepo {
  ApiClient apiClient;
  ProposalRepo({required this.apiClient});

  Future<ResponseModel> getAllProposals() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.proposalsUrl}";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getProposalDetails(proposalId) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.proposalsUrl}/id/$proposalId";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> postProposalComment(proposalId, String comment) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.proposalsUrl}/id/$proposalId/group/proposals_comment";

    Map<String, String> params = {"content": comment};

    ResponseModel responseModel = await apiClient
        .request(url, Method.postMethod, params, passHeader: true);
    return responseModel;
  }
}
