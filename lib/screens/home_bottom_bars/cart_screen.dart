import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app_assignment/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/items_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    Utils utils = Utils();
    return Scaffold(
      body: ref.watch(itemsProvider).when(
            data: (item) {
              print("Items: $item");
              return ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                        background: Container(
                          color: scheme.errorContainer,
                          child: Row(
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: Center(
                                  child: Icon(
                                    Icons.delete,
                                    color: scheme.onErrorContainer,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        key: ValueKey(item[index].id),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) async {
                          await item.removeAt(index);
                          await Hive.box('itemNew').put('items', item);
                          ref.refresh(itemsProvider.future);
                        },
                        child: SizedBox(
                          height: 180,
                          child: Container(
                            margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                            child: Card(
                              color: Colors.grey.shade50,
                              elevation: 0.3,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: SizedBox(
                                        height: 170,
                                        width: 120,
                                        child: ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                            child:
                                                // data['body']['products'][index]['imageUrl'] !=''
                                                //  ?
                                                CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl: '${item[index].imageUrl}',
                                                    progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
                                                          height: 100,
                                                          width: 100,
                                                          child: Center(
                                                              child: CircularProgressIndicator(value: downloadProgress.progress)),
                                                        ),
                                                    errorWidget: (context, url, error) => Image.asset(
                                                          'assets/images/dummy_image.jpg',
                                                          // fit: BoxFit.cover,
                                                        ))
                                            //     : Image.asset(
                                            //   'assets/images/dummy_image.jpg',
                                            //   // fit: BoxFit.cover,
                                            // )

                                            ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 7,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20, right: 20),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  utils.boldPoppins('${item[index].brand}', 15.0, Colors.black, TextAlign.left),
                                                ],
                                              ),
                                              utils.normalPoppins(
                                                  '${item[index].name}', 14.0, Colors.grey.shade500, TextAlign.left,
                                                  maxlines: 2),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    alignment: Alignment.center,
                                                    child: utils.normalPoppins(
                                                        '${item[index].price}', 14.0, Colors.red, TextAlign.left,
                                                        maxlines: 2),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ));
                  });
            },
            error: (e, s) => Center(
              child: Text(
                e.toString(),
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
