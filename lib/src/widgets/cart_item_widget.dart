import 'package:flutter/material.dart';
import 'package:nu_conta_marketplace/src/model/cart_item_model.dart';
import 'package:nu_conta_marketplace/src/providers/cart.dart';
import 'package:nu_conta_marketplace/src/utils/app_routes.dart';
import 'package:nu_conta_marketplace/src/utils/utils.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatefulWidget {
  final CartItemModel cartItem;
  CartItemWidget(this.cartItem);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  CartProvider cartProver;

  @override
  void initState() {
    cartProver = Provider.of<CartProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.cartItem.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Tem certeza?'),
            content: Text('Quer remover o item do carrinho?'),
            actions: [
              FlatButton(
                child: Text('Não'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text('Sim'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {
        cartProver.removeItem(widget.cartItem.productId);
      },
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.CART_PRODUCT_DETAIL,
            arguments: widget.cartItem,
          );
        },
        child: Card(
          margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 6,
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              title: Text(widget.cartItem.name),
              leading: Padding(
                padding: const EdgeInsets.all(5),
                child: CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.network(widget.cartItem.image),
                  ),
                ),
              ),
              subtitle: Text('Total: ${formatCurrency(widget.cartItem.price.toDouble()) * widget.cartItem.quantity}'),
              trailing: Text('${widget.cartItem.quantity}x'),
            ),
          ),
        ),
      ),
    );
  }
}
