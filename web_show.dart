import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewSecreen extends StatelessWidget {
  final String url;
  WebViewSecreen(this.url);
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,

    );
  }
}
