import 'package:flutter/material.dart';
import '../model/Message.dart';

class MessageComponent extends StatelessWidget {
  final Message _msg;

  const MessageComponent(
    this._msg, {
    Key? key,
  }) : super(key: key);

  Widget showMessage() {
    if (_msg.from == Message.TYPE_ME) {
      return Text(_msg.msg!,style: const TextStyle(color: Colors.white),);
    } else {
      return Text(_msg.msg!,style: const TextStyle(color: Colors.black),);
    }

  }

 Widget containerOpposite(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.fromLTRB(0, 6, 0, 6),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
          ),
          child: showMessage(),
        ),
      ],
    );
  }

  Widget containerMe(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.fromLTRB(0, 6, 0, 6),
          constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
          decoration: BoxDecoration(
            color: Colors.green[400],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          child: showMessage(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_msg.from == Message.TYPE_ME) {
      return containerMe(context);
    } else {
      return containerOpposite(context);
    }
  }
}
