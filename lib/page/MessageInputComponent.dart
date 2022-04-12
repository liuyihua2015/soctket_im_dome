import 'package:flutter/material.dart';

import 'ChatPage.dart';


class MessageInputComponent extends StatelessWidget {
  const MessageInputComponent({
    Key? key,
    required TextEditingController msgController,
    required this.chatPage,
  }) : _msgController = msgController, super(key: key);

  final TextEditingController _msgController;
  final ChatPage chatPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
      color: Colors.white,
      child: Row(children: [
        Flexible(
            child: TextField(
              autofocus: true,
              controller: _msgController,
            )),
        IconButton(
          icon: const Icon(Icons.face),
          iconSize: 32,
          color: Colors.grey[600],
          onPressed: () => null,
        ),
        IconButton(
          icon: const Icon(Icons.send),
          iconSize: 32,
          color: Colors.grey[600],
          onPressed: () {
            // TODO: 回调处理
            // chatPage.sendMsg(_msgController.text, "");
            _msgController.clear();
          },
        )
      ]),
    );
  }
}
