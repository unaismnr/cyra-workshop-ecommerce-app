import 'package:badges/badges.dart' as badges;
import 'package:ecart/provider/provider_cart.dart';
import 'package:ecart/screens/cart_page.dart';
import 'package:ecart/screens/home/home_screen.dart';
import 'package:ecart/screens/login_reg/login_screen.dart';
import 'package:ecart/screens/order_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Divider divider = const Divider();

    Widget sizedBox(double height) {
      return SizedBox(
        height: height,
      );
    }

    Widget listTile(IconData leadingIcon, String text, IconData trailingIcon,
            VoidCallback ontap,
            {Color? iconColor}) =>
        ListTile(
          leading: leadingIcon == Icons.shopping_cart_rounded
              ? badges.Badge(
                  showBadge:
                      context.read<Cart>().getItems.isEmpty ? false : true,
                  badgeStyle: const badges.BadgeStyle(badgeColor: Colors.blue),
                  badgeContent: Text(
                    context.watch<Cart>().getItems.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  child: Icon(
                    leadingIcon,
                    color: iconColor,
                  ),
                )
              : Icon(
                  leadingIcon,
                  color: iconColor,
                ),
          title: Text(text),
          trailing: Icon(
            trailingIcon,
            size: 15,
          ),
          onTap: ontap,
        );

    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            sizedBox(50),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'E-Commerce',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            sizedBox(30),
            divider,
            sizedBox(10),
            listTile(
              Icons.home,
              'Home',
              Icons.arrow_forward_ios_rounded,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              ),
            ),
            divider,
            listTile(
              Icons.shopping_cart_rounded,
              'Cart Page',
              Icons.arrow_forward_ios_rounded,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
            ),
            divider,
            listTile(
              Icons.list_alt_rounded,
              'Order Details',
              Icons.arrow_forward_ios_rounded,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderDetailsPage(),
                  ),
                );
              },
            ),
            divider,
            listTile(
              Icons.power_settings_new_rounded,
              'Logout',
              Icons.arrow_forward_ios_rounded,
              iconColor: Colors.red,
              () async {
                final pref = await SharedPreferences.getInstance();
                pref.setBool("isLoggedIn", false);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
