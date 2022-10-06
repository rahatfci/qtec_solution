import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models.dart';

fetchProducts(String searchKey) async {
  if (searchKey.isEmpty) {
    return "Enter the product name to search";
  } else {
    final response = await http.get(Uri.parse(
        'https://panel.supplyline.network/api/product/search-suggestions/?limit=10&offset=10&search=$searchKey'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      Product products = productFromMap(jsonData["data"]["products"]);
      if (products.results.isEmpty) {
        return "Sorry, no product founded with this name";
      }
      return products;
    } else {
      return "Something went wrong";
    }
  }
}

fetchDetails(String slug) async {
  final response = await http.get(
      Uri.parse('https://panel.supplyline.network/api/product-details/$slug/'));
  if (response.statusCode == 200) {
    var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    return detailsFromMap(jsonData["data"]);
  } else {
    return "Something went wrong";
  }
}
