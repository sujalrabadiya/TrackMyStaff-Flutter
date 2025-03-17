import 'dart:async';

import 'package:flutter/material.dart';
import 'package:track_my_staff/screens/splash.dart';
import 'package:track_my_staff/services/chat_service.dart';
import 'package:track_my_staff/widgets/conversationList.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: kDefaultPadding2,
          //   child: Container(
          //     decoration: ShapeDecoration(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(30),
          //       ),
          //       color: Colors.white,
          //     ),
          //     height: 45,
          //     width: double.infinity,
          //     child: TextField(
          //       decoration: InputDecoration(
          //         hintText: "Search...",
          //         hintStyle: TextStyle(color: Colors.grey.shade600),
          //         prefixIcon: Icon(Icons.search,color: Colors.grey.shade600),
          //         border: InputBorder.none,
          //       ),
          //     ),
          //   ),
          // ),
          FutureBuilder(future: ChatService.getConversationList(finalUId!), builder: (context, snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 5),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return ConversationList(
                    id: snapshot.data![index]["otherUserId"],
                    name: snapshot.data![index]["otherUserName"] == "" ? "Deleted User" : snapshot.data![index]["otherUserName"],
                    phone: snapshot.data![index]["otherUserPhone"],
                    messageText: snapshot.data![index]["message"],
                    imageUrl: snapshot.data![index]["otherUserImgUrl"],
                    messageUrl: snapshot.data![index]["messageUrl"],
                    time: snapshot.data![index]["sentAt"],
                    isMessageRead: false,
                    // isMessageRead: (index == 0 || index == 3)?true:false,
                  );
                },
              );
            }
            else {
            return Center(
            child: Text("No Chat Found!"),
            );
            }
          },)

        ],
      ),
    );
  }
}