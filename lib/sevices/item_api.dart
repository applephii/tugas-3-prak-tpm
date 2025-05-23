import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugas_3_prak_tpm/models/item_model.dart';

class ItemApi {
  static const String baseUrl = 'https://tpm-api-tugas-872136705893.us-central1.run.app/api/clothes';

  // GET ITEMS (ALL DATA)
  static Future<Map<String, dynamic>> getItems() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load items');
    }
  }

  // GET ITEM BY ID
  static Future<Map<String, dynamic>> getItemById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load item');
    }
  }

  // CREATE ITEM
  static Future<Map<String, dynamic>> createItem(Item item) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(item.toJson()),
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create item');
    }
  }

  // UPDATE ITEM
  static Future<Map<String, dynamic>> updateItem(Item item, id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": item.name,
        "price": item.price,
        "category": item.category,
        "brand": item.brand,
        "sold": item.sold,
        "rating": item.rating,
        "stock": item.stock,
        "yearReleased": item.yearReleased,
        "material": item.material,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update item');
    }
  }

  // DELETE ITEM
  static Future<Map<String, dynamic>> deleteItem(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete item');
    }
  }
  
}