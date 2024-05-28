import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String _selectedCurrency = 'USD';

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Load preferences when the widget is initialized
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedCurrency = prefs.getString('selectedCurrency') ?? 'USD';
    });
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  double _convertCurrency(double hargaitem) {
    switch (_selectedCurrency) {
      case 'Rupiah':
        return hargaitem * 16000;
      case 'EUR':
        return hargaitem * 0.92;
      default:
        return hargaitem;
    }
  }

  String _formatPrice(double price) {
    switch (_selectedCurrency) {
      case 'Rupiah':
        return 'Rp ${price.toStringAsFixed(0)}';
      case 'EUR':
        return '€${price.toStringAsFixed(2)}';
      default:
        return '\$${price.toStringAsFixed(2)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    double convertedPrice = _convertCurrency(widget.productData.price as double);

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
              _formatPrice(convertedPrice),
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
          widget.productData.title!,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          widget.productData.description!,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
