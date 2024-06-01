import 'package:hive/hive.dart';

part 'cart.g.dart';

@HiveType(typeId: 0)
class Cart extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late double price;

  @HiveField(2)
  late String? image;

  Cart(this.name, this.price, this.image);
}
