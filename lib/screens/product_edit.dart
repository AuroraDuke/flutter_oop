import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/product.dart';

class ProductEdit extends StatefulWidget {
  final Product product;

  ProductEdit(this.product);

  @override
  _ProductEditState createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _unitPriceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _descriptionController = TextEditingController(text: widget.product.description);
    _unitPriceController = TextEditingController(text: widget.product.unitPrice.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _unitPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product: ${widget.product.name}"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _unitPriceController,
              decoration: InputDecoration(labelText: 'Unit Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Save changes and pop result back to previous screen
                saveChanges(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void saveChanges(BuildContext context) {
    // Validate and save changes to the product
     final updatedProduct = widget.product.copyWith(
    name: _nameController.text,
    description: _descriptionController.text,
    unitPrice: double.parse(_unitPriceController.text),
  );

    // Pop result back to previous screen
    Navigator.pop(context, updatedProduct);
  }
}
