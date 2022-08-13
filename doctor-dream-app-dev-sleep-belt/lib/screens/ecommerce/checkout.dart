import 'dart:async';

import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/widgets/appBar.dart';
import 'package:doctor_dreams/widgets/bottomNav.dart';
import 'package:doctor_dreams/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  late WebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          elevation: 50.0,
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: AppColors.white),
          title: Image.asset('assets/logo.png', height: 17.00),
          actions: <Widget>[], //<Widget>[]
        ),
        // drawer: AppDrawer(),
        body: Builder(builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: WebView(
              initialUrl: "https://doctordreams.com/cart",
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
                        "var head = document.getElementsByClassName('header-mb-left')[0];" +
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

// Widget myLayoutWidget(BuildContext context) {
//   return Column(
//     children: [
//       Align(
//         alignment: Alignment.topLeft,
//         child: Padding(
//           padding:
//               const EdgeInsets.only(left: 30, top: 130, right: 0, bottom: 0),
//           child: Text(
//             "Checkout",
//             style: TextStyle(
//                 fontSize: 40,
//                 color: AppColors.white,
//                 fontWeight: FontWeight.w400),
//           ),
//         ),
//       ),
//     ],
//   );
