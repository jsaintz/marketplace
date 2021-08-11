import 'package:flutter/material.dart';
import 'package:nu_conta_marketplace/src/model/cart_item_model.dart';
import 'package:nu_conta_marketplace/src/utils/utils.dart';

class CartProductDetail extends StatelessWidget {
  const CartProductDetail({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    CartItemModel productDetail = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(productDetail.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                productDetail.image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${formatCurrency(productDetail.price.toDouble())}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                productDetail.description,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
