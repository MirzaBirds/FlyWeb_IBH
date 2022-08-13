import 'package:doctor_dreams/config/appColors.dart';
import 'package:doctor_dreams/screens/hardware/productList.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final String image;
  final String title;
  final String minPrice;
  // final String maxPrice;
  const ProductDetail(
      {Key? key,
      @required this.image = '',
      @required this.title = '',
      @required this.minPrice = ''})
      : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          // color:AppColors.primary,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(Icons.favorite_outline_outlined),
            //   color: AppColors.primary,
            //   tooltip: 'Comment Icon',
            //   onPressed: () {},
            // ), //IconButton
          ], //<Widget>[]
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Container(
            color: AppColors.grey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.network(
                    widget.image,
                    height: 428,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                      child: Column(
                        children: [
                          Text(
                            "${widget.title}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                fontSize: 22.00),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "This metal bed is stylish enough to take centerstage, and understated enough to fit in a corner.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                fontSize: 15.00),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Rs. ${widget.minPrice}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                  fontSize: 28.00),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Inclusive of all taxes",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: AppColors.primary,
                                  fontSize: 18.00),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomScrollView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            slivers: <Widget>[
                              SliverPadding(
                                padding: const EdgeInsets.all(7),
                                sliver: SliverGrid.count(
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 4,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                          (MediaQuery.of(context).size.height /
                                              2.3),
                                  children: <Widget>[
                                    Container(
                                      child: Card(
                                        color: AppColors.secondary,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 3, right: 3, top: 12),
                                          child: Column(
                                            children: [
                                              Icon(Icons.bed_outlined,
                                                  color: AppColors.white),
                                              Text(
                                                "198 X 182 CM",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.white,
                                                    fontSize: 8.00),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Card(
                                        color: AppColors.secondary,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 4, right: 4, top: 12),
                                          child: Column(
                                            children: [
                                              Icon(Icons.bed_outlined,
                                                  color: AppColors.white),
                                              Text(
                                                "198 X 182 CM",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.white,
                                                    fontSize: 8.00),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Card(
                                        color: AppColors.secondary,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 4, right: 4, top: 12),
                                          child: Column(
                                            children: [
                                              Icon(Icons.bed_outlined,
                                                  color: AppColors.white),
                                              Text(
                                                "198 X 182 CM",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.white,
                                                    fontSize: 8.00),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Card(
                                        color: AppColors.secondary,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 4, right: 4, top: 12),
                                          child: Column(
                                            children: [
                                              Icon(Icons.bed_outlined,
                                                  color: AppColors.white),
                                              Text(
                                                "198 X 182 CM",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.white,
                                                    fontSize: 8.00),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height,
                    // alignment: FractionalOffset.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: TextButton(
                              onPressed: () {},
                              child: new Text('Add to cart',
                                  style:
                                      new TextStyle(color: Color(0xFF2E3233))),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: GestureDetector(
                              onTap: () {
                                print("button press");

                                // Navigator.push(
                                //     context, MaterialPageRoute(builder: (context) => Home()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(vertical: 13),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(100),
                                    ),
                                    color: AppColors.primary),
                                child: Text(
                                  'Buy Now',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
          ),
        ));
  }
}
