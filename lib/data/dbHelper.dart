import 'dart:async';
import 'package:database_demo/models/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String path = join(await getDatabasesPath(), "database");
    var openDb = openDatabase(path, version: 1, onCreate: createDb);
    return openDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table products(id integer primary key, name text, description text, price integer)");
  }

  //işlemleri burada yazıyoruz...
Future<List<Product>> getProducts() async{
    Database db = await this.db;

    var result = await db.query("products");
    return List.generate(result.length, (i){
      return Product.fromObject(result[i]);
    });
}
Future<int> insert(Product product) async{
  Database db = await this.db;

  var result = await db.insert("product", product.toMap());
  return result;
  }
  Future<int> delete(int id) async{
    Database db = await this.db;

    var result = await db.rawDelete("delete from products where id= $id");
    return result;
  }
  Future<int> update(Product product) async{
    Database db = await this.db;

    var result = await db.update("products", product.toMap(), where: "id=?", whereArgs: [product.id]);
    return result;
  }
}
