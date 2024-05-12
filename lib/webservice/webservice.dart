import 'dart:convert';
import 'package:ecart/models/category_model.dart';
import 'package:ecart/models/order_details_model.dart';
import 'package:ecart/models/product_model.dart';
import 'package:ecart/models/user_model.dart';
import 'package:http/http.dart' as http;

class Webservice {
  final imageurl = 'http://bootcamp.cyralearnings.com/products/';
  final mainurl = 'http://bootcamp.cyralearnings.com';

  Future<List<CategoryModel>?> getCategory() async {
    try {
      final response = await http.get(
        Uri.parse('$mainurl/getcategories.php'),
      );

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

        return parsed
            .map<CategoryModel>((json) => CategoryModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load category');
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<ProductModel>> getProducts() async {
    final response = await http.get(
      Uri.parse('$mainurl/view_offerproducts.php'),
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Faild to load products');
    }
  }

  Future<List<ProductModel>> getCategoryProducts(int catid) async {
    print('catid: ${catid.toString()}');
    final response = await http.post(
        Uri.parse(
            'http://bootcamp.cyralearnings.com/get_category_products.php'),
        body: {'catid': catid.toString()});
    print('response + ${response.toString()}');
    if (response.statusCode == 200) {
      print('response: ${response.statusCode}');
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<UserModel> retakeUser(String username) async {
    final respose = await http.post(
        Uri.parse('http://bootcamp.cyralearnings.com/get_user.php'),
        body: {'username': username});
    if (respose.statusCode == 200) {
      return UserModel.fromJson(
        jsonDecode(respose.body),
      );
    } else {
      throw Exception(
        'Failed to load',
      );
    }
  }

  Future<List<OrderDetailsModel>?> getOrderDetails(String username) async {
    // String aa;
    try {
      final response = await http.post(
        Uri.parse(
          "http://bootcamp.cyralearnings.com/get_orderdetails.php",
        ),
        body: {'username': username},
      );
      print("response: " + response.toString());
      if (response.statusCode == 200) {
        print("Status Code: " + response.statusCode.toString());
        print("Body: " + response.body);
        final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        print("Parsed data: $parsed");
        // aa = parsed
        //     .map<OrderDetailsModel>((json) => OrderDetailsModel.fromJson(json))
        //     .toList();
        // print(aa.toString());
        return parsed
            .map<OrderDetailsModel>((json) => OrderDetailsModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed');
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
