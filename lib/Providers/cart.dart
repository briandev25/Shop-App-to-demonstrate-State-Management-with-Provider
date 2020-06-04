import 'package:flutter/foundation.dart';
class CartModel{
  final String id;
  final String title;
  final int quantity;
  final double price;
CartModel({
  @required this.id,
   @required this.title,
   @required this.price,
   @required this.quantity
});
}
class Cart with ChangeNotifier{
Map<String, CartModel> _items ={};

Map<String, CartModel> get items{
  return {..._items};
}

int get showValue{
  return  _items.length;
}

double get totalPrice{
  var total = 0.0;
    _items.forEach((key, cardItem){
      total += cardItem.price * cardItem.quantity;
    });

   return total;
}
void addItem(String productId,double price,String title) {
  if(_items.containsKey(productId)){
   _items.update(productId, (existingItem)=> CartModel(
    id: existingItem.id,
    title: existingItem.title,
    price: existingItem.price,
    quantity: existingItem.quantity + 1));
  }else{
    _items.putIfAbsent(productId, () => CartModel(
      id: DateTime.now().toString(),
      price: price,
      title:title,
      quantity: 1,   
    )
    );
  }

  notifyListeners();
}
void removeSingleItem(String productId){
  if(!_items.containsKey(productId)){
    return;
  }
  if(_items[productId].quantity >1){
    _items.update(productId, (existingItem)=> CartModel(
    id: existingItem.id,
    title: existingItem.title,
    price: existingItem.price,
    quantity: existingItem.quantity - 1));
  }
  else{
    _items.remove(productId);
  }
  notifyListeners();
}

void removeItem(String productId){
  _items.remove(productId);
  notifyListeners();
}
void clear() {
  _items = {};
  notifyListeners();
}
}