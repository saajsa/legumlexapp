import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/method.dart';
import 'package:legumlex_customer/core/utils/url_container.dart';
import 'package:legumlex_customer/features/contract/model/sign_contract_model.dart';

class ContractRepo {
  ApiClient apiClient;
  ContractRepo({required this.apiClient});

  Future<ResponseModel> getAllContracts() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.contractsUrl}";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getContractDetails(contractId) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.contractsUrl}/id/$contractId";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> postContractComment(contractId, String comment) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.contractsUrl}/id/$contractId/group/contract_comment";

    Map<String, String> params = {"content": comment};

    ResponseModel responseModel = await apiClient
        .request(url, Method.postMethod, params, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> signContract(
      contractId, SignContractModel signContractModel) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.dashboardUrl}/group/sign_contract/id/$contractId";

    Map<String, String> params = {
      "acceptance_firstname": signContractModel.firstName,
      "acceptance_lastname": signContractModel.lastName,
      "acceptance_email": signContractModel.email,
      "acceptance_ip": signContractModel.ipAddress,
      "signature": signContractModel.signature,
    };

    ResponseModel responseModel = await apiClient
        .request(url, Method.postMethod, params, passHeader: true);
    return responseModel;
  }
}
