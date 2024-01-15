import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app_assignment/api_interface/api_interface_class.dart';
import 'package:ecommerce_app_assignment/utils/colors.dart';
import 'package:ecommerce_app_assignment/model/item.dart';

import 'package:ecommerce_app_assignment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/changeNotifierProducts.dart';
import '../product_details_screen.dart';

final apiProvider = Provider<ApiInterface>((ref) {
  return ApiInterface();
});
final getDataProvider = FutureProvider<dynamic>((ref) {
  return ref.read(apiProvider).getAllProducts();
});

class AllProductsScreen extends HookConsumerWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getAllProducts = ref.watch(getDataProvider);
    final newAdd = ref.watch(writeProduct);
    final Map<String, GlobalKey<FormState>> itemFormKeys = {};

    Utils utils = Utils();

    return Scaffold(
      backgroundColor: Colors.white,
      body: getAllProducts.when(data: (data) {
        return ListView.builder(
            itemCount: data['body']['products'].length,
            itemBuilder: (BuildContext context, int index) {
              final itemId = 'item_$index';
              if (!itemFormKeys.containsKey(itemId)) {
                itemFormKeys[itemId] = GlobalKey<FormState>();
              }
              // print('ImageURL:${data['body']['products'][index]['imageUrl']}');
              return Form(
                key: itemFormKeys[itemId],
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(todo: data['body']['products'][index]),
                      ),
                    );
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
                                      child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: 'https://${data['body']['products'][index]['imageUrl']}',
                                          progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
                                                height: 100,
                                                width: 100,
                                                child:
                                                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                              ),
                                          errorWidget: (context, url, error) => Image.asset(
                                                'assets/images/dummy_image.jpg',
                                              ))),
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
                                        utils.boldPoppins('${data['body']['products'][index]['brandName']}', 15.0, Colors.black,
                                            TextAlign.left),
                                        utils.normalPoppins('${data['body']['products'][index]['name']}', 14.0,
                                            Colors.grey.shade500, TextAlign.left,
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
                                                  '${data['body']['products'][index]['price']['current']['text']}',
                                                  14.0,
                                                  Colors.red,
                                                  TextAlign.left,
                                                  maxlines: 2),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                if (itemFormKeys[itemId]!.currentState!.validate()) {
                                                  Item productDetails = Item(
                                                      id: data['body']['products'][index]['id'].toString(),
                                                      brand: data['body']['products'][index]['brandName'],
                                                      name: data['body']['products'][index]['name'],
                                                      imageUrl: 'https://${data['body']['products'][index]['imageUrl']}',
                                                      price: data['body']['products'][index]['price']['current']['text']);

                                                  await newAdd.addToCart(productDetails);
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      content: Text('Product added successfully'),
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Container(
                                                height: 30,
                                                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                                                decoration: const BoxDecoration(
                                                    color: AppColors.yellow_color,
                                                    borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0))),
                                                child: utils.mediumPoppins('Borrow it', 16.0, Colors.black, TextAlign.center),
                                              ),
                                            )
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
                  ),
                ),
              );
            });
      }, error: ((error, stackTrace) {
        return Text(error.toString());
      }), loading: (() {
        return const Center(child: CircularProgressIndicator());
      })),
    );
  }
}
