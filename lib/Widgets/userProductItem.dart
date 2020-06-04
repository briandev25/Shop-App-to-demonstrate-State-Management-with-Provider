import 'package:flutter/material.dart';
import '../Pages/editProductScreen.dart';
import 'package:provider/provider.dart';
import '../Providers/productsProvider.dart';
class UserProductItem extends StatelessWidget {
  final String title;
  final String id;
  final String imageUrl;
  UserProductItem(this.id,this.title,this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.edit),
              color:Theme.of(context).primaryColor ,
              onPressed: (){
                Navigator.of(context).pushNamed(EditProductScreen.namedRoute,
                arguments: id,
                );
              },
              ),
              IconButton(icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: (){
                Provider.of<Products>(context, listen: false).deleteItem(id);
              },
              )
            ],
          ),
        ),
      
    );
  }
}