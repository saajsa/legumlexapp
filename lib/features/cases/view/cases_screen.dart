import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legumlex_customer/core/route/route.dart';
import 'package:legumlex_customer/features/cases/controller/cases_controller.dart';
import 'package:legumlex_customer/features/cases/controller/consultations_controller.dart';
import 'package:legumlex_customer/features/cases/controller/documents_controller.dart';
import 'package:legumlex_customer/features/cases/model/case_model.dart';
import 'package:legumlex_customer/features/cases/widget/case_card.dart';
import 'package:legumlex_customer/features/cases/widget/consultation_card.dart';
import 'package:legumlex_customer/features/cases/widget/document_card.dart';

class CasesScreen extends StatefulWidget {
  @override
  _CasesScreenState createState() => _CasesScreenState();
}

class _CasesScreenState extends State<CasesScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late CasesController casesController;
  late ConsultationsController consultationsController;
  late DocumentsController documentsController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Initialize controllers
    casesController = Get.put(CasesController());
    consultationsController = Get.put(ConsultationsController());
    documentsController = Get.put(DocumentsController());
    
    // Fetch initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      casesController.fetchCases();
      consultationsController.fetchConsultations();
      documentsController.fetchDocuments();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cases'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Cases'),
            Tab(text: 'Consultations'),
            Tab(text: 'Documents'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCasesTab(),
          _buildConsultationsTab(),
          _buildDocumentsTab(),
        ],
      ),
    );
  }

  Widget _buildCasesTab() {
    return GetBuilder<CasesController>(
      builder: (casesController) {
        if (casesController.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (casesController.errorMessage != null) {
          return Center(
            child: Text('Error: ${casesController.errorMessage}'),
          );
        }

        if (casesController.cases.isEmpty) {
          return Center(
            child: Text('No cases found'),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: casesController.cases.length,
          itemBuilder: (context, index) {
            final caseModel = casesController.cases[index];
            return CaseCard(
              caseModel: caseModel,
              onTap: () {
                // Navigate to case details screen
                _navigateToCaseDetails(caseModel);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildConsultationsTab() {
    return GetBuilder<ConsultationsController>(
      builder: (consultationsController) {
        if (consultationsController.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (consultationsController.errorMessage != null) {
          return Center(
            child: Text('Error: ${consultationsController.errorMessage}'),
          );
        }

        if (consultationsController.consultations.isEmpty) {
          return Center(
            child: Text('No consultations found'),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: consultationsController.consultations.length,
          itemBuilder: (context, index) {
            final consultation = consultationsController.consultations[index];
            return ConsultationCard(
              consultation: consultation,
              onTap: () {
                // Navigate to consultation details screen
                _navigateToConsultationDetails(consultation);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildDocumentsTab() {
    return GetBuilder<DocumentsController>(
      builder: (documentsController) {
        if (documentsController.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (documentsController.errorMessage != null) {
          return Center(
            child: Text('Error: ${documentsController.errorMessage}'),
          );
        }

        if (documentsController.documents.isEmpty) {
          return Center(
            child: Text('No documents found'),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: documentsController.documents.length,
          itemBuilder: (context, index) {
            final document = documentsController.documents[index];
            return DocumentCard(
              document: document,
              onTap: () {
                // Handle document tap (e.g., download or preview)
                _handleDocumentTap(document);
              },
            );
          },
        );
      },
    );
  }

  void _navigateToCaseDetails(CaseModel caseModel) {
    Get.toNamed(RouteHelper.caseDetailsScreen, arguments: caseModel);
  }

  void _navigateToConsultationDetails(ConsultationModel consultation) {
    Get.toNamed(RouteHelper.consultationDetailsScreen, arguments: consultation);
  }

  void _handleDocumentTap(DocumentModel document) {
    // For now, just show a snackbar - in a real app you might want to download or preview the document
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening document: ${document.fileName}')),
    );
  }
}