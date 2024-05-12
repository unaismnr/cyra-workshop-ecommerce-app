import 'package:ecart/provider/provider_cart.dart';
import 'package:ecart/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class ProductDetailsPage extends StatelessWidget {
  final String name, price, image, description;
  final int id;
  const ProductDetailsPage({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    // print("id: " + id.toString());
    // print("name: " + name.toString());
    // print("price: " + price.toString());
    // print("image: " + image.toString());
    // print("description: " + description.toString());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    child: Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.width * .8,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        image,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 20,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[350],
                      child: IconButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        ),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 280,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 243, 243, 243),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rs. $price',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              description,
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomSheet: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                var existingItemCart =
                    context.read<Cart>().getItems.firstWhereOrNull(
                          (element) => element.id == id,
                        );
                if (existingItemCart != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.blue,
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        'This Item is Already in Cart',
                      ),
                    ),
                  );
                } else {
                  context.read<Cart>().addItem(
                        id,
                        name,
                        double.parse(price),
                        1,
                        image,
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.blue,
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        'Added to Cart',
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                'Add to Cart',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
