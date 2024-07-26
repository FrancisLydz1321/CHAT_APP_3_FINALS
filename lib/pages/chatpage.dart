import 'package:chat_app_3/service/database.dart';
import 'package:chat_app_3/service/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

class ChatPage extends StatefulWidget {
  // const ChatPage({super.key});
  String Name, profileurl, username;
  ChatPage(
      {required this.Name, required this.profileurl, required this.username});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messagecontroller = new TextEditingController();
  String? myUserName, myProfilePic, myName, myEmail, messageId, chatRoomId;
  Stream? messageStream;


  getthesharedpref() async {
    myUserName = await SharedPreferenceHelper().getUserName();
    myProfilePic = await SharedPreferenceHelper().getUserPic();
    myName = await SharedPreferenceHelper().getUserDisplayName();
    myEmail = await SharedPreferenceHelper().getUserEmail();

    chatRoomId = getChatRoomIdbyUsername(widget.username, myUserName!);
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  getChatRoomIdbyUsername(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(mainAxisAlignment: sendByMe? MainAxisAlignment.end:MainAxisAlignment.start, children: [Flexible(child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24), bottomLeft: sendByMe? Radius.circular(24): Radius.circular(0))
    ))],);
  }
  Widget chatMessage() {
    return StreamBuilder(stream: messageStream, builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasData? ListView.builder(padding: EdgeInsets.only(bottom: 90,top: 130), itemCount: snapshot.data.docs.length, reverse: true, itemBuilder: (context,index){
        DocumentSnapshot ds = snapshot.data.docs[index];
        return ;
      });
    });
  }
  addMessage(bool sendClicked) {
    if (messagecontroller.text != "") {
      String message = messagecontroller.text;
      messagecontroller.text = "";

      DateTime now = DateTime.now();
      String formattedDate = DateFormat('h:mma').format(now);
      Map<String, dynamic> messageinfoMap = {
        "message": message,
        "sendBy": myUserName,
        "ts": formattedDate,
        "time": FieldValue.serverTimestamp(),
        "imgUrl": myProfilePic,
      };
      if (messageId == null) {
        // messageId ??= randomAlphaNumeric(10);
        messageId = randomAlphaNumeric(10);
      }

      DatabaseMethods()
          .addMessage(chatRoomId!, messageId!, messageinfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": formattedDate,
          "time": FieldValue.serverTimestamp(),
          "lastMessageSendBy": myUserName,
        };

        DatabaseMethods()
            .updateLastMessageSend(chatRoomId!, lastMessageInfoMap);
        if (sendClicked) {
          messageId = "";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF7f30fe),
        body: Container(
          margin: EdgeInsets.only(
            top: 60,
            // left: 20,
            // right: 20,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Color(0xffc199cd),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    Text(
                      "PANSIS LEDUSTREs",
                      style: TextStyle(
                        color: Color(0xffc199cd),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20.0, right: 20, top: 50, bottom: 40),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.15,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 2),
                      alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 10, 240, 240),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          )),
                      child: Text(
                        'Hello how was the day?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width / 2),
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 10, 240, 240),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          )),
                      child: Text(
                        'Whatzz gooodd???',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Spacer(),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: messagecontroller,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type a message",
                                  hintStyle: TextStyle(
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                addMessage(true);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Color(0xFFf3f3f3),
                                    borderRadius: BorderRadius.circular(60)),
                                child: Center(
                                  child: Icon(
                                    Icons.send,
                                    color: Color(0xFFd3d3d3),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
