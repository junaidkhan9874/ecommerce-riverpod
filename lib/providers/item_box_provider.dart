import 'package:ecommerce_app_assignment/model/item.dart';
import 'package:ecommerce_app_assignment/model/product_model.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';



final itemBoxProvider = FutureProvider<List<Item>>(
      (ref) => Hive.box("itemNew").get('items'),
);