import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para cargar el JSON
import 'package:mathapp/models/topic_data.dart';
import 'package:mathapp/screens/topic_activity_screen.dart';
import 'package:mathapp/screens/challenge_screen.dart'; // Importar ChallengeScreen
import 'package:mathapp/widgets/topic_card.dart';
import 'package:mathapp/widgets/reading_card.dart';
import 'package:mathapp/widgets/challenge_card.dart'; // Nuevo import

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<TopicData> topics = [];
  int completedChallenges = 0; // Para rastrear desafíos completados
  Set<int> completedChallengeIds = {}; // IDs de desafíos completados

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

  void _handleChallengeTap(int index) async {
    // Si el desafío ya está completado, no hacemos nada
    if (completedChallengeIds.contains(index)) return;

    // Navegamos a la pantalla del desafío
    final wasCompleted = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChallengeScreen(challengeId: index + 1),
      ),
    );

    // Si el desafío se completó, actualizamos el estado
    if (wasCompleted != null && wasCompleted) {
      setState(() {
        completedChallengeIds.add(index);
        completedChallenges++;
      });
    }
  }

  void showExpandedReadingCard(
    BuildContext context, {
    required String title,
    required String description,
    required String videoPath, // Añadimos el videoPath como parámetro
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título completo
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Descripción completa
                Text(
                  description,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                // Simulación del video
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: const Text(
                    "Video Placeholder",
                    style: TextStyle(color: Colors.black45),
                  ),
                ),
                const SizedBox(height: 16),
                // Botón de cierre
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cerrar"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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

            // Sección de Temas
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

            // Sección de Lecturas Recomendadas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Videos',
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
                    videoPath: reading['videoPath']!,
                    onTap: () {
                      showExpandedReadingCard(
                        context,
                        title: reading['title']!,
                        description: reading['description']!,
                        videoPath: reading['videoPath']!, // Aquí pasas el videoPath
                      );
                    },
                  );
                },
              ),
            ),

            // Nueva sección: Desafíos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Desafíos',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Completados: $completedChallenges/${challenges.length}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: challenges.length,
              itemBuilder: (context, index) {
                final challenge = challenges[index];

                return ChallengeCard(
                  title: challenge['title']!,
                  description: challenge['description']!,
                  onTap: () => _handleChallengeTap(index), // Referencia directa a la función
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  final List<Map<String, String>> readings = [
    {'title': 'Introducción a las Matemáticas', 'description': 'Conceptos básicos sobre números y operaciones.', 'videoPath': 'assets/videos/vidHist.mp4'},
    {'title': 'Historia de las Matemáticas', 'description': 'Un recorrido por el desarrollo de las matemáticas.', 'videoPath': 'assets/videos/vidHist.mp4'},
    {'title': 'Matemáticas en la vida diaria', 'description': 'Ejemplos de cómo usamos matemáticas todos los días.', 'videoPath': 'assets/videos/vidHist.mp4'},
  ];

  // Lista de desafíos (simulados)
  final List<Map<String, String>> challenges = [
    {'title': 'Desafío 1: Suma básica', 'description': 'Resuelve 5 problemas de suma.'},
    {'title': 'Desafío 2: Multiplicación', 'description': 'Prueba tus habilidades con multiplicaciones rápidas.'},
    {'title': 'Desafío 3: Problemas mixtos', 'description': 'Combina operaciones y resuelve acertijos matemáticos.'},
  ];
}
