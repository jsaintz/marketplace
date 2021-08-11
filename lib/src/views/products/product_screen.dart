import 'package:flutter/material.dart';
import 'package:nu_conta_marketplace/src/model/result_model.dart';
import 'package:nu_conta_marketplace/src/views/products/product_grid.dart';

//ignore: must_be_immutable
class ProdructScreen extends StatelessWidget {
  ResultModel resultModel;
  ProdructScreen({Key key, this.resultModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductGrid(resultModel);
  }
}
