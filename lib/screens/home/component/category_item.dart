import 'package:flutter/material.dart';
import '../product_by_category.dart';

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String categoryName;

  CategoryItem({required this.icon, required this.label, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductByCategoryPage(categoryName: categoryName,)),
        );;
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(
                icon,
                size: 50,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
