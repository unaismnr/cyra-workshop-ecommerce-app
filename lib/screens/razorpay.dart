// import 'dart:math';
import 'dart:convert';
import 'dart:developer';

import 'package:ecart/provider/provider_cart.dart';
import 'package:ecart/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PaymentPage extends StatefulWidget {
  final List<CartProductModel> cart;
  final String paymentmethod;
  final String date;
  final String name;
  final String amount;
  final String address;
  final String phone;
  const PaymentPage({
    super.key,
    required this.cart,
    required this.paymentmethod,
    required this.date,
    required this.name,
    required this.amount,
    required this.address,
    required this.phone,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Razorpay? _razorpay;
  String? username;

  @override
  void initState() {
    loadUsername();
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    flutterpayment("abcd", 1);
    super.initState();
  }

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
    return const Scaffold();
  }

  void flutterpayment(String orderID, int total) {
    var options = {
      'key': 'rzp_live_wlklx79ShXP3pw',
      'amount': total * 100,
      'name': 'Unais',
      'description': 'Fine T-Shirt',
      'currency': 'INR',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };
    try {
      _razorpay!.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    response.orderId;
    successmethod(response.paymentId.toString());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log("payment failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log("wallet");
  }

  void successmethod(String paymentID) {
    orderPlace(widget.cart, widget.name, widget.phone, widget.address,
        widget.amount.toString(), widget.date, widget.paymentmethod);
  }
}
