import 'dart:async';

import 'package:flutter_application_2/models/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Dbhelper{

    late Future<Database> _db;

  Dbhelper() {
    _db = initializeDb();
  }

   Future<Database> get db async {
    return _db;
  }
  
  
  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(),"etrade.db");
    var eTradeDb = await openDatabase(dbPath,version: 1,onCreate: createDb);
    return eTradeDb;
  }


  void createDb(Database db, int version) async {
    await db.execute(
      "CREATE TABLE products(id INTEGER PRIMARY KEY, name TEXT, description TEXT, unitPrice INTEGER)");
  }


  Future<List<Product>> getProducts() async{
    Database db = await this.db;
    var result =await db.query("products");
    return List.generate(result.length,(i){
      return Product.toObjectfromMap(result[i]);
    });
  }
  Future<int> insert(Product product) async{
    Database db = await this.db;
    var result = await db.insert("products", product.toMap());
    return result;
  }
  Future<int> update(Product product) async{
    Database db = await this.db;
    var result = await db.update("products",product.toMap(),where:"id=?",whereArgs: [product.id] );
    return result;
  }
  Future<int> delete(int id) async{
    Database db = await this.db;
    var result = await db.rawDelete(" DELETE FROM products WHERE id = $id" );
    return result;
  }
}