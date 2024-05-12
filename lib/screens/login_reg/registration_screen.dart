import 'dart:convert';
import 'dart:math';

import 'package:ecart/screens/login_reg/login_screen.dart';
import 'package:ecart/screens/login_reg/login_reg_widgets/custom_elevated_bttn.dart';
import 'package:ecart/screens/login_reg/login_reg_widgets/custom_text_field.dart';
import 'package:ecart/screens/login_reg/login_reg_widgets/account_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? name, phone, address, username, password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  registration(String name, phone, address, username, password) async {
    print('web service');
    print(username);
    var result;
    final Map<String, dynamic> data = {
      'name': name,
      'phone': phone,
      'address': address,
      'username': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse("http://bootcamp.cyralearnings.com/registration.php"),
      body: data,
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      if (response.body.contains('success')) {
        print("reg successfully completed");

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return LoginScreen();
            },
          ),
        );
      } else {
        print('Reg failed');
      }
    } else {
      result = {log(json.decode(response.body)['error'])};
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    const widgetHight = SizedBox(
      height: 20,
    );

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Registration Account',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const Text(
                  'Complete your details',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: 'Name',
                        onChanged: (nameText) {
                          setState(
                            () {
                              name = nameText;
                            },
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter valid address';
                          }
                          return null;
                        },
                      ),
                      widgetHight,
                      CustomTextField(
                        keyBoardType: TextInputType.phone,
                        hintText: 'Phone',
                        onChanged: (phoneText) {
                          setState(
                            () {
                              phone = phoneText;
                            },
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter valid phone number';
                          } else if (value.length < 10) {
                            return 'Enter valid phone number';
                          }
                          return null;
                        },
                      ),
                      widgetHight,
                      CustomTextField(
                        lines: 4,
                        containerHeight: 100,
                        hintText: 'Address',
                        onChanged: (addressText) {
                          setState(
                            () {
                              address = addressText;
                            },
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter valid address';
                          }
                          return null;
                        },
                      ),
                      widgetHight,
                      CustomTextField(
                        hintText: 'Username',
                        onChanged: (usernameText) {
                          setState(
                            () {
                              username = usernameText;
                            },
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter valid username';
                          }
                          return null;
                        },
                      ),
                      widgetHight,
                      CustomTextField(
                        obscureText: true,
                        hintText: 'Password',
                        onChanged: (passwordText) {
                          setState(
                            () {
                              password = passwordText;
                            },
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter valid password';
                          }
                          return null;
                        },
                      ),
                      widgetHight,
                      CustomElevatedButton(
                        logRegText: 'Register',
                        onChanged: () {
                          if (_formkey.currentState!.validate()) {
                            print(name);
                            print(phone);
                            print(address);
                            print(username);
                            print(password);
                          }
                          registration(
                              name!, phone, address, username, password);
                        },
                      ),
                      widgetHight,
                      AccountConfirmation(
                        accountConfirmText: 'Do you have an account?',
                        onChanged: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        loginRegisterText: 'Login',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
