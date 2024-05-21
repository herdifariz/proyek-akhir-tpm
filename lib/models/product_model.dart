class Product {
  final String? status;
  final String? message;
  final List<Products>? products;

  Product({
    this.status,
    this.message,
    this.products,
  });

  Product.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        message = json['message'] as String?,
        products = (json['products'] as List?)?.map((dynamic e) => Products.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'status' : status,
    'message' : message,
    'products' : products?.map((e) => e.toJson()).toList()
  };
}

class Products {
  final int? id;
  final String? title;
  final String? image;
  final int? price;
  final String? description;
  final String? brand;
  final String? model;
  final String? color;
  final String? category;
  final int? discount;

  Products({
    this.id,
    this.title,
    this.image,
    this.price,
    this.description,
    this.brand,
    this.model,
    this.color,
    this.category,
    this.discount,
  });

  Products.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        title = json['title'] as String?,
        image = json['image'] as String?,
        price = json['price'] as int?,
        description = json['description'] as String?,
        brand = json['brand'] as String?,
        model = json['model'] as String?,
        color = json['color'] as String?,
        category = json['category'] as String?,
        discount = json['discount'] as int?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'title' : title,
    'image' : image,
    'price' : price,
    'description' : description,
    'brand' : brand,
    'model' : model,
    'color' : color,
    'category' : category,
    'discount' : discount
  };
}