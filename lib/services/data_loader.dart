import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mathapp/models/topic_data.dart';  // Asegúrate de importar el archivo correcto

Future<List<TopicData>> loadTopics() async {
  final String jsonString = await rootBundle.loadString('assets/data/activities.json');
  final Map<String, dynamic> jsonData = json.decode(jsonString);
  final List<dynamic> topicsJson = jsonData['topics'];

  // Deserializa la lista de temas y crea una lista de TopicData
  return topicsJson.map((topic) => TopicData.fromJson(topic)).toList();
}
