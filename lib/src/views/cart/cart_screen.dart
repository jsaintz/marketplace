import 'package:flutter/material.dart';
import 'package:nu_conta_marketplace/src/providers/cart.dart';
import 'package:nu_conta_marketplace/src/providers/order.dart';
import 'package:nu_conta_marketplace/src/utils/app_routes.dart';
import 'package:nu_conta_marketplace/src/utils/utils.dart';
import 'package:nu_conta_marketplace/src/widgets/cart_item_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final CartProvider cart = Provider.of(context);
    final OrdersProvider orders = Provider.of(context);
    final cartItems = cart.items.values.toList();

    double userBalance = 1000000;

    final totalOrders = orders.items.map((e) => e.total);

    var totalOrderPrice = sumOrderItem(totalOrders);

    double discountOderPrice = 0;

    var currentBalance;

    if (totalOrderPrice > 0) {
      discountOderPrice = userBalance - totalOrderPrice;
      currentBalance = discountOderPrice.toDouble();
    } else {
      currentBalance = userBalance;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: cartItems.isEmpty
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
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.itemsCount,
                    itemBuilder: (ctx, index) => CartItemWidget(cartItems[index]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "TOTAL",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('${formatCurrency(cart.totalAmount)}',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20, top: 50, bottom: 50),
                  child: ButtonTheme(
                    buttonColor: Theme.of(context).primaryColor,
                    minWidth: double.infinity,
                    height: 40.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (currentBalance < cart.totalAmount) {
                          return showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text("Atenção"),
                              content: Text(
                                  "Saldo Insuficiente, faça uma recarga para obter mais produtos :D \n\n Saldo Atual: ${formatCurrency(currentBalance)}"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    // Navigator.pushNamed(context, AppRoutes.HOME);
                                  },
                                )
                              ],
                            ),
                          );
                        } else {
                          Provider.of<OrdersProvider>(context, listen: false).addOrder(cart);
                          return showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text("Sucesso"),
                              content: Text("Compra efetuada com sucesso!!!"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushNamed(context, AppRoutes.HOME);
                                    cart.clear();
                                  },
                                )
                              ],
                            ),
                          );
                        }
                      },
                      child: Text(
                        "COMPRAR",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
