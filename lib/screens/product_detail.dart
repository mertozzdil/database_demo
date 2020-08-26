import 'package:database_demo/data/dbHelper.dart';
import 'package:database_demo/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);
  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }
}

enum Options { delete, update }

class _ProductDetailState extends State {
  var txtName = new TextEditingController();
  var txtDescription = new TextEditingController();
  var txtPrice = new TextEditingController();
  var dbHelper = new DbHelper();
  Product product;
  _ProductDetailState(this.product);

  @override
  void initState() {
    txtName.text = product.name;
    txtDescription.text = product.description;
    txtPrice.text = product.price.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün detayı: ${product.name}"),
        actions: <Widget>[
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Sil"),
              ),
              PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Güncelle"),
              )
            ],
          )
        ],
      ),
      body: buildProductDetail(),
    );
  }

  Padding buildProductDetail() {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          buildNameField(),
          buildDescriptionField(),
          buildPriceField()
        ],
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

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.delete(product.id);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.update(Product.withId(product.id, txtName.text,
            txtDescription.text, double.tryParse(txtPrice.text)));
        Navigator.pop(context, true);
        break;
      default:
    }
  }
}
