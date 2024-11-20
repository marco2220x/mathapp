import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:mathapp/models/activity_data.dart';

class ActivityDetailScreen extends StatelessWidget {
  final ActivityData activity;
  final int currentIndex;
  final List<ActivityData> activities;

  const ActivityDetailScreen({
    Key? key,
    required this.activity,
    required this.currentIndex,
    required this.activities,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(activity.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Descripción principal
              Text(
                activity.description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // Sección de ecuaciones
              if (activity.equations.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Centrar en el eje horizontal
                  children: [
                    const SizedBox(height: 8),
                    ...activity.equations.map(
                      (equation) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Center( // Centrar cada ecuación
                          child: Math.tex(
                            equation,
                            textStyle: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 16),

              // Sección de contenido (todo dentro de un mismo cuadro)
              if (activity.content != null && activity.content!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detalles:',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      color: Colors.grey[200], // Fondo claro para el cuadro
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2, 
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: activity.content!.map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                " $item",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),

      // Botón para avanzar a la siguiente actividad
      floatingActionButton: currentIndex < activities.length - 1
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActivityDetailScreen(
                      activity: activities[currentIndex + 1],
                      currentIndex: currentIndex + 1,
                      activities: activities,
                    ),
                  ),
                );
              },
              backgroundColor: Colors.blue,
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
