import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/method.dart';
import 'package:legumlex_customer/core/utils/url_container.dart';

class MainNavigationRepo {
  ApiClient apiClient;

  MainNavigationRepo({required this.apiClient});

  Future<ResponseModel> getFeatureToggles() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.menuEndpoint}";
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }
}