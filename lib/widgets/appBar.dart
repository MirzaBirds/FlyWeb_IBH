import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/screens/ecommerce/checkout.dart';
import 'package:doctor_dreams/screens/ecommerce/wishlist.dart';
import 'package:flutter/material.dart';

class AppPrimaryBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isSleetBelt;

  AppPrimaryBar({Key? key, required this.isSleetBelt}) : super(key: key);

  @override
  _AppPrimaryBarState createState() => _AppPrimaryBarState();

  @override
  // TODO: implement preferredSize
  // Size get preferredSize => throw UnimplementedError();
  Size get preferredSize => const Size.fromHeight(55);
}

class _AppPrimaryBarState extends State<AppPrimaryBar> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isSleetBelt,
      child: AppBar(
        iconTheme: IconThemeData(color: AppColors.primary),
        title: Image.asset('assets/logo.png', height: 17.00),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.search),
          //   color: AppColors.primary,
          //   tooltip: 'Search',
          //   onPressed: () {
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute<void>(
          //         builder: (BuildContext context) => const Wishlist(),
          //       ),
          //     );
          //   },
          // ),
          // IconButton(
          //   icon: Icon(Icons.favorite_outline_outlined),
          //   color: AppColors.primary,
          //   tooltip: 'Comment Icon',
          //   onPressed: () {
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute<void>(
          //         builder: (BuildContext context) => const Wishlist(),
          //       ),
          //     );
          //   },
          // ), //IconButton
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            color: AppColors.primary,
            tooltip: 'Setting Icon',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const Checkout(),
                ),
              );
            },
          ), //IconButton
        ], //<Widget>[]
        backgroundColor: Colors.white,
        elevation: 50.0,
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   tooltip: 'Menu Icon',
        //   onPressed: () {},
        // ), //IconButton
        brightness: Brightness.dark,
      ),
    );
  }
}
