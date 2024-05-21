import 'package:hive/hive.dart';

part 'cart.g.dart'; // Generated file

@HiveType(typeId: 0)
class Cart extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late double price;

  Cart(this.name, this.price);
}
