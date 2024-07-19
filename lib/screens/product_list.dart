import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/data/dbHelper.dart';
import 'package:flutter_application_2/models/product.dart';
import 'package:flutter_application_2/screens/product_add.dart';
import 'package:flutter_application_2/screens/product_detail.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State {
  Dbhelper dbhelper = new Dbhelper();
  late List<Product> products;
  int productcount = 0;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      body: buildProuctList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => goToProudctAdd(context),
        child: Icon(Icons.add),
        tooltip: "add new product",
      ),
    );
  }

  ListView buildProuctList() {
    return ListView.builder(
        itemCount: productcount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.cyan,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black12,
                child: Text("p"),
              ),
              title: Text('${this.products[position].name} - \$${this.products[position].unitPrice}'),
              subtitle: Text(this.products[position].description),
              onTap: () {goToDetail(this.products[position]);},
            ),
          );
        });
  }

  void goToProudctAdd(BuildContext context) async {
    bool? result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));
    // ignore: unnecessary_null_comparison
    if (result != null) {
      if (result) {
        getProducts();
      }
    }
  }

  void getProducts() async {
  try {
    var data = await dbhelper.getProducts();
    setState(() {
      products = data;
      productcount = data.length;
    });
  } catch (error) {
    print('Error fetching products: $error');
  }
}

  void goToDetail(Product product) async{
    bool? result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(product)));
    // ignore: unnecessary_null_comparison
    if(result!=null){
      if (result){
        getProducts();
      }
    else{
      print("product gönderilmedi");
    }
    }

  }
}
