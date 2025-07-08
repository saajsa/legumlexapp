import 'dart:io';

class TicketReplyModel {
  final String message;
  final File? image;

  TicketReplyModel({
    required this.message,
    required this.image,
  });
}
