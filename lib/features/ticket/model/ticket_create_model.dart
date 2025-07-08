import 'dart:io';

class TicketCreateModel {
  final String subject;
  final String department;
  final String priority;
  final String description;
  final File? image;

  TicketCreateModel({
    required this.subject,
    required this.department,
    required this.priority,
    required this.description,
    required this.image,
  });
}
