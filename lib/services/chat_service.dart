import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:track_my_staff/models/chatMessageModel.dart';
import 'package:track_my_staff/models/chatMessageSendModel.dart';
import 'package:track_my_staff/screens/splash.dart';

class ChatService {
  // static const String baseUrl = "https://localhost:7162/api";
  static const String baseUrl = "http://192.168.169.194:7165/api";
  // static const String baseUrl = "http://localhost:5046/api";

  static Future<bool> sendMessage(MessageModel message) async {
    final Uri url = Uri.parse("$baseUrl/Message/send");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(message),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<List<ChatMessage>> getConversation(
      int userId1, int? userId2) async {
    final Uri url =
        Uri.parse("$baseUrl/Message/conversation/$userId1-$userId2");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData
            .map((e) => ChatMessage(
                messageContent: e["message"],
                messageImgUrl: e["imageUrl"],
                messageType: e["senderId"] == finalUId ? "sender" : "receiver"))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  static Future<bool> clearChat(int userId1, int userId2) async {
    final Uri url = Uri.parse("$baseUrl/Message/clear-chat/$userId1-$userId2");
    try {
      final response = await http.delete(url);
      return response.statusCode == 200;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>?> getConversationList(
      int userId) async {
    final Uri url = Uri.parse("$baseUrl/Message/conversation-list/$userId");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        jsonData.forEach(
          (element) {
            if (element["sentAt"] != null) {
              var sentAt = DateTime.parse(element["sentAt"]);
              if (DateTime.now().difference(sentAt).inDays < 1)
                element["sentAt"] = DateFormat("hh:mm a").format(sentAt);
              else
                element["sentAt"] = DateFormat("MMM dd, yyyy").format(sentAt);
            } else {
              element["sentAt"] = "";
            }
          },
        );
        return jsonData.map((e) => e as Map<String, dynamic>).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  static Future<String?> uploadImageToCloudinary(File imageFile) async {
    const cloudinaryUrl =
        "https://api.cloudinary.com/v1_1/dhmj6l6q5/image/upload";

    // Uint8List imageBytes = await imageFile.readAsBytes();

    var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl));
    request.fields['upload_preset'] = 'unsigned_preset';
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));
    // request.files.add(http.MultipartFile.fromBytes(
    //   'file',
    //   imageBytes,
    //   filename: imageFile.name,
    // ));
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var jsonData = json.decode(responseData);
      String imageUrl = jsonData['secure_url'];
      return imageUrl;
    } else {
      print("Image upload failed!");
      return null;
    }
  }
}
