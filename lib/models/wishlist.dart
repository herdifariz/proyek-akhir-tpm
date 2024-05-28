import 'package:hive/hive.dart';

part 'wishlist.g.dart'; // Generated file

@HiveType(typeId: 1)
class Wishlist extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late double price;

  @HiveField(2)
  late String image;

  Wishlist(this.name, this.price, this.image);
}
