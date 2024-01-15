import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter/foundation.dart';

import '../model/item.dart';
import 'items_provider.dart';

final writeProduct = ChangeNotifierProvider.autoDispose((ref) => ChangeNotifierProduct(ref));

class ChangeNotifierProduct extends ChangeNotifier {
  final Ref _ref;

  ChangeNotifierProduct(this._ref);

  addToCart(Item productDetails) async {
    dynamic list = await Hive.box('itemNew').get('items');

    if (list != null) {
      list.add(productDetails);
      await Hive.box('itemNew').put('items', list);
    } else {
      List<Item> newList = [productDetails];
      await Hive.box('itemNew').put('items', newList);
    }
    dynamic updatedlist = await Hive.box('itemNew').get('items');
    _ref.refresh(itemsProvider);


    notifyListeners();
    print(updatedlist);
  }
}
