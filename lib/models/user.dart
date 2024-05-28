import 'package:hive/hive.dart';

part 'user.g.dart'; // Generated file

@HiveType(typeId: 2)
class User extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String city;

  @HiveField(2)
  late String address;

  @HiveField(3)
  late String phone;

  @HiveField(4)
  late String email;

  @HiveField(5)
  late String password;

  User(
      this.name,
      this.city,
      this.address,
      this.phone,
      this.email,
      this.password
      );
}
