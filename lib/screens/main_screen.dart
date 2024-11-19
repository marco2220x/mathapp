import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para cargar el JSON
import 'package:mathapp/models/topic_data.dart';
import 'package:mathapp/screens/topic_activity_screen.dart';
import 'package:mathapp/widgets/topic_card.dart';
import 'package:mathapp/widgets/reading_card.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<TopicData> topics = [];

  @override
  void initState() {
    super.initState();
    _loadTopics();
  }

  Future<void> _loadTopics() async {
    final String response = await rootBundle.loadString('assets/data/topics.json');
    final data = json.decode(response);
    final List<TopicData> loadedTopics = (data['topics'] as List)
        .map((topicJson) => TopicData.fromJson(topicJson))
        .toList();

    setState(() {
      topics = loadedTopics;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 48.0, left: 16.0, right: 16.0),
              child: Text(
                'MathMaster',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Temas',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 180,
              child: topics.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: topics.length,
                      itemBuilder: (context, index) {
                        final topic = topics[index];
                        return TopicCard(
                          title: topic.title,
                          iconPath: 'assets/images/ic_${topic.title.toLowerCase()}.jpg',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TopicActivityScreen(
                                  topicTitle: topic.title,
                                  activities: topic.activities,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Lecturas Recomendadas',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: readings.length,
                itemBuilder: (context, index) {
                  final reading = readings[index];
                  return ReadingCard(
                    title: reading['title']!,
                    description: reading['description']!,
                    onTap: () {
                      print('Iniciaste: ${reading['title']}');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<Map<String, String>> readings = [
    {'title': 'Introducción a las Matemáticas', 'description': 'Conceptos básicos sobre números y operaciones.'},
    {'title': 'Historia de las Matemáticas', 'description': 'Un recorrido por el desarrollo de las matemáticas.'},
    {'title': 'Matemáticas en la vida diaria', 'description': 'Ejemplos de cómo usamos matemáticas todos los días.'},
  ];
}
