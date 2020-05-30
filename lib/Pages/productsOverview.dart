 import 'package:flutter/material.dart';
 //import '../Models/product.dart';
 import 'package:provider/provider.dart';
 import '../Providers/productsProvider.dart';
 import '../Widgets/badge.dart';
 import '../Providers/cart.dart';
 import '../Widgets/productsGrid.dart';
 import './cartScreen.dart';
 import '../Widgets/drawer.dart';
enum FilterOptions{
  Favorites,
  All
}
 class ProductsOverview extends StatelessWidget {

   @override
   Widget build(BuildContext context) {
     final productsChoice = Provider.of<Products>(context);
     return Scaffold(
          appBar: AppBar(
            title: Text("Shopping Products"),
            actions: <Widget>[
              Consumer<Cart>(builder: (ctx,cart,pick) =>Badge(
                child: pick,
                   value: cart.showValue.toString(),
                   ),
                   child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  ),
              ) ,
              PopupMenuButton(
                icon: Icon(Icons.more_vert),
                itemBuilder: (_) =>[
                PopupMenuItem(child: Text("Only Favorites"),
                               value: FilterOptions.Favorites,
                 ),
                 PopupMenuItem(child: Text("Show All"),
                                value: FilterOptions.All, ),   
              ],
              onSelected: (FilterOptions selectedValue){
                // print(selectedValue);
                if(selectedValue == FilterOptions.Favorites){
                  productsChoice.showFavorites();  
                }else{
                  productsChoice.showAll();
                }
              },
              ),
               
            ],
          ),
          drawer:MainDrawer(),
          body: ProductGrid(),
     );
   }
 }

