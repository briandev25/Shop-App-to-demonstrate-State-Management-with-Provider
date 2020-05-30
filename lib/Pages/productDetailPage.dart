import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/productsProvider.dart';

class ProductDetailPage extends StatelessWidget {
  // final String title;
  // final String id;
  // ProductDetailPage(this.id,this.title);

  static const detailPage ='/Product-detail';
  @override
  Widget build(BuildContext context) {
   final productId = ModalRoute.of(context).settings.arguments as String;
    final selectedProduct = Provider.of<Products>(
      context,
      listen: false,
      ).items.firstWhere((product) => product.id == productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedProduct.title),
      ),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedProduct.imageUrl,
                fit: BoxFit.cover,
                ),
            ),
            SizedBox(height:10),
            Text('\$${selectedProduct.price}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
            ),
            SizedBox(height:10),
            Container(
              width:double.infinity,
              padding: EdgeInsets.symmetric(
               horizontal: 10, 
              ),
              child: Text(selectedProduct.description,
              textAlign: TextAlign.center,
              softWrap: true,
              ),
            ),

          ],
        ),
      ),
    );
  }
}