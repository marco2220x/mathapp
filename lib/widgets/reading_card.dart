import 'package:flutter/material.dart';
import 'package:mathapp/widgets/expanded_reading_card.dart';  // Importar el nuevo widget

class ReadingCard extends StatelessWidget {
  final String title;
  final String description;
  final String videoPath; // Ruta al video
  final VoidCallback onTap;

  const ReadingCard({
    Key? key,
    required this.title,
    required this.description,
    required this.videoPath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showExpandedReadingCard(
        context,
        title: title,
        description: description,
        videoPath: videoPath,
      ),
      child: Container(
        width: 180,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 4.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Flexible(
                      child: Text(
                        description,
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showExpandedReadingCard(
                  context,
                  title: title,
                  description: description,
                  videoPath: videoPath,
                ),
                icon: const Icon(Icons.play_arrow),
                label: const Text("Iniciar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExpandedReadingCard(
    BuildContext context, {
    required String title,
    required String description,
    required String videoPath,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ExpandedReadingCard(
          title: title,
          description: description,
          videoPath: videoPath,
        );
      },
    );
  }
}
