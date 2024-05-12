import 'dart:convert';
import 'dart:developer';

import 'package:ecart/models/user_model.dart';
import 'package:ecart/provider/provider_cart.dart';
import 'package:ecart/screens/home/home_screen.dart';
import 'package:ecart/screens/razorpay.dart';
import 'package:ecart/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CheckoutPage extends StatefulWidget {
  final List<CartProductModel> cart;
  const CheckoutPage({super.key, required this.cart});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int selectedValue = 1;
  String paymentmethod = "Cash on Delivery";
  String? name, phone, address;

  @override
  void initState() {
    loadUsername();
    super.initState();
  }

  String? username;

  void loadUsername() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString(
        'username',
      );
    });
  }

  orderPlace(
    List<CartProductModel> cart,
    String name,
    String phone,
    String address,
    String amount,
    String date,
    String paymentmethod,
  ) async {
    String jsonData = jsonEncode(cart);
    print('jsonData: ${jsonData}');

    final vm = Provider.of<Cart>(context, listen: false);

    final response = await http
        .post(Uri.parse("http://bootcamp.cyralearnings.com/order.php"), body: {
      "username": username,
      "name": name,
      "phone": phone,
      "address": address,
      "amount": amount,
      "date": date,
      "paymentmethod": paymentmethod,
      "quantity": vm.count.toString(),
      "cart": jsonData,
    });
    log("status code === " + response.statusCode.toString());
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body.contains('Success')) {
        vm.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Your Order is Completed Successfully",
            ),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FutureBuilder<UserModel>(
                  future: Webservice().retakeUser(username.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      name = snapshot.data!.name;
                      phone = snapshot.data!.phone;
                      address = snapshot.data!.address;
                      // snapshot.data.
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Name: ",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    name.toString(),
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Phone: ",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    phone.toString(),
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Address: ",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Text(
                                      address.toString(),
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const CircularProgressIndicator();
                  }),
              const SizedBox(
                height: 15,
              ),
              RadioListTile(
                value: 1,
                groupValue: selectedValue,
                onChanged: (int? value) {
                  setState(() {
                    selectedValue = value!;
                    paymentmethod = "Cash on Delivery";
                  });
                },
                title: const Text(
                  "Cash on Delivery",
                ),
                subtitle: const Text(
                  "Pay Cash at Home",
                ),
              ),
              RadioListTile(
                value: 2,
                groupValue: selectedValue,
                onChanged: (int? value) {
                  setState(() {
                    selectedValue = value!;
                    paymentmethod = "Online Payment";
                  });
                },
                title: const Text(
                  "Pay Now",
                ),
                subtitle: const Text(
                  "Online Payment",
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
            ),
            child: const Center(
              child: Text(
                "Checkout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          onTap: () {
            String dateTime = DateTime.now().toString();

            if (paymentmethod == "Online Payment") {
              print(username);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentPage(
                    cart: widget.cart,
                    paymentmethod: paymentmethod,
                    date: dateTime,
                    name: name.toString(),
                    address: address.toString(),
                    phone: phone.toString(),
                    amount: vm.totalPrice.toString(),
                  ),
                ),
              );
            } else if (paymentmethod == "Cash on Delivery") {
              orderPlace(
                widget.cart,
                name!,
                phone!,
                address!,
                vm.totalPrice.toString(),
                dateTime,
                paymentmethod,
              );
            }
          },
        ),
      ),
    );
  }
}
