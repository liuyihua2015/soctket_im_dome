import 'dart:io';

import 'package:flutter/material.dart';

class SettingHomePage extends StatefulWidget {
  const SettingHomePage({Key? key}) : super(key: key);

  @override
  _SettingHomePageState createState() => _SettingHomePageState();
}

class _SettingHomePageState extends State<SettingHomePage> {
  String ipAddress = "";
  final _serverPortController = TextEditingController();
  final _clientAddressPortController = TextEditingController();
  final _clientPortController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getIpAddress();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _serverPortController.dispose();
    _clientAddressPortController.dispose();
    _clientPortController.dispose();
  }

  void getIpAddress() {
    NetworkInterface.list(
            includeLinkLocal: false, type: InternetAddressType.any)
        .then((List<NetworkInterface> interfaces) => {
              setState(() {
                ipAddress = "";
                // ignore: avoid_function_literals_in_foreach_calls
                interfaces.forEach((interface) {
                  ipAddress += "${interface.name}\n";
                  // ignore: avoid_function_literals_in_foreach_calls
                  interface.addresses.forEach((address) {
                    ipAddress += "${address.address}\n";
                  });
                });
              })
            });
  }

  Widget getDeviceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text("本机IP地址", style: TextStyle(fontSize: 26)),
        Text(ipAddress)
      ],
    );
  }

  Widget getClientConfig() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text("Socket client 模式运行", style: TextStyle(fontSize: 26)),
        const SizedBox(height: 5),
        Row(
          children: [
            const Text("Server IP："),
            Expanded(
                child: TextField(
                  controller: _clientAddressPortController,
                  keyboardType: TextInputType.number,
                ))
          ],
        ),
        Row(
          children: [
            const Text("Server 端口号："),
            Expanded(
                child: TextField(
                  controller: _clientPortController,
                  keyboardType: TextInputType.number,
                ))
          ],
        ),
        const SizedBox(height: 5),
        OutlinedButton(onPressed: () {}, child: const Text("启动"))
      ],
    );
  }

  Widget getServerConfig() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text("Socket server 模式运行", style: TextStyle(fontSize: 26)),
        const SizedBox(height: 5),
        Row(
          children: [
            const Text("端口号："),
            Expanded(
                child: TextField(
              controller: _serverPortController,
              keyboardType: TextInputType.number,
            ))
          ],
        ),
        const SizedBox(height: 5),
        OutlinedButton(onPressed: () {}, child: const Text("启动"))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("设置首页"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getDeviceInfo(),
              const SizedBox(height: 12),
              getServerConfig(),
              const SizedBox(height: 20),
              getClientConfig(),
              const SizedBox(height: 12),
              const Text("注：需先在一台设备上启动server，再用另一台设备连接")
            ],
          ),
        ),
      ),
    );
  }
}
