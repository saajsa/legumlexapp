import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/method.dart';
import 'package:legumlex_customer/core/utils/url_container.dart';

class PrivacyRepo {
  ApiClient apiClient;
  PrivacyRepo({required this.apiClient});

  Future<dynamic> loadPrivacyData() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.privacyPolicyUrl}';
    final response = await apiClient.request(url, Method.getMethod, null);
    return response;
  }
}
