import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:legumlex_customer/common/components/snack_bar/show_custom_snackbar.dart';
import 'package:legumlex_customer/common/models/response_model.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/features/ticket/model/departments_model.dart';
import 'package:legumlex_customer/features/ticket/model/priorities_model.dart';
import 'package:legumlex_customer/features/ticket/model/ticket_create_model.dart';
import 'package:legumlex_customer/features/ticket/model/ticket_details_model.dart';
import 'package:legumlex_customer/features/ticket/model/ticket_model.dart';
import 'package:legumlex_customer/features/ticket/repo/ticket_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketController extends GetxController {
  TicketRepo ticketRepo;
  TicketController({required this.ticketRepo});

  bool isLoading = true;
  bool isSubmitLoading = false;
  TicketsModel ticketsModel = TicketsModel();
  DepartmentModel departmentModel = DepartmentModel();
  PriorityModel priorityModel = PriorityModel();
  TicketDetailsModel ticketDetailsModel = TicketDetailsModel();
  File? imageFile;
  String? fileName;

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = shouldLoad ? true : false;
    update();

    await loadTickets();
    isLoading = false;
    update();
  }

  Future<void> loadTickets() async {
    ResponseModel responseModel = await ticketRepo.getAllTickets();
    if (responseModel.status) {
      ticketsModel =
          TicketsModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {
      CustomSnackBar.error(errorList: [responseModel.message.tr]);
    }
    isLoading = false;
    update();
  }

  TextEditingController subjectController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  FocusNode subjectFocusNode = FocusNode();
  FocusNode departmentFocusNode = FocusNode();
  FocusNode priorityFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();

  Future<void> submitTicket() async {
    String subject = subjectController.text.toString();
    String department = departmentController.text.toString();
    String priority = priorityController.text.toString();
    String description = descriptionController.text.toString();

    if (subject.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterTicketSubject.tr]);
      return;
    }
    if (description.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterTicketDescription.tr]);
      return;
    }

    isSubmitLoading = true;
    update();

    TicketCreateModel ticketModel = TicketCreateModel(
      subject: subject,
      department: department,
      priority: priority,
      description: description,
      image: imageFile,
    );

    bool responseModel = await ticketRepo.createTicket(ticketModel);
    if (responseModel) {
      Get.back();
      await initialData();
    } else {
      isSubmitLoading = false;
      update();
    }

    isSubmitLoading = false;
    update();
  }

  Future<void> loadTicketCreateData() async {
    ResponseModel departmentsResponseModel =
        await ticketRepo.getTicketDepartments();
    ResponseModel prioritiesResponseModel =
        await ticketRepo.getTicketPriorities();
    departmentModel = DepartmentModel.fromJson(
        jsonDecode(departmentsResponseModel.responseJson));
    priorityModel = PriorityModel.fromJson(
        jsonDecode(prioritiesResponseModel.responseJson));
    isLoading = false;
    update();
  }

  Future<void> loadTicketDetails(ticketId) async {
    ResponseModel responseModel = await ticketRepo.getTicketDetails(ticketId);
    if (responseModel.status) {
      ticketDetailsModel =
          TicketDetailsModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();
  }

  TextEditingController messageController = TextEditingController();
  FocusNode messageFocusNode = FocusNode();

  Future<void> addTicketReply(ticketId) async {
    String message = messageController.text.toString();

    if (message.isEmpty) {
      CustomSnackBar.error(errorList: [LocalStrings.enterTicketReply]);
      return;
    }

    isSubmitLoading = true;
    update();

    ResponseModel responseModel =
        await ticketRepo.postTicketReply(ticketId, message);
    if (responseModel.status) {
      Get.back();
      await loadTicketDetails(ticketId);
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
    isSubmitLoading = false;
    subjectController.text = '';
    departmentController.text = '';
    priorityController.text = '';
    descriptionController.text = '';
    messageController.text = '';
  }
}
