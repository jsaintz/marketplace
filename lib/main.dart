import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nu_conta_marketplace/src/providers/cart.dart';
import 'package:nu_conta_marketplace/src/providers/order.dart';
import 'package:nu_conta_marketplace/src/providers/products.dart';
import 'package:nu_conta_marketplace/src/services/services_client.dart';
import 'package:nu_conta_marketplace/src/utils/app_routes.dart';
import 'package:nu_conta_marketplace/src/views/cart/cart_product_detail.dart';
import 'package:nu_conta_marketplace/src/views/cart/cart_screen.dart';
import 'package:nu_conta_marketplace/src/views/home/home_screen.dart';
import 'package:nu_conta_marketplace/src/views/order/order_screen.dart';
import 'package:nu_conta_marketplace/src/views/products/product_detail_screen.dart';
import 'package:nu_conta_marketplace/src/views/products/product_screen.dart';
import 'package:nu_conta_marketplace/src/views/profile/profile_screen.dart';
import 'package:provider/provider.dart';

void main() {
  ValueNotifier<GraphQLClient> client;
  client = GraphQLService().initClient();
  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  MyApp({Key key, this.client}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => new ProductsProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => new CartProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => new OrdersProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Nu Marketplace',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: HomeScreen(),
          routes: {
            AppRoutes.HOME: (ctx) => HomeScreen(),
            AppRoutes.PRODUCTS: (ctx) => ProdructScreen(),
            AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
            AppRoutes.CART: (ctx) => CartScreen(),
            AppRoutes.ORDERS: (ctx) => OrdersScreen(),
            AppRoutes.PROFILE: (ctx) => ProfileScreen(),
            AppRoutes.CART_PRODUCT_DETAIL: (ctx) => CartProductDetail(),
          },
        ),
      ),
    );
  }
}
