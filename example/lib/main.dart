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
  bool _needPair = false;
  bool _needAuthorization = false;

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

    _pairingOptionsRequiredSub =
        _ping.pairingOptionsRequired.listen((args) async {
      //Automatically Approving Pairing
      setState(() {
        _needPair = true;
      });
    });

    _pairingCompletedSub = _ping.pairingCompleted.listen((args) async {
      bool isTrusted = await _ping.deviceIsTrusted;
      setState(() {
        _isTrusted = isTrusted;
        //_needPair = false;
      });
    });

    _authRequiredSub = _ping.authenticationRequired.listen((args) async {
      //Automatically Approving Authentication
      setState(() {
        _needAuthorization = true;
      });
    });

    bool isTrusted = await _ping.deviceIsTrusted;

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

  Future<void> _pair() async {
    await _ping.pairingSelection(
        _username, ping.TrustLevel.TRUSTED, ping.Action.APPROVE);
    setState(() {
      _needPair = false;
    });
  }

  Future<void> _authorize() async {
    await _ping.authenticationSelection(_username, ping.Action.APPROVE);
    setState(() {
      _needAuthorization = false;
    });
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
              SizedBox(
                height: 20,
              ),
              Text('Is Trusted: ${_isTrusted ? "YES" : "NO"}'),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: _generatePayload,
                child: const Text('Generate Payload'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) => setState(() => _serverPayload = value),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: _sendServerPayload,
                child: const Text('Confirm payload'),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: _needPair ? _pair : null,
                child: const Text('Pair'),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: _needAuthorization ? _authorize : null,
                child: const Text('Authorization'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
