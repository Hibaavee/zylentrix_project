import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Map<String, String>>> fetchPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((post) => {
        'title': post['title'] as String,
        'body': post['body'] as String,
      }).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}