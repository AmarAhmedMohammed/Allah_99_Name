import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../models/allah_name.dart';
import '../providers/names_provider.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  List<Question> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  bool _isAnswered = false;
  int? _selectedAnswerId;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generateQuestions();
    });
  }

  void _generateQuestions() {
    final namesProvider = context.read<NamesProvider>();
    final allNames = namesProvider.allNames;

    if (allNames.isEmpty) {
      setState(() => _isLoading = false);
      return;
    }

    final random = Random();
    final List<Question> newQuestions = [];

    // Generate 10 random questions
    for (int i = 0; i < 10; i++) {
      // Pick a random correct answer
      final correctName = allNames[random.nextInt(allNames.length)];

      // Pick 3 unique distractors
      final Set<int> usedIds = {correctName.id};
      final List<AllahName> choices = [correctName];

      while (choices.length < 4) {
        final distractor = allNames[random.nextInt(allNames.length)];
        if (!usedIds.contains(distractor.id)) {
          choices.add(distractor);
          usedIds.add(distractor.id);
        }
      }

      // Shuffle choices
      choices.shuffle();

      newQuestions.add(Question(correctName: correctName, choices: choices));
    }

    setState(() {
      _questions = newQuestions;
      _isLoading = false;
    });
  }

  void _handleAnswer(int selectedId) {
    if (_isAnswered) return;

    final isCorrect = selectedId == _questions[_currentIndex].correctName.id;

    setState(() {
      _isAnswered = true;
      _selectedAnswerId = selectedId;
      if (isCorrect) _score++;
    });

    // Show feedback snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isCorrect ? 'Correct! MashaAllah' : 'Incorrect',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _isAnswered = false;
        _selectedAnswerId = null;
      });
    } else {
      _showSummaryDialog();
    }
  }

  void _showSummaryDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Practice Complete'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Your Score:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text(
              '$_score / ${_questions.length}',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.gold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to home
            },
            child: const Text('Home'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 0;
                _score = 0;
                _isAnswered = false;
                _selectedAnswerId = null;
                _isLoading = true;
              });
              _generateQuestions();
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Practice')),
        body: const Center(child: Text('No names available to practice.')),
      );
    }

    final currentQuestion = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${_currentIndex + 1}/${_questions.length}'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'Score: $_score',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingLG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Question Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusLG),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.paddingXL),
                child: Column(
                  children: [
                    const Text(
                      'What is the name for:',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: AppSizes.paddingLG),
                    Text(
                      currentQuestion.correctName.meaningEn,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSizes.paddingMD),
                    Text(
                      currentQuestion.correctName.meaningAm,
                      style: const TextStyle(
                        fontSize: 20,
                        color: AppColors.gold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSizes.paddingXL),

            // Choices Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSizes.paddingMD,
                  mainAxisSpacing: AppSizes.paddingMD,
                  childAspectRatio: 1.2,
                ),
                itemCount: currentQuestion.choices.length,
                itemBuilder: (context, index) {
                  final choice = currentQuestion.choices[index];
                  final isSelected = _selectedAnswerId == choice.id;
                  final isCorrect = choice.id == currentQuestion.correctName.id;

                  Color? cardColor;
                  if (_isAnswered) {
                    if (isCorrect) {
                      cardColor = Colors.green.withOpacity(0.2);
                    } else if (isSelected) {
                      cardColor = Colors.red.withOpacity(0.2);
                    }
                  }

                  Color borderColor = Colors.transparent;
                  if (_isAnswered) {
                    if (isCorrect) {
                      borderColor = Colors.green;
                    } else if (isSelected) {
                      borderColor = Colors.red;
                    }
                  }

                  return InkWell(
                    onTap: () => _handleAnswer(choice.id),
                    borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                    child: Container(
                      decoration: BoxDecoration(
                        color: cardColor ?? Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                        border: Border.all(
                          color: _isAnswered
                              ? borderColor
                              : (Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.borderDark
                                    : AppColors.borderLight),
                          width: _isAnswered && (isCorrect || isSelected)
                              ? 2
                              : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            choice.arabic,
                            style: GoogleFonts.amiri(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Next Button
            if (_isAnswered)
              Padding(
                padding: const EdgeInsets.only(top: AppSizes.paddingLG),
                child: ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    _currentIndex < _questions.length - 1
                        ? 'Next Question'
                        : 'Finish',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final AllahName correctName;
  final List<AllahName> choices;

  Question({required this.correctName, required this.choices});
}
