import 'package:flutter/material.dart';
import 'package:nu_conta_marketplace/src/utils/app_routes.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.home, color: Theme.of(context).accentColor),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.HOME);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.person, color: Theme.of(context).accentColor),
                  title: Text('Perfil'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.PROFILE);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.payment, color: Theme.of(context).accentColor),
                  title: Text('Pedidos'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.shopping_cart, color: Theme.of(context).accentColor),
                  title: Text('Meu Carrinho'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/cart');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
