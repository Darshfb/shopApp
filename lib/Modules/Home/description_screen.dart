import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_win/Modules/Widgets/custom_text.dart';

class DescriptionScreen extends StatelessWidget {
  String? image;
  dynamic price;
  dynamic discount;
  dynamic old_price;
  String? description;

  DescriptionScreen({
    this.image,
    this.price,
    this.discount,
    this.old_price,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25.0),
                    bottomLeft: Radius.circular(25.0),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(image!),
                  )),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              CustomText(
                text: price.toString(),
              ),
              Column(
                children: [
                  CustomText(
                    text: 'discount',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  CustomText(
                    text: discount.toString(),
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ],
              ),
              CustomText(
                text: old_price.toString(),
                textDecoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.red,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border, color: Colors.red)),
              ],
            ),
            Card(
              elevation: 3.0,
              color: Colors.blueGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: description!,
                  textAlign: TextAlign.right,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
