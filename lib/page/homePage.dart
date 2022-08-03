import 'dart:developer';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  String _message = '';

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.detached:
        _message += ' \n=> detached';
        break;
      case AppLifecycleState.inactive:
        _message += ' \n=> inactive';
        break;
      case AppLifecycleState.paused:
        _message += ' \n=> paused';
        break;
      case AppLifecycleState.resumed:
        _message += ' \n=> resumed';
        break;
    }

    log(_message);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _message = widget.title;
    _message += ' \n=> initState';
    log(_message);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _message += ' \n=> dispose';
    log(_message);
  }

  @override
  void deactivate() {
    super.deactivate();
    _message += ' \n=> deactivate';
    log(_message);
  }

  @override
  Widget build(BuildContext context) {
    _message += ' \n=> build';
    log(_message);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Text(
          _message,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 36,
          ),
        ),
      ),
    );
  }
}
