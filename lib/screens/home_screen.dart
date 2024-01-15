
import 'package:ecommerce_app_assignment/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../colors.dart';
import 'home_bottom_bars/all_products_screen.dart';
import 'home_bottom_bars/cart_screen.dart';


var stateProvider = StateProvider<int>((ref) {
  return 0;
});
class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  Utils utils = Utils();
  String fontFamily = 'Poppins';

  return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.lightGrey,
        centerTitle: true,
        title:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            utils.boldPoppins('Welcome', 17.0, Colors.black, TextAlign.center),
            utils.normalPoppins('Shooping', 12.0, Colors.grey, TextAlign.center)

          ],
        )
      ),
      body: IndexedStack(
        index:ref.watch(stateProvider),
        children: const [
          AllProductsScreen(),
          CartScreen(),
        ],
      ),
      bottomNavigationBar: Material(
        elevation: 3.0,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          child: BottomNavigationBar(
            selectedItemColor: Colors.black,
            backgroundColor: Colors.white,
            unselectedItemColor: AppColors.greyUnSelected,

             selectedLabelStyle: TextStyle(
                 fontSize: 12.0,
                 fontWeight: FontWeight.w800,
                 overflow: TextOverflow.ellipsis,
                 color: Colors.black,
                 fontFamily: fontFamily
             ) ,
             unselectedLabelStyle:TextStyle(
                 fontSize: 12.0,
                 fontWeight: FontWeight.w800,
                 overflow: TextOverflow.ellipsis,
                 color: AppColors.greyUnSelected,
                 fontFamily: fontFamily
             )  ,

            onTap: (index){
             ref.read(stateProvider.state).state = index;
            },
            currentIndex: ref.watch(stateProvider),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'Cart'),


            ],
          ),
        ),
      ),

    );
  }
}
