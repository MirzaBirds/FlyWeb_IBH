import 'dart:convert';

import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/config/graphql.dart';
import 'package:doctor_dreams/model/productsList.dart';
import 'package:doctor_dreams/screens/ecommerce/ProductDetail.dart';
import 'package:doctor_dreams/screens/ecommerce/ProductDetailWebView.dart';
import 'package:doctor_dreams/screens/hardware/productList.dart';
import 'package:doctor_dreams/services/shopify/products.dart';
import 'package:doctor_dreams/widgets/appBar.dart';
import 'package:doctor_dreams/widgets/bottomNav.dart';
import 'package:doctor_dreams/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProductList extends StatefulWidget {
  final String categoryType;
  const ProductList({Key? key, @required this.categoryType = ''})
      : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  var productListData1 = [
    {
      "title": "Hybrid Pocket Spring Mattress",
      "amount": "7199.0",
      "amount1": "13599.0",
      "image":
          "https://cdn.shopify.com/s/files/1/0115/7169/1584/products/springmattress_scene_45.jpg?v=1637905684",
    },
    {
      "title": "Hybrid Pocket Spring Mattress",
      "amount": "7199.0",
      "amount1": "13599.0",
      "image":
          "https://cdn.shopify.com/s/files/1/0115/7169/1584/products/springmattress_scene_45.jpg?v=1637905684",
    },
    {
      "title": "Hybrid Pocket Spring Mattress",
      "amount": "7199.0",
      "amount1": "13599.0",
      "image":
          "https://cdn.shopify.com/s/files/1/0115/7169/1584/products/springmattress_scene_45.jpg?v=1637905684",
    }
  ];
  var productListData;

  final GraphQLClient _client = getGraphQLClient();
  var productListModels = ProductListModels();
  String categoryName = '';

  void initState() {
    // getActivity();
    getEvents();
    super.initState();
  }

  Future<void> getEvents() async {
    if (widget.categoryType == "matters") {
      categoryName = Products.getMattress;
    } else if (widget.categoryType == "bed-online") {
      categoryName = Products.getBeds;
    } else if (widget.categoryType == "pillows") {
      categoryName = Products.getPillows;
    } else if (widget.categoryType == "duvets-quilts") {
      categoryName = Products.getBedding;
    } else if (widget.categoryType == "sleep-essentials") {
      categoryName = Products.getEssentials;
    }
    final QueryOptions getProductList =
        QueryOptions(document: gql(categoryName));
    // Execute query
    final QueryResult productList = await _client.query(getProductList);
    // print("++++++++ProductList++++++++");
    // print(productList);
    if (productList.hasException) {
      print(productList.exception.toString());
    }

    if (productList.data != null) {
      print((productList.data?['products']['edges'][0]['node']));

      // setState(() {
      //   productListData = productList.data!['products']['edges'];
      // });

      setState(() {
        productList.data!['products']['edges'].forEach((x) {
          productListModels.addToList(ProductListModel(
              id: x['node']['id'],
              title: x['node']['title'],
              handle: x['node']['handle'],
              minPrice: x['node']['priceRange']['minVariantPrice']['amount'],
              maxPrice: x['node']['priceRange']['maxVariantPrice']['amount'],
              image: x['node']['images']['edges'][0]['node']
                  ['transformedSrc']));
        });
      });
      print("product list model");
      print(productListModels.list[0].title);
      print(productListModels.list[0].handle);

      // print("Products++++++++++++++");
      // print(productListData.runtimeType);
      // print(productListData.length);
      // print(productListData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppPrimaryBar(),
      drawer: AppDrawer(),
      body: productListView(context),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  SingleChildScrollView productListView(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  // itemCount: productListData.length,
                  itemCount: productListModels.list.length,
                  // padding: EdgeInsets.all(5.0),
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "${productListModels.list[i].title}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primary,
                                          fontSize: 15.00),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          // "${productListData[i]['priceRange']['minVariantPrice']['amount']}",
                                          "${productListModels.list[i].minPrice}",
                                          // "${1}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.primary,
                                              fontSize: 12.00),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          // "${productListData1[i]['amount']}",
                                          "${productListModels.list[i].maxPrice}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.primary,
                                              fontSize: 12.00),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: ButtonTheme(
                                        height: 20.0,
                                        child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                                color: AppColors.primary,
                                                width: 0.5),
                                          ),
                                          child: Text('Shop Now',
                                              style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.w300)),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetailWebView(
                                                          handle:
                                                              productListModels
                                                                  .list[i]
                                                                  .handle,
                                                        )));
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Image.network(
                                "${productListModels.list[i].image}",
                                fit: BoxFit.fill,
                                width: 150,
                                height: 120,
                              ),
                            ),
                          ]),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
