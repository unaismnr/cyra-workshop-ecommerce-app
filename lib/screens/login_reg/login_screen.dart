import 'dart:convert';
import 'dart:math';

import 'package:ecart/screens/home/home_screen.dart';
import 'package:ecart/screens/login_reg/registration_screen.dart';
import 'package:ecart/screens/login_reg/login_reg_widgets/custom_elevated_bttn.dart';
import 'package:ecart/screens/login_reg/login_reg_widgets/custom_text_field.dart';
import 'package:ecart/screens/login_reg/login_reg_widgets/account_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? username, password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadprefs();
  }

  void _loadprefs() async {
    final prefs = await SharedPreferences.getInstance();
    bool isloggedin = prefs.getBool('isLoggedIn') ?? false;
    print(
      'Logged In:${isloggedin.toString()}',
    );
    if (isloggedin) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        ),
      );
    }
  }

  login(String username, String password) async {
    print('webservice');
    print(username);
    print(password);
    var result;
    final Map<String, dynamic> logData = {
      'username': username,
      'password': password,
    };
    final response = await http.post(
      Uri.parse(
        'http://bootcamp.cyralearnings.com/login.php',
      ),
      body: logData,
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      if (response.body.contains('success')) {
        print('Login successfully completed');
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('username', username.toString());
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return HomeScreen();
            },
          ),
        );
      } else {
        print("Login failed");
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
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    hintText: 'Enter your username',
                    onChanged: (text) {
                      setState(() {
                        username = text;
                      });
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
                    hintText: 'Enter your password',
                    onChanged: (text) {
                      setState(() {
                        password = text;
                      });
                    },
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter valid password';
                      }
                      return null;
                    },
                  ),
                  widgetHight,
                  CustomElevatedButton(
                    logRegText: 'Login',
                    onChanged: () {
                      if (_formkey.currentState!.validate()) {
                        print(username);
                        print(password);
                        login(username.toString(), password.toString());
                      }
                    },
                  ),
                  widgetHight,
                  AccountConfirmation(
                    accountConfirmText: "Don't have' account?",
                    onChanged: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const RegistrationScreen();
                          },
                        ),
                      );
                    },
                    loginRegisterText: 'Register',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
