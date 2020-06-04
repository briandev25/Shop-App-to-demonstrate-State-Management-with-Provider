import 'package:flutter/material.dart';
import './Pages/productsOverview.dart';
import './Pages/productDetailPage.dart';
import 'package:provider/provider.dart';
import './Providers/productsProvider.dart';
import './Providers/cart.dart';
import './Pages/cartScreen.dart';
import './Providers/orders.dart';
import './Pages/ordersScreen.dart';
import './Pages/userProductScreen.dart';
import './Pages/editProductScreen.dart';
 
 void main() =>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          ChangeNotifierProvider(
            create: (ctx) => Products(),
          ),
          ChangeNotifierProvider(
            create: (ctx) =>Cart(),
            ),
          ChangeNotifierProvider(
            create: (ctx) => Orders(),
            )
         ],
          
         child: MaterialApp(
          title: "My Shopping App",
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
          ),
          home: ProductsOverview(),
          routes: {
            ProductDetailPage.detailPage: (ctx) => ProductDetailPage(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductScreen.routeName : (ctx) => UserProductScreen(),
            EditProductScreen.namedRoute : (ctx) => EditProductScreen(),
          },
        ),
    );
  }
}

