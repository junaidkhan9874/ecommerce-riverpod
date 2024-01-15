
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final itemsProvider = FutureProvider<List<dynamic>>((ref) async {

  List<dynamic> values = await Hive.box('itemNew').get('items');
  return values;
});