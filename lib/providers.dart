import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jsonDataProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  await Future.delayed(const Duration(seconds: 3)); // Задержка 3 секунды
  final String jsonString = await rootBundle.loadString("assets/json/widgets.json");
  return jsonDecode(jsonString);
});
