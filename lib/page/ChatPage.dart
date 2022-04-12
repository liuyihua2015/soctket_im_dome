import 'package:flutter/material.dart';
import '../model/Message.dart';
import 'MessageComponent.dart';
import 'MessageInputComponent.dart';

class ChatPage extends StatefulWidget {
  final List<Message> _messages;
  final Function(String msgText, String meme) _sendMsg;

  const ChatPage(this._messages, this._sendMsg, {Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextEditingController _msgController;

  Widget getInputPanel() {
    return MessageInputComponent(msgController: _msgController, chatPage: widget);
  }

  Widget getListView() {
    return ListView.builder(
      reverse: true,
      itemBuilder: (_, int index) {
        Message msg = widget._messages[index];
        return MessageComponent(msg);
      },
      itemCount: widget._messages.length,
    );
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

  @override
  void initState() {
    super.initState();
    _msgController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _msgController.dispose();
  }
}
