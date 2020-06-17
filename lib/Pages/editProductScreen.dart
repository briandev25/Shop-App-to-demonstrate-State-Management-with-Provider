import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/product.dart';
 import '../Providers/productsProvider.dart';


class EditProductScreen extends StatefulWidget {
  static  const  namedRoute = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(id: '', title: '', description: '', imageUrl: '', price: 0);

  var _isInit  = true;
  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
     _imageUrlController.dispose();
     _imageUrlFocusNode.dispose();
    super.dispose();
  }
  var _isLoading = false;
  @override
  void initState() {
  _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }
 @override
  void didChangeDependencies() {
    if(_isInit){

    }
    _isInit =false;
    super.didChangeDependencies();
  }
  void _updateImageUrl(){
     if(!_imageUrlFocusNode.hasFocus){
      setState(() {
        
      }); 
     }
  }
  Future<void> _saveForm() async{
     final _isValid =  _form.currentState.validate();
     if(!_isValid){
       return;
     }
       _form.currentState.save();
       setState(() {
         _isLoading = true;
       });
       try{
            await Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
       }catch (error){
        await showDialog(
           context: context,
           builder: (ctx) => AlertDialog(
             title: Text('An Error occurred'),
             content: Text('Something went wrong'),
             actions: <Widget>[
                  FlatButton(onPressed: (){
                    Navigator.of(ctx).pop();
                  }, child: Text('OK'))
             ],
           ),
           );
       }finally{
            setState(() {
         _isLoading = false;
       }) ;
          Navigator.of(context).pop(); 
       }
   


    
    
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
      body:_isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child:ListView(
          children: <Widget>[
            TextFormField(
             decoration: InputDecoration(labelText: 'Title'),
             textInputAction: TextInputAction.next,
             onFieldSubmitted: (_){
              FocusScope.of(context).requestFocus(_priceFocusNode);
             },
             onSaved: (value){
               _editedProduct = Product(
                 id: _editedProduct.id, 
                 title: value,
                  description:_editedProduct.description ,
                  imageUrl: _editedProduct.imageUrl,
                   price: _editedProduct.price
                   );
             },
             validator: (value){
               if(value.isEmpty){
                 return 'The title cannot be empty';
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
               _editedProduct = Product(
                 id: _editedProduct.id, 
                 title:_editedProduct.title ,
                  description:_editedProduct.description ,
                  imageUrl: _editedProduct.imageUrl,
                   price:double.parse(value),
                   );
             },
              validator: (value){
               if(value.isEmpty){
                 return 'Please enter a price';
               }
               if(double.tryParse(value) == null){
                 return 'Please enter a number';
               }
               if(double.parse(value) <= 0){
                 return 'Please enter a price greater than zero';
               }
               return null;
             },
            ),
             TextFormField(
             decoration: InputDecoration(labelText: 'Description'),
             maxLines: 3,
             
             keyboardType: TextInputType.multiline,
             onFieldSubmitted: (_){
              FocusScope.of(context).requestFocus(_priceFocusNode);
             },
             focusNode: _descriptionFocusNode,
              onSaved: (value){
               _editedProduct = Product(
                 id: _editedProduct.id, 
                 title:_editedProduct.title ,
                  description:value,
                  imageUrl: _editedProduct.imageUrl,
                   price:_editedProduct.price ,
                   );
             },
              validator: (value){
               if(value.isEmpty){
                 return 'Description cannot be empty';
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
                     top: 10,
                     right: 8,
                   ),
                   decoration: BoxDecoration(
                     border: Border.all(
                       width: 1,
                       color: Colors.grey,
                     ),
                   ),
                   child: _imageUrlController.text.isEmpty ? Text('Enter a Url') : FittedBox(
                     child: Image.network(_imageUrlController.text,
                     fit: BoxFit.cover,
                     ),
                   ) ,
                  ),
                   Expanded(
                     child: TextFormField(
             decoration: InputDecoration(labelText: 'Image Url'),
             textInputAction: TextInputAction.done,
             keyboardType: TextInputType.url,
             focusNode: _imageUrlFocusNode,
             controller: _imageUrlController,
             onFieldSubmitted: (_){
               _saveForm();
             },
              onSaved: (value){
               _editedProduct = Product(
                 id: _editedProduct.id, 
                 title:_editedProduct.title ,
                  description:_editedProduct.description ,
                  imageUrl: value,
                   price:_editedProduct.price ,
                   );
             },
              validator: (value){
               if(value.isEmpty){
                 return 'The title cannot be empty';
               }
               if(!value.startsWith('http') && !value.startsWith('https')){
                 return 'Enter a valid URL';
               }
               if(value.endsWith('png') && value.endsWith('jpeg') && value.endsWith('jpg'))
               {
                 return 'The title cannot be empty';
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
      ),
    );
  }
}