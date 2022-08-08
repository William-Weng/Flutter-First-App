import 'dart:developer';

import 'package:flutter/material.dart';

class WWProgressIndicator extends StatefulWidget {
  const WWProgressIndicator({Key? key}) : super(key: key);

  static const shared = WWProgressIndicator();

  @override
  State<WWProgressIndicator> createState() => _WWProgressIndicatorState();

  display(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => this,
      ),
    );
  }

  void dismiss(BuildContext context) {
    if (!Navigator.canPop(context)) {
      return;
    }
    Navigator.of(context).pop();
  }
}

class _WWProgressIndicatorState extends State<WWProgressIndicator> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(64),
      body: const Center(
        child: SizedBox(
          width: 128,
          height: 128,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
        ),
      ),
    );
  }
}
