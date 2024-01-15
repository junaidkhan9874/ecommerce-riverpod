import 'package:ecommerce_app_assignment/colors.dart';
import 'package:ecommerce_app_assignment/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/item.dart';
import '../providers/changeNotifierProducts.dart';
import '../providers/item_box_provider.dart';

class ProductDetails extends ConsumerWidget {
  final dynamic todo;

  const ProductDetails({Key? key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newAdd = ref.watch(writeProduct);

    Utils utils = Utils();
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(50.0), bottomRight: Radius.circular(50.0)),
                        image: DecorationImage(
                            image: NetworkImage(
                              'https://${todo['imageUrl']}',
                            ),
                            fit: BoxFit.cover)),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: const EdgeInsets.only(top: 40, right: 20),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white),
                      height: 30,
                      width: 30,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.favorite,
                        color: AppColors.yellow_color,
                      ),
                    ),
                  )
                ],
              )),
          Expanded(
              flex: 4,
              child: Container(
                margin: const EdgeInsets.only(left: 25, right: 25, top: 25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utils.boldPoppins('${todo['brandName']}', 20.0, Colors.black, TextAlign.center),
                        utils.mediumPoppins('${todo['price']['current']['text']}', 20.0, Colors.red, TextAlign.center)
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    utils.normalPoppins('${todo['name']}.', 16.0, Colors.grey.shade500, TextAlign.left, maxlines: 4),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            Item productDetails = Item(
                                id: '${todo['price']['current']['text']}'.toString(),
                                brand: '${todo['brandName']}',
                                name: '${todo['name']}',
                                imageUrl: 'https://${todo['imageUrl']}',
                                price: '${todo['price']['current']['text']}');

                            await newAdd.addToCart(productDetails);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Product added successfully'),
                              ),
                            );
                          },
                          child: Container(
                            height: 70,
                            width: MediaQuery.sizeOf(context).width/1.3,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: AppColors.yellow_color),
                            child: utils.mediumPoppins('Buy Now', 16.0, Colors.white, TextAlign.center),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
