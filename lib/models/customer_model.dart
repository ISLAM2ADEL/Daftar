import 'package:hive/hive.dart';

part 'customer_model.g.dart';

@HiveType(typeId: 0)
class CustomerModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String phone;

  @HiveField(3)
  double balance; // >0 = customer owes shop (debt/red), <0 = shop owes customer (credit/green), 0 = settled/grey

  @HiveField(4)
  DateTime createdAt;

  CustomerModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.balance,
    required this.createdAt,
  });
}
