import 'dart:developer';

import 'package:flutter/material.dart';

class WWProgressIndicator extends StatefulWidget {
  late double radius = 32.0;

  WWProgressIndicator({Key? key, this.radius = 32.0}) : super(key: key);

  static WWProgressIndicator shared = WWProgressIndicator();

  @override
  State<WWProgressIndicator> createState() => _WWProgressIndicatorState();

  display(BuildContext context, {double? radius}) {
    if (radius != null) {
      this.radius = radius;
    }

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
      body: Center(
        child: SizedBox(
          width: widget.radius,
          height: widget.radius,
          child: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
        ),
      ),
    );
  }
}
