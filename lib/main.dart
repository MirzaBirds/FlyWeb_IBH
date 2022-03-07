import 'package:doctor_dreams/home.dart';
import 'package:doctor_dreams/screens/Auth/authScreen.dart';
import 'package:doctor_dreams/screens/Auth/login.dart';
import 'package:doctor_dreams/screens/Auth/signup.dart';
import 'package:doctor_dreams/screens/hardware/pairDevice.dart';
import 'package:doctor_dreams/screens/hardware/productList.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  await initHiveForFlutter();

  runApp(MyApp());
  // GraphQLClient getGithubGraphQLClient() {
  //   final Link _link = HttpLink(
  //     'https://binarytraining.myshopify.com/api/2021-10/graphql.json',
  //     defaultHeaders: {
  //       'X-Shopify-Storefront-Access-Token': 'de38d0ce54424b4f952537fe5094c575',
  //     },
  //   );
  //   final AuthLink authLink = AuthLink(
  //     getToken: () async => 'Bearer de38d0ce54424b4f952537fe5094c575',
  //     // OR
  //     // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  //   );

  //   final Link link = authLink.concat(authLink);
  //   return GraphQLClient(
  //     cache: GraphQLCache(),
  //     link: link,
  //   );
  // }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Dreams',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      routes: {
        AuthScreen.id: (context) => AuthScreen(),
        Login.id: (context) => Login(),
        Signup.id: (context) => Signup(),
        Home.id: (context) => Home(),
        PairDevice.id: (context) => PairDevice(),
        productList.id: (context) => productList(),
      },
    );
    // HttpLink httpLink = HttpLink(
    //   'https://binarytraining.myshopify.com/api/2021-10/graphql.json',
    //   defaultHeaders: {
    //     'X-Shopify-Storefront-Access-Token': 'de38d0ce54424b4f952537fe5094c575',
    //   },
    // );

    // final AuthLink authLink = AuthLink(
    //   getToken: () async => 'Bearer de38d0ce54424b4f952537fe5094c575',
    //   // OR
    //   // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    // );

    // final Link link = authLink.concat(httpLink);

    // ValueNotifier<GraphQLClient> client = ValueNotifier(
    //   GraphQLClient(
    //     link: link,
    //     // The default store is the InMemoryStore, which does NOT persist to disk
    //     cache: GraphQLCache(store: HiveStore()),
    //   ),
    // );
    // return GraphQLProvider(
    //   client: client,
    //   child: MaterialApp(
    //     title: 'Doctor Dreams',
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData(
    //       primarySwatch: Colors.blue,
    //     ),
    //     home: PairDevice(),
    //     routes: {
    //       AuthScreen.id: (context) => AuthScreen(),
    //       Login.id: (context) => Login(),
    //       Signup.id: (context) => Signup(),
    //       Home.id: (context) => Home(),
    //       PairDevice.id: (context) => PairDevice(),
    //       productList.id: (context) => productList(),
    //     },
    //   ),
    // );
  }
}
