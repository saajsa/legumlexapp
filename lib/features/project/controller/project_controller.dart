import 'dart:async';
import 'dart:convert';
import 'package:legumlex_customer/common/components/snack_bar/show_custom_snackbar.dart';
import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/features/estimate/model/estimate_model.dart';
import 'package:legumlex_customer/features/invoice/model/invoice_model.dart';
import 'package:legumlex_customer/features/main_navigation/controller/main_navigation_controller.dart';
import 'package:legumlex_customer/features/project/model/discussions_model.dart';
import 'package:legumlex_customer/features/project/model/project_details_model.dart';
import 'package:legumlex_customer/features/project/model/project_model.dart';
import 'package:legumlex_customer/features/project/model/task_create_model.dart';
import 'package:legumlex_customer/features/project/model/task_post_model.dart';
import 'package:legumlex_customer/features/project/model/tasks_model.dart';
import 'package:legumlex_customer/features/project/repo/project_repo.dart';
import 'package:legumlex_customer/features/proposal/model/proposal_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class ProjectController extends GetxController {
  ProjectRepo projectRepo;
  ProjectController({required this.projectRepo});

  bool isLoading = true;
  bool submitLoading = false;
  bool projectOverviewEnable = true;
  bool projectTasksEnable = true;
  bool projectDiscussionsEnable = true;
  bool projectInvoicesEnable = true;
  bool projectProposalsEnable = true;
  bool projectEstimatesEnable = true;
  bool createTaskEnable = true;
  bool editTaskEnable = true;
  ProjectsModel projectsModel = ProjectsModel();
  ProjectDetailsModel projectDetailsModel = ProjectDetailsModel();
  TasksModel tasksModel = TasksModel();
  InvoicesModel invoicesModel = InvoicesModel();
  ProposalsModel proposalsModel = ProposalsModel();
  EstimatesModel estimatesModel = EstimatesModel();
  DiscussionsModel discussionsModel = DiscussionsModel();
  TaskCreateModel taskCreateModel = TaskCreateModel();
  List<String> projectAssignees = [];

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = shouldLoad ? true : false;
    update();

    await loadProjects();
    isLoading = false;
    update();
  }

  Future<void> loadProjects() async {
    try {
      ResponseModel responseModel = await projectRepo.getAllProjects();
      
      if (responseModel.status && responseModel.responseJson.isNotEmpty) {
        projectsModel = ProjectsModel.fromJson(jsonDecode(responseModel.responseJson));
      } else {
        // Handle permission denied or other errors
        print('Projects load failed: ${responseModel.message}');
        
        // If it's a permission denied error, disable the feature in navigation
        if (responseModel.message?.toLowerCase().contains('permission') == true) {
          try {
            final mainNavController = Get.find<MainNavigationController>();
            mainNavController.disableFeatureOnPermissionDenied('projects');
          } catch (e) {
            print('Could not disable projects in navigation: $e');
          }
        }
        
        projectsModel = ProjectsModel(status: false, message: responseModel.message, data: []);
      }
    } catch (e) {
      print('Error loading projects: $e');
      projectsModel = ProjectsModel(status: false, message: 'Failed to load projects', data: []);
    }
    
    isLoading = false;
    update();
  }

  Future<void> loadProjectDetails(projectId) async {
    ResponseModel responseModel =
        await projectRepo.getProjectDetails(projectId);
    if (responseModel.status) {
      projectDetailsModel =
          ProjectDetailsModel.fromJson(jsonDecode(responseModel.responseJson));
      var projectOverview = projectDetailsModel
          .data!.settings!.availableFeatures!.projectOverview;
      projectOverviewEnable =
          projectOverview != null && projectOverview == 0 ? false : true;

      var projectTasks =
          projectDetailsModel.data!.settings!.availableFeatures!.projectTasks;
      projectTasksEnable =
          projectTasks != null && projectTasks == 0 ? false : true;

      var projectDiscussions = projectDetailsModel
          .data!.settings!.availableFeatures!.projectDiscussions;
      projectDiscussionsEnable =
          projectDiscussions != null && projectDiscussions == 0 ? false : true;

      var projectInvoices = projectDetailsModel
          .data!.settings!.availableFeatures!.projectInvoices;
      projectInvoicesEnable =
          projectInvoices != null && projectInvoices == 0 ? false : true;

      var projectProposals = projectDetailsModel
          .data!.settings!.availableFeatures!.projectProposals;
      projectProposalsEnable =
          projectProposals != null && projectProposals == 0 ? false : true;

      var projectEstimates = projectDetailsModel
          .data!.settings!.availableFeatures!.projectEstimates;
      projectEstimatesEnable =
          projectEstimates != null && projectEstimates == 0 ? false : true;
      var createTask = projectDetailsModel.data!.settings!.createTasks;
      createTaskEnable = createTask != null && createTask == '0' ? false : true;
      var editTask = projectDetailsModel.data!.settings!.editTasks;
      editTaskEnable = editTask != null && editTask == '0' ? false : true;
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();
  }

  Future<void> loadProjectTasks(projectId) async {
    ResponseModel responseModel =
        await projectRepo.getProjectGroup(projectId, 'tasks');
    if (responseModel.status) {
      tasksModel = TasksModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {
      CustomSnackBar.error(errorList: [responseModel.message.tr]);
    }
    isLoading = false;
    update();
  }

  Future<void> loadProjectInvoices(projectId) async {
    ResponseModel responseModel =
        await projectRepo.getProjectGroup(projectId, 'invoices');
    if (responseModel.status) {
      invoicesModel =
          InvoicesModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {
      CustomSnackBar.error(errorList: [responseModel.message.tr]);
    }
    isLoading = false;
    update();
  }

  Future<void> loadProjectProposals(projectId) async {
    ResponseModel responseModel =
        await projectRepo.getProjectGroup(projectId, 'proposals');
    if (responseModel.status) {
      proposalsModel =
          ProposalsModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {
      CustomSnackBar.error(errorList: [responseModel.message.tr]);
    }
    isLoading = false;
    update();
  }

  Future<void> loadProjectDiscussions(projectId) async {
    ResponseModel responseModel =
        await projectRepo.getProjectGroup(projectId, 'discussions');
    if (responseModel.status) {
      discussionsModel =
          DiscussionsModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {
      CustomSnackBar.error(errorList: [responseModel.message.tr]);
    }
    isLoading = false;
    update();
  }

  Future<void> loadProjectEstimates(projectId) async {
    ResponseModel responseModel =
        await projectRepo.getProjectGroup(projectId, 'estimates');
    if (responseModel.status) {
      estimatesModel =
          EstimatesModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {
      CustomSnackBar.error(errorList: [responseModel.message.tr]);
    }
    isLoading = false;
    update();
  }

  Future<void> loadProjectTaskData(projectId) async {
    ResponseModel responseModel =
        await projectRepo.getProjectTaskData(projectId);
    if (responseModel.status) {
      taskCreateModel =
          TaskCreateModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {
      CustomSnackBar.error(errorList: [responseModel.message.tr]);
    }
    isLoading = false;
    update();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  MultiSelectController<Object> assigneesController = MultiSelectController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode priorityFocusNode = FocusNode();
  FocusNode assigneesFocusNode = FocusNode();
  FocusNode startDateFocusNode = FocusNode();
  FocusNode dueDateFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  bool isSubmitLoading = false;

  Future<void> submitTask(projectId) async {
    String name = nameController.text.toString();
    String priority = priorityController.text.toString();
    String startDate = startDateController.text.toString();
    String dueDate = dueDateController.text.toString();
    String description = descriptionController.text.toString();

    if (name.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.taskNameFieldErrorMsg.tr]);
      return;
    }
    if (startDate.isEmpty) {
      CustomSnackBar.error(
          errorList: [LocalStrings.taskStartDateFieldErrorMsg.tr]);
      return;
    }
    if (dueDate.isEmpty) {
      CustomSnackBar.error(
          errorList: [LocalStrings.taskDueDateFieldErrorMsg.tr]);
      return;
    }
    if (description.isEmpty) {
      CustomSnackBar.error(
          errorList: [LocalStrings.taskDescriptionFieldErrorMsg]);
      return;
    }

    isSubmitLoading = true;
    update();

    TaskPostModel taskModel = TaskPostModel(
        name: name,
        priority: priority,
        startDate: startDate,
        dueDate: dueDate,
        description: description,
        assignees: projectAssignees);

    ResponseModel responseModel =
        await projectRepo.createTask(projectId, taskModel);
    if (responseModel.status) {
      Get.back();
      await loadProjectTasks(projectId);
      CustomSnackBar.success(successList: [responseModel.message.tr]);
    } else {
      CustomSnackBar.error(errorList: [responseModel.message.tr]);
      return;
    }

    isSubmitLoading = false;
    update();
  }

  Future<void> updateTask(projectId, taskId, BuildContext context) async {
    String name = nameController.text.toString();
    String priority = priorityController.text.toString();
    String startDate = startDateController.text.toString();
    String dueDate = dueDateController.text.toString();
    String description = descriptionController.text.toString();

    if (name.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.taskNameFieldErrorMsg]);
      return;
    }
    if (startDate.isEmpty) {
      CustomSnackBar.error(
          errorList: [LocalStrings.taskStartDateFieldErrorMsg]);
      return;
    }
    if (dueDate.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.taskDueDateFieldErrorMsg]);
      return;
    }
    if (description.isEmpty) {
      CustomSnackBar.error(
          errorList: [LocalStrings.taskDescriptionFieldErrorMsg]);
      return;
    }

    isSubmitLoading = true;
    update();

    TaskPostModel taskModel = TaskPostModel(
        name: name,
        priority: priority,
        startDate: startDate,
        dueDate: dueDate,
        description: description,
        assignees: projectAssignees);

    ResponseModel responseModel =
        await projectRepo.updateTask(projectId, taskId, taskModel);
    if (responseModel.status) {
      Get.back();
      await loadProjectTasks(projectId);
      CustomSnackBar.success(successList: [responseModel.message.tr]);
    } else {
      CustomSnackBar.error(errorList: [responseModel.message.tr]);
      return;
    }

    isSubmitLoading = false;
    update();
  }

  void clearData() {
    isLoading = false;
    nameController.text = '';
    priorityController.text = '';
    startDateController.text = '';
    dueDateController.text = '';
    descriptionController.text = '';
    projectAssignees.clear();
    assigneesController.clearAll();
  }
}
