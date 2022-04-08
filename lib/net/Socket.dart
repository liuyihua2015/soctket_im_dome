import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:soctket_im_dome/model/Message.dart';

class BaseSocketCS {
  var msgStream = StreamController<Message>();
  void init() async {}

  void send(Message msg) {}

  @mustCallSuper
  void dispose() {
    msgStream.close();
  }
}
