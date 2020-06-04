import 'package:flutter/material.dart';
import '../Pages/ordersScreen.dart';
import '../Pages/userProductScreen.dart';
class MainDrawer extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Welcome Customer'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop,),
            title: Text('Shop'),
            onTap:() {
              Navigator.of(context).pushNamed('/');
              },
          ),
          Divider(),
            ListTile(
            leading: Icon(Icons.payment,),
            title: Text('Order'),
            onTap:() {
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
              },
          ),
           Divider(),
            ListTile(
            leading: Icon(Icons.edit,),
            title: Text('Manage Products'),
            onTap:() {
              Navigator.of(context).pushNamed(UserProductScreen.routeName);
              },
          ),
        ],
      ),
    );
  }
}