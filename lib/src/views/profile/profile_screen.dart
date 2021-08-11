import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nu_conta_marketplace/src/model/query.dart';
import 'package:nu_conta_marketplace/src/model/result_model.dart';
import 'package:nu_conta_marketplace/src/providers/order.dart';
import 'package:nu_conta_marketplace/src/utils/utils.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrdersProvider orders = Provider.of(context);

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
              // usually buttons at the bottom of the dialog
              new FlatButton(
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

        final totalOrders = orders.items.map((e) => e.total);

        var totalOrderPrice = sumOrderItem(totalOrders);

        double discountOderPrice = 0;

        var currentBalance;

        if (totalOrderPrice > 0) {
          discountOderPrice = resultdata.balance - totalOrderPrice;
          currentBalance = formatCurrency(discountOderPrice.toDouble());
        } else {
          currentBalance = resultdata.balance;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Perfil'),
          ),
          body: Column(
            children: <Widget>[
              Stack(
                overflow: Overflow.visible,
                alignment: Alignment.center,
                children: <Widget>[
                  Image(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 3,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/profile_image.jpg'),
                  ),
                  Positioned(
                    bottom: -60.0,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/jerry_smith.jpg'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              ListTile(
                title: Center(
                  child: Text(
                    resultdata.name.isNotEmpty ? resultdata.name : 'Jerry Smith',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  width: 300,
                  color: Colors.grey,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  resultdata.balance != null && orders.items.length > 0
                                      ? '${currentBalance.toString()}'
                                      : '${formatCurrency(resultdata.balance.toDouble())}',
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.yellow,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Seu Saldo',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
