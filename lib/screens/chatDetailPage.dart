import 'dart:async';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:track_my_staff/models/chatMessageSendModel.dart';
import 'package:track_my_staff/screens/splash.dart';
import 'package:track_my_staff/services/chat_service.dart';
import 'package:track_my_staff/theme.dart';

class ChatDetailPage extends StatefulWidget {
  final int? userId;
  final String userName;
  final String userPhone;

  ChatDetailPage({super.key, this.userId, required this.userName, required this.userPhone});
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final ScrollController scrollController = ScrollController();
  final _messageController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  String? imgUrl;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _scrollToBottom();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 200), () {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      imgUrl = await ChatService.uploadImageToCloudinary(_selectedImage!);
      sendImage(imgUrl);

      setState(() {
        imgUrl = null;
        _scrollToBottom();
      });
    }
  }

  Future<void> captureImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      imgUrl = await ChatService.uploadImageToCloudinary(_selectedImage!);
      sendImage(imgUrl);

      setState(() {
        imgUrl = null;
        _scrollToBottom();
      });
    }
  }

  void sendImage(String? imageUrl) async {
    if (widget.userId != null) {
      var message = MessageModel(
          senderId: finalUId!,
          receiverId: widget.userId!,
          message: null,
          imageUrl: imageUrl != null ? imgUrl : null);
      await ChatService.sendMessage(message);
      setState(() {});
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        flexibleSpace: SafeArea(
          child: Container(
            color: kPrimaryColor,
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: kWhiteColor,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(finalImgUrl!),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.userName,
                        style: TextStyle(
                            color: kWhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      // SizedBox(
                      //   height: 3,
                      // ),
                      Text(
                        widget.userPhone,
                        style: TextStyle(color: kWhiteColor, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                /*only for supervisor and admin*/
                PopupMenuButton(
                  iconColor: kWhiteColor,
                  onSelected: (value) async {
                    switch(value){
                      case 'Clear Chat':
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                AlertDialog(
                                  alignment: Alignment.center,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(5)),
                                  icon: Icon(
                                    Icons.remove_circle_outline,
                                    size: 50,
                                  ),
                                  title: Text("Are you sure ?"),
                                  titleTextStyle: TextStyle(
                                      color: Colors.redAccent),
                                  content: Text(
                                    "You want to clear this chat!",
                                    textAlign: TextAlign.center,
                                  ),
                                  actionsAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  iconColor: Colors.redAccent,
                                  actions: [
                                    OutlinedButton(
                                        style:
                                        OutlinedButton.styleFrom(
                                            visualDensity:
                                            VisualDensity(
                                                horizontal:
                                                0),
                                            padding:
                                            EdgeInsets.all(0),
                                            side:
                                            BorderSide.none),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Cancel")),
                                    OutlinedButton(
                                        style:
                                        OutlinedButton.styleFrom(
                                            visualDensity:
                                            VisualDensity(
                                                horizontal:
                                                0),
                                            padding:
                                            EdgeInsets.all(0),
                                            side:
                                            BorderSide.none),
                                        onPressed: () async {
                                          await ChatService.clearChat(finalUId!, widget.userId!);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "Yes",
                                          style: TextStyle(
                                              color:
                                              Colors.redAccent),
                                        )),
                                  ],
                                ));
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return {'Clear Chat'}
                        .map((String choice) {
                      return PopupMenuItem(
                        height: 30,
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: ChatService.getConversation(finalUId!, widget.userId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    dragStartBehavior: DragStartBehavior.down,
                    // physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment:
                              (snapshot.data![index].messageType == "receiver"
                                  ? Alignment.topLeft
                                  : Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: (snapshot.data![index].messageType ==
                                      "receiver"
                                  ? kReceiverColor
                                  : kSenderColor),
                            ),
                            padding: EdgeInsets.all(15),
                            child: snapshot.data![index].messageContent != ""
                                ? Text(
                                    snapshot.data![index].messageContent,
                                    style: TextStyle(fontSize: 15),
                                  )
                                : Image.network(
                                    snapshot.data![index].messageImgUrl!,
                                    width: 150,
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Text("No Chat Found!"),
                );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: Colors.white,
                ),
                height: 50,
                width: double.infinity,
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.attach_file_outlined,
                        color: kDarkGreyColor,
                        size: 22,
                      ),
                      visualDensity: VisualDensity(horizontal: -4),
                      onPressed: pickImage,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        color: kDarkGreyColor,
                        size: 22,
                      ),
                      visualDensity: VisualDensity(horizontal: -4),
                      onPressed: captureImage,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.green[800],
                        size: 25,
                      ),
                      visualDensity: VisualDensity(horizontal: -4),
                      highlightColor: kTransparentColor,
                      onPressed: () async {
                        if (widget.userId != null && _messageController.text != "") {
                          var message = MessageModel(
                            senderId: finalUId!,
                            receiverId: widget.userId!,
                            message: _messageController.text,
                          );
                          await ChatService.sendMessage(message);
                          _messageController.clear();
                          setState(() {});
                          _scrollToBottom();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
