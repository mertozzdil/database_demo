import 'package:database_demo/data/dbHelper.dart';
import 'package:database_demo/models/product.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddProductState();
  }
}

class _AddProductState extends State {
  var dbHelper = new DbHelper();
  var txtName = new TextEditingController();
  var txtDescription = new TextEditingController();
  var txtPrice = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("abc"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            buildNameField(), buildDescriptionField(), buildPriceField(), buildSaveButton()
          ],
        ),
      ),
    );
  }

  TextField buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün adı"),
      controller: txtName,
    );
  }

  TextField buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün açıklaması"),
      controller: txtDescription,
    );
  }

  TextField buildPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün fiyatı"),
      controller: txtPrice,
    );
  }

  FlatButton buildSaveButton() {
    return FlatButton(
      child: Text("ekle"),
      onPressed: (){
        addProduct();
      },
    );
  }

  void addProduct() async{
    var result = await dbHelper.insert(Product(txtName.text, txtDescription.text, double.tryParse(txtPrice.text)));
    Navigator.pop(context,true);
  }
}

