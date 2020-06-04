import 'package:flutter/material.dart';
import '../Providers/productsProvider.dart';
import 'package:provider/provider.dart';
import '../Widgets/userProductItem.dart';
import '../Widgets/drawer.dart';
import './editProductScreen.dart';
class UserProductScreen extends StatelessWidget {
  static const routeName ='/user-products';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.add), 
          onPressed: (){
        Navigator.of(context).pushNamed(EditProductScreen.namedRoute);
          })
        ],
      ),
      body: Padding(padding: EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: productsData.items.length,
        itemBuilder:(ctx,i) =>Column(
          children: <Widget>[
            UserProductItem(productsData.items[i].id, productsData.items[i].title, productsData.items[i].imageUrl),
            Divider(),
          ],
        ),
      ),
      ),
    );
  }
}