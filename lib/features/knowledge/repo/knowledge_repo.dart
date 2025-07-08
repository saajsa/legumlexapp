import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/method.dart';
import 'package:legumlex_customer/core/utils/url_container.dart';

class KnowledgeRepo {
  ApiClient apiClient;
  KnowledgeRepo({required this.apiClient});

  Future<ResponseModel> getAllKnowledgeBase() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.knowledgeBaseUrl}";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getKnowledgeBaseBySlug(slug) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.knowledgeBaseUrl}/group/$slug";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getKnowledgeBaseDetails(slug) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.knowledgeBaseUrl}/$slug";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}
