import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:legumlexapp/core/route/route.dart';
import 'package:legumlexapp/features/cases/controller/cases_controller.dart';
import 'package:legumlexapp/features/cases/controller/consultations_controller.dart';
import 'package:legumlexapp/features/cases/controller/documents_controller.dart';
import 'package:legumlexapp/features/cases/model/case_model.dart';
import 'package:legumlexapp/features/cases/widget/case_card.dart';
import 'package:legumlexapp/features/cases/widget/consultation_card.dart';
import 'package:legumlexapp/features/cases/widget/document_card.dart';

class CasesScreen extends StatefulWidget {
  @override
  _CasesScreenState createState() => _CasesScreenState();
}

class _CasesScreenState extends State<CasesScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Fetch initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CasesController>(context, listen: false).fetchCases();
      Provider.of<ConsultationsController>(context, listen: false).fetchConsultations();
      Provider.of<DocumentsController>(context, listen: false).fetchDocuments();
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
    return Consumer<CasesController>(
      builder: (context, casesController, child) {
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
    return Consumer<ConsultationsController>(
      builder: (context, consultationsController, child) {
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
    return Consumer<DocumentsController>(
      builder: (context, documentsController, child) {
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