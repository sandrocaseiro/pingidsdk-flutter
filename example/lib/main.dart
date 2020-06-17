import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pingidsdk/pingidsdk.dart' as ping;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<ping.PairingOptionsRequired> _pairingOptionsRequiredSub;
  StreamSubscription<ping.PairingCompleted> _pairingCompletedSub;
  StreamSubscription<dynamic> _authRequiredSub;
  final ping.PingIDSDK _ping = ping.PingIDSDK.instance;
  final String _username = "[username]";

  String _serverPayload = '';
  bool _isTrusted = false;
  

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    _pairingOptionsRequiredSub.cancel();
    _pairingCompletedSub.cancel();
    _authRequiredSub.cancel();
    super.dispose();
  }

  Future<void> init() async {
    if (!mounted) return;

    _pairingOptionsRequiredSub = _ping.pairingOptionsRequired.listen((args) async {
      //Automatically Approving Pairing
      await _ping.pairingSelection(_username, ping.TrustLevel.TRUSTED, ping.Action.APPROVE);
    });

    _pairingCompletedSub = _ping.pairingCompleted.listen((args) async {
      bool isTrusted = await _ping.deviceIsTrusted;
      setState(() {
        _isTrusted = isTrusted;
      });
    });

    _authRequiredSub = _ping.authenticationRequired.listen((args) async {
        //Automatically Approving Authentication
        await _ping.authenticationSelection(_username, ping.Action.APPROVE);
    });

    String payload;
    bool isTrusted = await _ping.deviceIsTrusted;
    if (!isTrusted)
      payload = await _ping.payload;

    print(payload);

    setState(() {
      _isTrusted = isTrusted;
    });
  }

  Future<void> _sendServerPayload() async {
    await _ping.sendServerPayload(_serverPayload);
  }

  Future<void> _generatePayload() async {
    String payload = await _ping.payload;
    print(payload);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) => setState(() => _serverPayload = value),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: _sendServerPayload,
                child: const Text('Send payload'),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: _isTrusted ? _generatePayload : null,
                child: const Text('Authentication Payload'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
