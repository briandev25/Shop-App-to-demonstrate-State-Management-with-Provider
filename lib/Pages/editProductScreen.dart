import 'package:flutter/material.dart';
import '../Providers/product.dart';
import 'package:provider/provider.dart';
import '../Providers/productsProvider.dart';


class EditProductScreen extends StatefulWidget {
  static  const  namedRoute = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
 final _priceFocusNode = FocusNode();
 final _descriptionFocusNode = FocusNode();
 final _imageUrlFocusNode = FocusNode();
 final _imageUrlController = TextEditingController();
 final _form =GlobalKey<FormState>();
 var _editProduct =Product(
   id: null, title: '', description: '',imageUrl: '', price: 0, 
 );
// var _isInit = true;

@override
  void initState() {
    _imageUrlController.addListener(_updateImageUrl);
    super.initState();
  }
  //  @override
  // // void didChangeDependencies() {
  // //  if(_isInit){
  // //  //  final productId = ModalRoute.of(context).settings.arguments as String;
  // //    Provider.of<Products>(context)
  // //  }
  //  _isInit = false;
  //   super.didChangeDependencies();
  // }

  void _updateImageUrl(){
   if(!_imageUrlFocusNode.hasFocus){
     setState(() {
       
     });
   }
  }
 @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }
  void _saveForm() {
    final isValidated = _form.currentState.validate();
    if(!isValidated){
      return;
    }
    _form.currentState.save();
    Provider.of<Products>(context, listen: false).addProduct(_editProduct);
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:const Text('Edit Product'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm,),
        ],
      ),
      body: Padding(padding: EdgeInsets.all(16),
      child: Form(
        child: ListView(
               children: <Widget>[
                    TextFormField(
                    decoration:const InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                     onFieldSubmitted: (value){
                       FocusScope.of(context).requestFocus(_priceFocusNode);
                     },
                      onSaved: (value){
                       _editProduct = Product(
                        title: value,
                        description: _editProduct.description,
                        id: null,
                        imageUrl: _editProduct.imageUrl,
                        price: _editProduct.price,
                      );
                   },
                     validator: (value){
                      if(value.isEmpty){
                        return 'Please enter the title';
                      }
                      return null;
                    },
                    ),
                            TextFormField(
                     decoration: InputDecoration(labelText: 'Price'),
                     textInputAction: TextInputAction.next,
                     keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                     onFieldSubmitted: (_){
                       FocusScope.of(context).requestFocus(_descriptionFocusNode);
                     },
                       onSaved: (value){
                       _editProduct = Product(
                         title: _editProduct.title,
                         description: _editProduct.description,
                         id: null,
                         imageUrl: _editProduct.imageUrl,
                         price: double.parse(value),
                       );
                     },
                      validator: (value){
                       if(value.isEmpty){
                         return 'Please enter the Price';
                       }
                       if(double.tryParse(value) == null){
                         return 'Please enter a Valid Number!';
                       }
                       if(double.parse(value) <= 0){
                         return 'Price cannot be less than zero!';
                       }
                       return null;
                     },
                   ),
                        TextFormField(
                     decoration:const InputDecoration(labelText: 'Description'),
                     maxLines: 3,
                     keyboardType: TextInputType.multiline,
                     focusNode: _descriptionFocusNode,
                     onFieldSubmitted: (_) {
                       _saveForm();
                     },
                       onSaved: (value){
                      _editProduct = Product(
                         title: _editProduct.title,
                         description: value,
                         id: null,
                         imageUrl: _editProduct.imageUrl,
                         price: _editProduct.price,
                       );
                     },
                      validator: (value){
                      if(value.isEmpty){
                         return 'Please enter the Description';
                       }
                       if(value.length < 10){
                         return 'Should be at least 10 characters long';
                       }
                       return null;
                     },
                   ),
                     Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                             children: <Widget>[
                          Container(
                           width: 100,
                           height: 100,
                           margin: EdgeInsets.only(
                            top: 8,
                             right: 10,
                           ),
                           decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                           ),
                          child: _imageUrlController.text.isEmpty ? Text('Enter a URL') : FittedBox(
                             child: Image.network(
                               _imageUrlController.text,
                               fit: BoxFit.cover,
                               ), 
                           ),
                          ),
                          Expanded(
                                                      child: TextFormField(
                               decoration: InputDecoration(labelText: 'Image Url'),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.url,
                            focusNode: _imageUrlFocusNode, 
                              onSaved: (value){
                            _editProduct = Product(
                              title: _editProduct.title,
                              description: _editProduct.description,
                              id: null,
                              imageUrl: value,
                              price: _editProduct.price,
                            );
                       },
                        validator: (value){
                            if(value.isEmpty){
                             return 'Please enter the Image URL';
                            }
                            if(!value.startsWith('http') && !value.startsWith('https')){
                              return 'Please enter a valid url';
                            }
                            if(!value.endsWith('.jpeg') && !value.endsWith('.png') && !value.endsWith('.jpg')){
                              return 'Invalid image URL';
                            }
                            return null;
                        },
                            ),
                          ),
                             ],
                      ),
                    
               ],
        ),
        ),
      )
    
      
    );
  }
}