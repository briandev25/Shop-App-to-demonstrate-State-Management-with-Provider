 import 'package:flutter/material.dart';
 //import '../Models/product.dart';
 import 'package:provider/provider.dart';
 import '../Providers/productsProvider.dart';
 import '../Widgets/badge.dart';
 import '../Providers/cart.dart';
 import '../Widgets/productsGrid.dart';
 import './cartScreen.dart';
 import '../Widgets/drawer.dart';
 //import '../Providers/productsProvider.dart';

enum FilterOptions{
  Favorites,
  All
}
 class ProductsOverview extends StatefulWidget {

  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  var _isLoading = false;
  var _isInit = true;
  // @override
  // void initState() {
  //  // Provider.of<Products>(context).fetchAndSetProducts(); 
  //  //          WONT WORK UNLESS LISTEN SET TO FALSE

  //  Future.delayed(Duration.zero).then((_){
  //   Provider.of<Products>(context).fetchAndSetProducts(); 
  //  });
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    if(_isInit){
     setState(() {
       _isLoading = true;
          }
       );
       Provider.of<Products>(context).fetchAndSetProducts().then((_){
          setState(() {
            _isLoading = false;
          });
      });
    } 
         
   _isInit = false;

    super.didChangeDependencies();
  }
  
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
          body:_isLoading ? Center(
             child: CircularProgressIndicator(),
          ) : ProductGrid(),
     );
   }
}

