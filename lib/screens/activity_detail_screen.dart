import 'package:flutter/material.dart';
import 'package:mathapp/models/activity_data.dart';

class ActivityDetailScreen extends StatelessWidget {
  final ActivityData activity;

  const ActivityDetailScreen({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(activity.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activity.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Videos:',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            ...activity.videoUrls.map(
              (url) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: InkWell(
                  onTap: () {
                    // Aquí puedes usar un paquete como url_launcher para abrir el enlace
                    print("Abrir video: $url");
                  },
                  child: Text(
                    url,
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
