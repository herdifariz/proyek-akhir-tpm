import 'package:flutter/material.dart';
import 'component/product_action.dart';
import 'component/product_app_bar.dart';
import 'component/product_image.dart';
import 'component/product_info.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProductAppBar(),
      body: Container(
        color: Colors.deepPurple,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProductImage(),
            SizedBox(height: 16.0),
            ProductInfo(),
            Spacer(),
            ProductActions(),
          ],
        ),
      ),
    );
  }
}
