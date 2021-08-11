import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nu_conta_marketplace/src/model/query.dart';
import 'package:nu_conta_marketplace/src/model/result_model.dart';
import 'package:nu_conta_marketplace/src/providers/cart.dart';
import 'package:nu_conta_marketplace/src/utils/app_routes.dart';
import 'package:nu_conta_marketplace/src/views/products/product_screen.dart';
import 'package:nu_conta_marketplace/src/widgets/badge.dart';
import 'package:nu_conta_marketplace/src/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ResultModel resultModel;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(query)),
      builder: (
        QueryResult result, {
        VoidCallback refetch,
        FetchMore fetchMore,
      }) {
        if (result.hasException) {
          return AlertDialog(
            title: new Text("Erro"),
            content: Text(
                'Opss algo deu errado por favor tente  novamente, caso o erro persista entre em contato com o Suporte.'),
            actions: [
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }

        if (result.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final resultdata = ResultModel.fromJson(result.data['viewer']);

        return Scaffold(
          appBar: AppBar(
            title: Text('Bem Vindo'),
          ),
          body: ProdructScreen(resultModel: resultdata),
          drawer: CustomDrawer(),
          floatingActionButton: Consumer<CartProvider>(
            child: FloatingActionButton(
              child: Icon(Icons.shopping_cart),
              backgroundColor: Colors.green,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CART);
              },
            ),
            builder: (ctx, cart, child) => Badge(
              value: cart.itemsCount.toString(),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
