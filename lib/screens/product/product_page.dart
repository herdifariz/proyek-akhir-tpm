import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import 'component/product_action.dart';
import 'component/product_app_bar.dart';
import 'component/product_info.dart';

class ProductPage extends StatelessWidget {
  final Products productData;

  const ProductPage({required this.productData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProductAppBar(),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).padding.top + kToolbarHeight)),
          color: Colors.deepPurple,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProductInfo(
                productData: productData,
              ),
              SizedBox(height: 20,),
              // ProductActions(
              //   productData: productData,
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: ProductActions(productData: productData,),
    );
  }
}
