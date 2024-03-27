import 'package:fake_products/controllers/cart_controller.dart';
import 'package:fake_products/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    return GetMaterialApp(
      title: 'Flutter Fake Products',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade600),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
