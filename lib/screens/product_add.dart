import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/dbHelper.dart';
import 'package:flutter_application_2/models/product.dart';

class ProductAdd extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
   return ProductAddState();
  }

}

class ProductAddState extends State {
  var dbHelper = Dbhelper();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtUnitPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      title: Text("add new product"),
     ),
     body: Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(children: <Widget>[
        buildNameField(),
        buildDesciptionField(),
        buildUnitPriceField(),
        buildsaveButton(),
      ],
      ),
      ),
    );

  }
  
  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Product Name"),
      controller: txtName,);
  }
  
  buildDesciptionField() {
     return TextField(
      decoration: InputDecoration(labelText: "Ürün Description"),
      controller: txtDescription,);
  }
  
  buildUnitPriceField() {
     return TextField(
      decoration: InputDecoration(labelText: "Ürün UnitPrice"),
      controller: txtUnitPrice,);
  }
  
 Widget buildsaveButton() {
    return TextButton(onPressed: () => addProduct(),
    child: Text("Ekle"));
  }
  
  addProduct() async {
    double? unitPrice = double.tryParse(txtUnitPrice.text);
    unitPrice ??= 0.0;
    // ignore: unused_local_variable
    var result = dbHelper.insert(Product.withoutId(txtName.text,txtDescription.text,unitPrice ));
    Navigator.pop(context,true);
  }
}