import 'package:flutter/material.dart';
import 'package:mathapp/models/activity_data.dart';
import 'package:mathapp/screens/activity_detail_screen.dart';

class TopicActivityScreen extends StatelessWidget {
  final String topicTitle;
  final List<ActivityData> activities;

  const TopicActivityScreen({
    Key? key,
    required this.topicTitle,
    required this.activities,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topicTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final activity = activities[index];

            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                leading: Icon(
                  Icons.circle,
                  color: Colors.blue,
                  size: 16,
                ),
                title: Text(
                  activity.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActivityDetailScreen(
                          activity: activity,
                          currentIndex: index, // Índice actual de la actividad
                          activities: activities, // Lista completa de actividades
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
