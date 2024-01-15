
import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 1)
class Item extends HiveObject{
  @HiveField(0)
  String brand;
  @HiveField(1)
  String name;
  @HiveField(2)
  String imageUrl;
  @HiveField(3)
  String price;
  @HiveField(4)
  String id;

  Item({ this.brand = "",  this.name = "", this.imageUrl = "",  this.price = "",this.id=""});
}