import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/cart.dart';
import '../Widgets/cartItem.dart';
import '../Providers/orders.dart';
class CartScreen extends StatelessWidget {
static const routeName = '/cart-page';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: <Widget>[
           Expanded(
                child: ListView.builder(

                  itemBuilder: (ctx, index) =>  CartProduct(
                    cart.items.values.toList()[index].id,
                    cart.items.keys.toList()[index],
                     cart.items.values.toList()[index].price,
                      cart.items.values.toList()[index].title,
                       cart.items.values.toList()[index].quantity),
                  itemCount: cart.items.length,
                ),

           ),
          Card(
             margin: EdgeInsets.all(15),
             child: Padding(padding: EdgeInsets.all(8),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 Text('Total', style: TextStyle(
                   fontSize: 20,
                 ),
                 ),
                 //SizedBox(width: 10,),   //disabled by MainAxisAlignment.spaceBetween
                 Spacer(),
                 Chip(label: Text('\$${cart.totalPrice.toStringAsFixed(2)}',
                 style: TextStyle(color: Theme.of(context).primaryTextTheme.title.color),
                 ),
                 backgroundColor: Theme.of(context).primaryColor,
                 ),
                 FlatButton(onPressed: () {
                   Provider.of<Orders>(context, listen: false,).addOrder(cart.items.values.toList(), cart.totalPrice);
                 }, child: Text('Order Now', style: TextStyle(
                   color: Theme.of(context).primaryColor,
                 ),))
               ],
             ),
             ),
          ),
        ],
      ),
    );
  }
}