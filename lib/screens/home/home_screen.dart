import 'package:ecart/screens/home/home_widgets/category_widget.dart';
import 'package:ecart/screens/home/home_widgets/drawer_widget.dart';
import 'package:ecart/screens/home/home_widgets/home_products.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'E-Commerce',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const DrawerWidget(),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryWidget(),
            SizedBox(
              height: 10,
            ),
            Text(
              'Most Searched Products',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            HomeProducts(),
          ],
        ),
      ),
    );
  }
}
