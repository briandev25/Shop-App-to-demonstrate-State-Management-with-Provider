import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/cart.dart';
import '../Widgets/cartItem.dart';
import '../Providers/orders.dart';
class CartScreen extends StatefulWidget {
static const routeName = '/cart-page';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

 @override
  void initState() {
  Future.delayed(Duration.zero).then((_){
     Provider.of<Orders>(context).fetchandsetOrders();
  });
    super.initState();
  }
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
                 OrderNowButton(cart: cart),
               ],
             ),
             ),
          ),
        ],
      ),
    );
  }
}

class OrderNowButton extends StatefulWidget {
  const OrderNowButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderNowButtonState createState() => _OrderNowButtonState();
}

class _OrderNowButtonState extends State<OrderNowButton> {
  var _isloading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
          child:_isloading ? CircularProgressIndicator() : Text('Order Now'),
      onPressed: (widget.cart.totalPrice <= 0 || _isloading) ? null : () async{
        setState(() {
          _isloading = true;
        });
     await Provider.of<Orders>(context, listen: false,).addOrder(widget.cart.items.values.toList(), widget.cart.totalPrice);
     setState(() {
       _isloading = false;
     });
     widget.cart.clear();
    },
    
    );
  }
}