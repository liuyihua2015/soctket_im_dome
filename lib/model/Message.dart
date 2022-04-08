/// from : "liu"
/// msg : "liu"
/// meme : "liu"

// ignore_for_file: constant_identifier_names

class Message {
  //消息来源定义 ： 对方 系统 自己
  static const String TYPE_USER = "user";
  static const String TYPE_SYSTEM = "system";
  static const String TYPE_ME = "me";

  Message({
    this.from,
    this.msg,
    this.meme,
  });

  Message.fromJson(dynamic json) {
    from = json['type'];
    msg = json['msg'];
    meme = json['meme'];
  }
  String? from;
  String? msg;
  String? meme;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = from;
    map['msg'] = msg;
    map['meme'] = meme;
    return map;
  }
}
