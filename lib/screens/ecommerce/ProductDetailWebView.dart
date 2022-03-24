import 'dart:async';

import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/screens/hardware/productList.dart';
import 'package:doctor_dreams/widgets/appBar.dart';
import 'package:doctor_dreams/widgets/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductDetailWebView extends StatefulWidget {
  final String handle;
  // final String maxPrice;
  const ProductDetailWebView({Key? key, @required this.handle = ''})
      : super(key: key);

  @override
  _ProductDetailWebViewState createState() => _ProductDetailWebViewState();
}

class _ProductDetailWebViewState extends State<ProductDetailWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  late WebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppPrimaryBar(),
        // extendBodyBehindAppBar: true,
        body: Builder(builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: WebView(
              initialUrl: "https://doctordreams.com/products/${widget.handle}",
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _webViewController = webViewController;
                _controller.complete(webViewController);
              },
              onProgress: (int progress) {
                print("WebView is loading (progress : $progress%)");
              },
              // javascriptChannels: <JavascriptChannel>{
              //   _toasterJavascriptChannel(context),
              // },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  print('blocking navigation to $request}');
                  return NavigationDecision.prevent;
                }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');

                _webViewController
                    .evaluateJavascript("javascript:(function() { " +
                        "var head = document.getElementsByTagName('header')[0];" +
                        "head.parentNode.removeChild(head);" +
                        "var footer = document.getElementsByTagName('footer')[0];" +
                        "footer.parentNode.removeChild(footer);" +
                        "})()")
                    .then((value) =>
                        debugPrint('Page finished loading Javascript'))
                    .catchError((onError) => debugPrint('$onError'));
              },
              gestureNavigationEnabled: true,
            ),
          );
        }),
        bottomNavigationBar: BottomNavBar());
  }
}
