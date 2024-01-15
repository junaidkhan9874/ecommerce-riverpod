import 'dart:io';

import 'package:ecommerce_app_assignment/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'model/item.dart';

void main() async {
  Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationSupportDirectory();
  Hive.init(directory.path);
  await Hive.openBox('itemNew');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce RiverPod',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
