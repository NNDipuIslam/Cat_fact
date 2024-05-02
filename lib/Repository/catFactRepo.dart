// ignore_for_file: file_names

import 'dart:convert';
import 'package:cat_fact/Models/CatFactModel.dart';
import 'package:http/http.dart' as http;

class CatFactRepo {
  static Future<List<CatFactModelUi>> fetchPosts() async {
    var client = http.Client();
    List<CatFactModelUi> posts = [];
    try {
      var response = await client.get(Uri.parse('https://catfact.ninja/fact'));
      if (response.statusCode == 200) {
        // Decode the response directly as it contains a single cat fact
        dynamic result = jsonDecode(response.body);
        // Create a CatFactModelUi object from the response
        CatFactModelUi post = CatFactModelUi.fromJson(result);
        posts.add(post);
      } else {
        // Handle HTTP error
      }
    } finally {
      // Always close the client
      client.close();
    }
    return posts;
  }
}
