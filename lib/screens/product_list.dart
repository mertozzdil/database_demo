import 'package:database_demo/data/dbHelper.dart';
import 'package:database_demo/models/product.dart';
import 'package:database_demo/screens/add_product.dart';
import 'package:database_demo/screens/product_detail.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State {
  var dbHelper = new DbHelper();
  List<Product> products;
  int productCount = 0;

  @override
  void initState() {
    getProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün listesi"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){goToProductAdd();},
        child: Icon(Icons.add),
        tooltip: "yeni ürün ekle",
      ),
    );
  }

  ListView buildProductList() {
    ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position){
          return Card(
            color: Colors.greenAccent,
            elevation: 2.0,
            child: ListTile(
              title: Text(this.products[position].name),
              subtitle: Text(this.products[position].description),
              trailing: Text(this.products[position].price.toString()),
              onTap: (){goToDetail(this.products[position]);},
            ),
          );
        });
  }

  void goToProductAdd() async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct()));
    if(result!=null){
      if(result){
        getProducts();
      }
    }
  }
  void getProducts() async{
    var productFuture = dbHelper.getProducts();
    productFuture.then((data){
      setState(() {
        this.products = data;
        productCount = data.length;
      });
    });
  }

  void goToDetail(Product product) async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(product)));
    if(result!=null){
      if(result){
        getProducts();
      }
    }
  }
}
