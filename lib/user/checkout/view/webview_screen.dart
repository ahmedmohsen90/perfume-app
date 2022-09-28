import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:perfume/core/helper/navigator.dart';
import 'package:perfume/user/checkout/view/payment_success_screen.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    super.key,
    required this.url,
  });
  final String url;
  static const routeName = '/webview-screen';

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? webViewController;
  bool isInit = true;
  @override
  void initState() {
    if (Platform.isAndroid) {
      // WebView.platform = AndroidWebView();
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      // webViewController?.loadUrl('https://flutter.dev');
      // webViewController?.loadUrl('https://www.google.com/');
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // webViewController?.reload();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          color: Colors.black,
          onPressed: () {
            NavigationService.goBack();
          },
        ),
      ),
      body: InAppWebView(
        onLoadStop: (controller, url) async {
          log('your url $url');
          var jsonData = await webViewController?.evaluateJavascript(
              source:
                  "window.document.getElementsByTagName('html')[0].outerHTML;");
          log('jsonData ${jsonData.runtimeType}');
          if (jsonData == null) {
            return;
          }
          if ((url.toString().contains('payment/callback/success') ||
                  url.toString().contains('payment/callback/faild')) &&
              (jsonData.toString().contains('true') ||
                  jsonData.toString().contains('false'))) {
            if (url.toString().contains('payment/callback/faild')) {
              await NavigationService.goBack();
            }
            NavigationService.push(
                page: PaymentSuccessScreen.routeName,
                arguments: {
                  'success': jsonData.toString().contains('true'),
                });
          }
        },
        // zoomEnabled: true,
        // key: UniqueKey(),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
        // onPageStarted: (startLink) {
        //   log('startLink $startLink');
        // },
        // onProgress: (progress) {
        //   log('progress $progress%');
        // },
        // onPageFinished: (linkFinish) {
        //   log('link $linkFinish');
        // },
      ),
    );
  }
}
