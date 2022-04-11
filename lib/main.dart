import 'package:flutter/material.dart';
import 'package:soctket_im_dome/model/Message.dart';
import '/page/SettingHomePage.dart';
import 'net/Socket.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late BaseSocketCS _socketCS;
  final List<Message> _messages = [];

  void createServer(int port) {
    _socketCS = SocketServer(port);
    initSocketCS();
  }

  void createClient(String address, int port) {
    _socketCS = SocketClient(address, port);
    initSocketCS();
  }

  void initSocketCS() {
    _socketCS.init();
    _socketCS.msgStream.stream.listen((msg) {
      debugPrint(msg.toJson().toString());
      setState(() {
        _messages.insert(0, msg);
      });
    });
  }

  void onSendMessage(String msgText, String meme) {
    var msgToUser = Message(Message.TYPE_USER, msgText, meme);
    var msgToMe = Message(Message.TYPE_ME, msgText, meme);
    _socketCS.send(msgToUser);
    setState(() {
      _messages.insert(0, msgToMe);
    });
  }

  void goToChatPage(BuildContext contentcontext) {
    @override
    void dispose() {
      super.dispose();
      _socketCS.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Socket IM",
      home:  SettingHomePage(),
    );
  }
}
