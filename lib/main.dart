
import 'package:database_demo/screens/add_product.dart';
import 'package:database_demo/screens/product_list.dart';
import 'package:flutter/material.dart';

import 'models/product.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductList()
    );
  }
}

