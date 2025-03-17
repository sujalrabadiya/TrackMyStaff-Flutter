class MessageModel {
  final int senderId;
  final int receiverId;
  final String? message;
  final String? imageUrl;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    this.message,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      "SenderId": senderId,
      "ReceiverId": receiverId,
      "Message": message,
      "ImageUrl": imageUrl,
    };
  }
}
