import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import '../model/Message.dart';

class BaseSocketCS {
  var msgStream = StreamController<Message>();

  void init() async {}

  void send(Message msg) {}

  @mustCallSuper
  void dispose() {
    msgStream.close();
  }
}

//基于Socket创建socket服务器端
class SocketServer extends BaseSocketCS {
  late ServerSocket serverSocket;
  List<Socket> clients = [];
  late int port;

  SocketServer(this.port);

  @override
  void init() async {
    ServerSocket.bind(InternetAddress.anyIPv4, port).then((bindSocket) {
      serverSocket = bindSocket;
      serverSocket.listen((clientSocket) {
        utf8.decoder.bind(clientSocket).listen((data) {
          msgStream.add(Message.fromJson(json.decode(data)));

          debugPrint(data);

          send(Message(Message.TYPE_USER, "hello world, too", ""));
        });
        clients.add(clientSocket);
      });
    });
  }

  @override
  void send(Message msg) async {
    for (var client in clients) {
      client.add(utf8.encode(json.encode(msg)));
    }
  }

  @override
  void dispose() async {
    super.dispose();
    for (var socket in clients) {
      socket.close();
    }
    serverSocket.close();
  }
}

//基于Socket创建socket客户端
class SocketClient extends BaseSocketCS {
  late Socket clientSocket;
  late String address;
  late int port;

  SocketClient(this.address, this.port);

  @override
  void init() async {
    clientSocket = await Socket.connect(address, port);
    utf8.decoder.bind(clientSocket).listen((data) {
      msgStream.add(Message.fromJson(json.encode(data)));
      //test code need delete
      debugPrint(data);
    });
    send(Message(Message.TYPE_USER, "hello world", ""));
  }

  @override
  void send(Message msg) {
    clientSocket.add(utf8.encode(json.encode(msg)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    clientSocket.close();
  }
}
