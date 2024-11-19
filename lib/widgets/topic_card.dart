import 'package:flutter/material.dart';

class TopicCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  const TopicCard({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Container(
          width: 120, // Ancho de la tarjeta
          height: 160, // Altura ajustada
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                height: 80, // Ajustar altura de la imagen
                width: 80, // Ajustar ancho de la imagen
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14, // Tamaño ajustado del texto
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
