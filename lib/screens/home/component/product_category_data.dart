import 'package:flutter/material.dart';
import 'package:proyek/models/product_model.dart';
import 'package:proyek/screens/home/component/product_item.dart';

import '../../../models/api_data_souce.dart';

class ProductCategoryData extends StatelessWidget {
  final categoryName;
  const ProductCategoryData({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: FutureBuilder(
        future: ApiDataSource.instance.loadProductsByCategory(categoryName),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            Product productData = Product.fromJson(snapshot.data);
            return _buildSuccessSection(productData);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }



  Widget _buildErrorSection() {
    return Center(child: Text("Error"));
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(Product productsData) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // Menyusun children dari Column ke kiri
        children: [
          SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              child: Text(
                '${categoryName.toUpperCase()} Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Jumlah kolom
              crossAxisSpacing: 8.0, // Jarak horizontal antar kolom
              mainAxisSpacing: 8.0, // Jarak vertikal antar baris
              childAspectRatio: 0.75, // Rasio aspek untuk menyesuaikan tinggi dan lebar item grid
            ),
            itemCount: productsData.products!.length,
            // Mengatur jumlah produk berdasarkan status showAll
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductItem(productData: productsData.products![index]),
              );
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
