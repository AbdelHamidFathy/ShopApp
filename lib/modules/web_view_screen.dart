import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String url;
   WebViewScreen(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: back(context),
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}