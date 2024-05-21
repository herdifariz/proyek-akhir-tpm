import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyek/models/product_model.dart';
import 'package:proyek/screens/home/component/product_item.dart';
import '../../../models/api_data_souce.dart';
import '../../../models/category_model.dart';
import 'category_item.dart';

class HomeCategoryData extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const HomeCategoryData({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  _HomeCategoryDataState createState() => _HomeCategoryDataState();
}

class _HomeCategoryDataState extends State<HomeCategoryData> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: FutureBuilder(
        future: ApiDataSource.instance.loadCategory(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            Category categoryData = Category.fromJson(snapshot.data);
            return _getProduct(categoryData);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _getProduct(Category categoryData) {
    return FutureBuilder(
      future: ApiDataSource.instance.loadProducts(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }
        if (snapshot.hasData) {
          Product productsData = Product.fromJson(snapshot.data);
          return SingleChildScrollView(
            child: _buildSuccessSection(categoryData, productsData),
          );
        }
        return _buildLoadingSection();
      },
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

  Widget _buildSuccessSection(Category categoryData, Product productsData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // Menyusun children dari Column ke kiri
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 0,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            CategoryItem(
              icon: Icons.tv_outlined,
              label: categoryData.categories![0].toUpperCase(),
              categoryName: categoryData.categories![0],
            ),
            CategoryItem(
              icon: Icons.speaker_group_outlined,
              label: categoryData.categories![1].toUpperCase(),
              categoryName: categoryData.categories![1],
            ),
            CategoryItem(
              icon: Icons.laptop_mac_outlined,
              label: categoryData.categories![2].toUpperCase(),
              categoryName: categoryData.categories![2],
            ),
            CategoryItem(
              icon: Icons.phone_android_outlined,
              label: categoryData.categories![3].toUpperCase(),
              categoryName: categoryData.categories![3],
            ),
            CategoryItem(
              icon: Icons.videogame_asset,
              label: categoryData.categories![4].toUpperCase(),
              categoryName: categoryData.categories![4],
            ),
            CategoryItem(
              icon: Icons.table_restaurant_rounded,
              label: categoryData.categories![5].toUpperCase(),
              categoryName: categoryData.categories![5],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    showAll = !showAll; // Mengubah status showAll
                  });
                },
                child: Text(
                  showAll ? 'Show Less' : 'Show All',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                ),
              ),
            ],
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
          itemCount: showAll ? productsData.products!.length : 4,
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
    );
  }
}
