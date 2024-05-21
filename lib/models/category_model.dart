class Category {
  final String? status;
  final String? message;
  final List<String>? categories;

  Category({
    this.status,
    this.message,
    this.categories,
  });

  Category.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        message = json['message'] as String?,
        categories = (json['categories'] as List?)?.map((dynamic e) => e as String).toList();

  Map<String, dynamic> toJson() => {
    'status' : status,
    'message' : message,
    'categories' : categories
  };
}