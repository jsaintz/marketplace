import 'package:flutter/material.dart';
import 'package:nu_conta_marketplace/src/model/result_model.dart';
import 'package:nu_conta_marketplace/src/providers/products.dart';
import 'package:nu_conta_marketplace/src/views/products/product_grid_item.dart';
import 'package:provider/provider.dart';

//ignore: must_be_immutable
class ProductGrid extends StatelessWidget {
  ResultModel productList;
  ProductGrid(this.productList);

  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsProvider = Provider.of<ProductsProvider>(context);
    productsProvider.items = productList.offers;

    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: productsProvider.items.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: productsProvider.items[index],
        child: ProductGridItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
      ),
    );
  }
}
