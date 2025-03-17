import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:track_my_staff/screens/chatDetailPage.dart';

class ConversationList extends StatefulWidget{
  final int? id;
  final String name;
  final String phone;
  final String? messageText;
  final String? messageUrl;
  final String? imageUrl;
  final String time;
  final bool isMessageRead;
  ConversationList({super.key, this.id, required this.name, required this.phone, required this.messageText, required this.messageUrl, this.imageUrl, required this.time, required this.isMessageRead});

  @override
  State<ConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(ChatDetailPage(userId: widget.id, userPhone: widget.phone, userName: widget.name,));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl!),
                    maxRadius: 25,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name, style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text(widget.messageText == "" ? widget.messageUrl == "" ? "" : "Photo" : widget.messageText!, style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(widget.time,style: TextStyle(fontSize: 11,fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
          ],
        ),
      ),
    );
  }
}