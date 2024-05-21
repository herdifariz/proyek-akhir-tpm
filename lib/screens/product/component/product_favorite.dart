import 'package:flutter/material.dart';

class ProductFavorite extends StatefulWidget {
  final bool isFavorited;
  final Function() onPressed;

  const ProductFavorite({
    required this.isFavorited,
    required this.onPressed,
  });

  @override
  _ProductFavoriteState createState() => _ProductFavoriteState();
}

class _ProductFavoriteState extends State<ProductFavorite> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.isFavorited ? Icons.favorite : Icons.favorite_border,
        color: widget.isFavorited ? Colors.white : Colors.white,
      ),
      onPressed: widget.onPressed,
    );
  }
}
