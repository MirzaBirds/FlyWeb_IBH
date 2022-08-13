import 'dart:async';

import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/widgets/appBar.dart';
import 'package:doctor_dreams/widgets/bottomNav.dart';
import 'package:doctor_dreams/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExperienceCenter extends StatefulWidget {
  const ExperienceCenter({Key? key}) : super(key: key);

  @override
  _ExperienceCenterState createState() => _ExperienceCenterState();
}

class _ExperienceCenterState extends State<ExperienceCenter> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool showSpinner = true;
  late WebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppPrimaryBar(isSleetBelt: true),
        drawer: AppDrawer(),
        // body: Container(child: myLayoutWidget(context)),
        body: Builder(builder: (BuildContext context) {
          return ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: WebView(
              initialUrl: 'https://doctordreams.com/pages/snooze-zone',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _webViewController = webViewController;
                _controller.complete(webViewController);
              },
              onProgress: (int progress) {
                // print("WebView is loading (progress : $progress%)");
              },
              // javascriptChannels: <JavascriptChannel>{
              //   _toasterJavascriptChannel(context),
              // },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  // print('blocking navigation to $request}');
                  return NavigationDecision.prevent;
                }
                // print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                // print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                // print('Page finished loading: $url');

                setState(() {
                  showSpinner = false;
                  _webViewController
                      .runJavascript("javascript:(function() { " +
                          "var head = document.getElementsByTagName('header')[0];" +
                          "head.parentNode.removeChild(head);" +
                          "var footer = document.getElementsByTagName('footer')[0];" +
                          "footer.parentNode.removeChild(footer);" +
                          "document.getElementsById('kiwi-big-iframe-wrapper').style.display = 'none';" +
                          "document.getElementsByClassName('haptikchaticon').style.display = 'none';" +
                          "})()")
                      .then((value) =>
                          debugPrint('Page finished loading Javascript'))
                      .catchError((onError) => debugPrint('$onError'));
                });
              },
              gestureNavigationEnabled: true,
            ),
          );
        }),
        bottomNavigationBar: BottomNavBar());
  }
}
