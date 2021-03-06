import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Pages/productDetailPage.dart';
import '../Providers/product.dart';
import '../Providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String imageUrl;
  // final String title;
  // ProductItem({@required this.id,@required this.title, @required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart  = Provider.of<Cart>(context, listen: false);

  
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
          child: GridTile( 
        child: GestureDetector(
          onTap: () {
           Navigator.of(context).pushNamed(ProductDetailPage.detailPage,
           arguments: product.id,
           );
          },
                  child: Image.network(product.imageUrl,
          fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
                  builder: (ctx,product,_) => IconButton(
              icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
               onPressed: product.toggleFavoriteStatus,
               color: Theme.of(context).accentColor,
               ),
          ),
          title: Text(product.title, textAlign:TextAlign.center,),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart), 
            onPressed: (){
            cart.addItem(product.id, product.price, product.title);
            Scaffold.of(context).hideCurrentSnackBar();
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Added Product to cart!'),
                duration: Duration(seconds: 3),
                action: SnackBarAction(label: "Undo", onPressed: (){
                  cart.removeSingleItem(product.id);
                }),
              ),
            );
            },
            color: Theme.of(context).accentColor,
            )
        ),
        ),
    );
  }
}