import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/Message.dart';

class ChatPage extends StatefulWidget {
  final List<Message> _messages;
  final Function(String msgText, String meme) _sendMsg;

  const ChatPage(this._messages, this._sendMsg, {Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Widget getInputPanel() {
    return const Text("123");
  }

  Widget getListView() {
    return const Text("123");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: getListView(),
            ),
          ),
          getInputPanel()
        ],
      ),
    );
  }
}
