// lib/models/quiz_question.dart
// import 'dart:convert';

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;
  String? selectedAnswer;
  bool isAnswered;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    this.selectedAnswer,
    this.isAnswered = false,
  });

  Map<String, dynamic> toJson() => {
        'question': question,
        'options': options,
        'correctAnswer': correctAnswer,
        'explanation': explanation,
        'selectedAnswer': selectedAnswer,
        'isAnswered': isAnswered,
      };

  factory QuizQuestion.fromJson(Map<String, dynamic> json) => QuizQuestion(
        question: json['question'],
        options: List<String>.from(json['options']),
        correctAnswer: json['correctAnswer'],
        explanation: json['explanation'],
        selectedAnswer: json['selectedAnswer'],
        isAnswered: json['isAnswered'],
      );
}
