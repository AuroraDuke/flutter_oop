import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/dbHelper.dart'; // Assuming dbhelper is imported from here
import 'package:flutter_application_2/models/product.dart';
import 'package:flutter_application_2/screens/product_edit.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  ProductDetail(this.product);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

enum Options {
  delete,
  update,
}

class _ProductDetailState extends State<ProductDetail> {
  late Product product;
  late Dbhelper dbhelper; // Declare dbhelper instance

  @override
  void initState() {
    super.initState();
    product = widget.product;
    dbhelper = Dbhelper(); // Initialize dbhelper instance
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail: ${product.name}"),
        actions: [
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Delete"),
              ),
              PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Update"),
              ),
            ],
          ),
        ],
      ),
      body: buildProductDetail(),
    );
  }

  Widget buildProductDetail() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Product Name: ${product.name}"),
          Text("Description: ${product.description}"),
          Text("Price: \$${product.unitPrice.toStringAsFixed(2)}"), // Assuming 'unitPrice' is a double
        ],
      ),
    );
  }

  Future<void> selectProcess(Options value) async {
    switch (value) {
      case Options.delete:
        if (product.id != null) {
          await dbhelper.delete(product.id!); // Delete product by id
          
        } else {
          print('Product ID is null. Cannot delete.');
        }
        backToPreviousscreen(context); // Navigate back to previous screen
        break;
      case Options.update:
        // Navigate to ProductEdit screen for updating the product
        final updatedProduct = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductEdit(product)),
        );
        if (updatedProduct != null) {
          setState(() {
            product = updatedProduct;
          });
        }
        break;
    }
  }
  backToPreviousscreen(BuildContext context){
    return
    Navigator.pop(context, true);
  }
}
