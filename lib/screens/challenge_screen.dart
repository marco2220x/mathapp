import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChallengeScreen extends StatefulWidget {
  final int challengeId;

  const ChallengeScreen({Key? key, required this.challengeId}) : super(key: key);

  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  Map<String, dynamic>? currentChallenge;
  int currentProblemIndex = 0;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    _loadChallenge();
  }

  Future<void> _loadChallenge() async {
    final String response = await rootBundle.loadString('assets/data/challenges.json');
    final data = json.decode(response);
    final challenges = data['challenges'] as List<dynamic>;

    setState(() {
      currentChallenge = challenges.firstWhere((challenge) => challenge['id'] == widget.challengeId);
    });
  }

  void _handleAnswer(int selectedOption) {
    final correctOption = currentChallenge!['problems'][currentProblemIndex]['correctOption'];

    if (selectedOption == correctOption) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('¡Correcto!')),

      );

      setState(() {
        if (currentProblemIndex + 1 < currentChallenge!['problems'].length) {
          currentProblemIndex++;
        } else {
          isCompleted = true;
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Incorrecto. Intenta de nuevo.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentChallenge == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Desafío'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final problem = currentChallenge!['problems'][currentProblemIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(currentChallenge!['title']),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, isCompleted); // Pasamos el estado de completado al MainScreen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Pregunta
            Text(
              problem['question'],
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            // Opciones (Grid de 2x2)
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: problem['options'].length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      _handleAnswer(index);
                    },
                    child: Text(
                      problem['options'][index],
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
            // Indicador de progreso
            Text(
              'Problema ${currentProblemIndex + 1} de ${currentChallenge!['problems'].length}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            // Mensaje de completado
            if (isCompleted)
              Text(
                '¡Desafío completado!',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.green, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}

