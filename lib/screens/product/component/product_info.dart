import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import 'product_favorite.dart';

class ProductInfo extends StatefulWidget {
  final Products productData;
  const ProductInfo({required this.productData});

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0), // Rounded corners
            child: Container(
              color: Colors.grey[300],
              child: Center(child: Image.network(widget.productData.image!)),
            ),
          ),
        ),
        Row(
          children: [
            Text(
              widget.productData.price.toString(),
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Text color
              ),
            ),
            Spacer(),
            ProductFavorite(
              isFavorited: _isFavorited,
              onPressed: _toggleFavorite,
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Product Name',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Product Description',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
