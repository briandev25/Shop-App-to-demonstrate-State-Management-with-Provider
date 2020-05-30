import 'package:flutter/material.dart';
import '../Widgets/productItem.dart';
import '../Providers/productsProvider.dart';
import 'package:provider/provider.dart';
class ProductGrid extends StatelessWidget {
  // const ProductGrid({
  //   Key key,
  //   @required this.loadedProducts,
  // }) : super(key: key);

  // final List<Product> loadedProducts;

  @override
  Widget build(BuildContext context) {
   final productsData = Provider.of<Products>(context);
   final products = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,

        ),
       itemBuilder: (ctx,index) => ChangeNotifierProvider.value(
                value:products[index],
                child: ProductItem(
          //  id: products[index].id, 
          //  title: products[index].title,
          //   imageUrl: products[index].imageUrl),
          ),
       ),
       );
  }
}