import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nu_conta_marketplace/src/model/order_model.dart';
import 'package:nu_conta_marketplace/src/utils/utils.dart';

class OrderWidget extends StatefulWidget {
  final OrderModel orderModel;

  OrderWidget(this.orderModel);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('${formatCurrency(widget.orderModel.total)}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data: ${DateFormat('dd/MM/yyyy').format(widget.orderModel.date)}'),
                Text('Hora: ${DateFormat('hh:mm ').format(widget.orderModel.date)}'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: (widget.orderModel.products.length * 150.0) + 1,
              child: ListView(
                children: widget.orderModel.products.map((product) {
                  return Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: FittedBox(
                              child: Image.network(product.image),
                            ),
                          ),
                        ),
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${product.quantity} x ${formatCurrency(product.price.toDouble())}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
