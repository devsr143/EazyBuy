import 'package:hive/hive.dart';
part 'address_model.g.dart';
@HiveType(typeId: 0)
class AddressModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

  @HiveField(2)
  String street;

  @HiveField(3)
  String city;

  @HiveField(4)
  String state;

  @HiveField(5)
  String zipCode;

  AddressModel({
    required this.name,
    required this.phone,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
  });
}
