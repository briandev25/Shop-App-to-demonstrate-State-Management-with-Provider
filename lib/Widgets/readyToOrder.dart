import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import '../Providers/orders.dart';
class OrderProduct extends StatefulWidget {
  final OrderItem order;
  OrderProduct(this.order);

  @override
  _OrderProductState createState() => _OrderProductState();
}

class _OrderProductState extends State<OrderProduct> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(DateFormat('dd MM yyyy hh:mm').format(widget.order.dateTime),
            ),
             trailing: IconButton(icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: (){
                setState(() {
                  _expanded = !_expanded;
                });
             }),
          ),
          if(_expanded) 
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
            height: min(widget.order.cartProducts.length * 20.0 + 10,100),
          child: ListView(
            children: widget.order.cartProducts.map((prod) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Text(prod.title,style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18),
                ),
                Text('${prod.quantity}X \$${prod.price}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey
                ),
                )
            ],
            ),
            ).toList(),
          ),
          ),
        ],),
    );
  }
}