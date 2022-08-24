import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_first_app/utility/widget/progressIndicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  const WebPage({Key? key}) : super(key: key);

  @override
  State<WebPage> createState() => _WebPageState();
}

/// * Android 要設定最小SDK版本 (android/app/build.gradle)
// defaultConfig {
//   minSdkVersion 20
// }

/// * iOS 要設定這個值 (info.plist)
// <key>io.flutter.embedded_views_preview</key>
// <string>YES</string>

// https://chloe-thhsu.medium.com/如何在-flutter-中使用-webview-小女-android-工程師實驗筆記-75969b36abba
class _WebPageState extends State<WebPage> {
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final webView = WebView(
      initialUrl: 'https://www.uniqlo.com/',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (url) {
        WWProgressIndicator.shared.display(context);
      },
      onPageFinished: ((url) {
        WWProgressIndicator.shared.dismiss(context);
      }),
    );

    return webView;
  }
}
