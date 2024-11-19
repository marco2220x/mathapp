import 'package:flutter/material.dart';

class ReadingCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const ReadingCard({
    Key? key,
    required this.title,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180, // Ancho de la tarjeta ajustado
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tarjeta de lectura
            Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 4.0), // Ajustamos margen
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                height: 150, // Altura reducida para evitar desbordamientos
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Imagen de la tarjeta
                    Container(
                      height: 80,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 8),
                    // Título de la lectura
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis, // Corta el texto largo
                    ),
                    const SizedBox(height: 4),
                    // Descripción con recorte
                    Flexible(
                      child: Text(
                        description,
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis, // Corta el texto largo
                        maxLines: 2, // Limita las líneas del texto
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Botón fuera de la tarjeta pero pegado a ella
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onTap,
                icon: const Icon(Icons.play_arrow),
                label: const Text("Iniciar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 40), // Ajuste del tamaño del botón
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
