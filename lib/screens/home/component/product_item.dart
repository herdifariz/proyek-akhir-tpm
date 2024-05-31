import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/product_model.dart';
import '../../product/product_page.dart';

class ProductItem extends StatefulWidget {
  final Products productData;
  const ProductItem({super.key, required this.productData});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
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

  double _convertCurrency(double harga) {
    switch (_selectedCurrency) {
      case 'Rupiah':
        return harga * 16000;
      case 'EUR':
        return harga * 0.92;
      default:
        return harga;
    }
  }

  String _formatPrice(double harga) {
    switch (_selectedCurrency) {
      case 'Rupiah':
        return 'Rp ${harga.toStringAsFixed(0)}';
      case 'EUR':
        return '€${harga.toStringAsFixed(2)}';
      default:
        return '\$${harga.toStringAsFixed(2)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    double convertedPrice = _convertCurrency(widget.productData.price! as double);

    return Container(
      width: 150,
      height: 305, // Menentukan tinggi tetap untuk Container
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductPage(productData: widget.productData)),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              child: Image.network(
                widget.productData.image!,
                width: 150,
                height: 150, // Fixed height for the image
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.productData.title!.length > 20
                        ? widget.productData.title!.substring(0, 20) + "..."
                        : widget.productData.title!,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _formatPrice(convertedPrice), // Display converted price
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
