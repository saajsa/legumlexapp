import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/method.dart';
import 'package:legumlex_customer/core/utils/url_container.dart';
import 'package:legumlex_customer/features/auth/model/sign_up_model.dart';

class AuthRepo {
  ApiClient apiClient;

  AuthRepo({required this.apiClient});

  Future<ResponseModel> loginUser(String email, String password) async {
    Map<String, String> map = {'email': email, 'password': password};
    String url = '${UrlContainer.baseUrl}${UrlContainer.loginUrl}';
    ResponseModel model =
        await apiClient.request(url, Method.postMethod, map, passHeader: false);
    return model;
  }

  Map<String, String> modelToMap(String value, String type) {
    Map<String, String> map = {'type': type, 'value': value};
    return map;
  }

  Map<String, String> deviceTokenMap(String deviceToken) {
    Map<String, String> map = {'token': deviceToken.toString()};
    return map;
  }

  Future<ResponseModel> registerUser(SignUpPostModel signUpPostModel) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.registrationUrl}';
    Map<String, dynamic> params = {
      'company': signUpPostModel.company,
      'firstname': signUpPostModel.firstName,
      'lastname': signUpPostModel.lastName,
      'email': signUpPostModel.email,
      'phonenumber': signUpPostModel.mobile,
      'password': signUpPostModel.password,
      'passwordr': signUpPostModel.rPassword,
    };
    ResponseModel responseModel = await apiClient
        .request(url, Method.postMethod, params, passHeader: false);
    return responseModel;
  }
}
