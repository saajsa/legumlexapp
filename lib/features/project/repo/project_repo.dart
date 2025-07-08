import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/method.dart';
import 'package:legumlex_customer/core/utils/url_container.dart';
import 'package:legumlex_customer/features/project/model/task_post_model.dart';

class ProjectRepo {
  ApiClient apiClient;
  ProjectRepo({required this.apiClient});

  Future<ResponseModel> getAllProjects() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.projectsUrl}";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getProjectDetails(projectId) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.projectsUrl}/id/$projectId";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getProjectGroup(projectId, projectGroup) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.projectsUrl}/id/$projectId/group/$projectGroup";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getProjectTaskData(projectId) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.projectsUrl}/id/$projectId/group/create_task_data";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> createTask(projectId, TaskPostModel taskModel) async {
    apiClient.initToken();

    String url =
        "${UrlContainer.baseUrl}${UrlContainer.projectsUrl}/id/$projectId/group/tasks";

    Map<String, dynamic> params = {
      "name": taskModel.name,
      "priority": taskModel.priority,
      "startdate": taskModel.startDate,
      "duedate": taskModel.dueDate,
      "description": taskModel.description,
      "assignees": taskModel.assignees,
    };

    ResponseModel responseModel = await apiClient
        .request(url, Method.postMethod, params, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> updateTask(
      projectId, taskId, TaskPostModel taskModel) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.projectsUrl}/id/$projectId/group/tasks";

    Map<String, dynamic> params = {
      "id": taskId,
      "name": taskModel.name,
      "priority": taskModel.priority,
      "startdate": taskModel.startDate,
      "duedate": taskModel.dueDate,
      "description": taskModel.description,
      "assignees": taskModel.assignees,
    };

    ResponseModel responseModel = await apiClient
        .request(url, Method.putMethod, params, passHeader: true);
    return responseModel;
  }
}
