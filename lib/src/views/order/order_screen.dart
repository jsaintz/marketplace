import 'package:flutter/material.dart';
import 'package:nu_conta_marketplace/src/providers/order.dart';
import 'package:nu_conta_marketplace/src/widgets/custom_drawer.dart';
import 'package:nu_conta_marketplace/src/widgets/order_widget.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrdersProvider orders = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus pedidos'),
      ),
      drawer: CustomDrawer(),
      body: orders.items.isEmpty
          ? ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                  child: Container(
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Theme.of(context).accentColor,
                      size: 200,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Voce não possui nenhuma compra.',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: orders.itemsCount,
              itemBuilder: (ctx, index) => OrderWidget(orders.items[index]),
            ),
    );
  }
}
