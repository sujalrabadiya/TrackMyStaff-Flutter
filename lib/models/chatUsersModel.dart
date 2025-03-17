
class ChatUsers{
  int? id;
  String name;
  String? messageText;
  String time;

  ChatUsers({this.id, required this.name, this.messageText, required this.time});

  Map<String, dynamic> toJson() {
    return {
      "OtherUserId": id,
      "OtherUserName": name,
      "Message": messageText,
      "SentAt": time
    };
  }
}