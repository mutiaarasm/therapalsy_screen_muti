import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/home_graphics.dart';

Future<HomeGraphicsData> fetchHomeGraphicsData() async {
  final response = await http.get(
    Uri.parse('https://huggingface.co/spaces/mutiarasm/visualisasi?json'),
  );
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return HomeGraphicsData.fromJson(data);
  } else {
    throw Exception('Failed to load home graphics data');
  }
}
