import 'package:aifer_task/model/quiz_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class QuizProvider extends ChangeNotifier {
  List<QuizQuestionModel> questionsList = [];
  int currentQuestionIndex = 0;
  final String storageKey = 'quiz_progress';
  bool isDataLoading = false;

  QuizQuestionModel get currentQuestion => questionsList[currentQuestionIndex];

  QuizProvider() {
    _initializeQuestions();
    loadProgress();
  }

  void setCurrentQuestionIndex(int index) {
    currentQuestionIndex = index;
    notifyListeners();
  }

  void _initializeQuestions() {
    questionsList = [
      QuizQuestionModel(
        question: "What color is the sky on a clear day?",
        options: ["Red", "Blue", "Green", "Yellow"],
        correctAnswer: 1,
        explanation:
            "The sky appears blue due to the scattering of sunlight by the atmosphere.",
      ),
      QuizQuestionModel(
        question: "What is 2 + 2?",
        options: ["3", "4", "5", "6"],
        correctAnswer: 1,
        explanation: "2 + 2 equals 4.",
      ),
      QuizQuestionModel(
        question: "What is the capital of the United States?",
        options: ["New York", "Washington, D.C.", "Los Angeles", "Chicago"],
        correctAnswer: 1,
        explanation: "Washington, D.C. is the capital of the United States.",
      ),
      QuizQuestionModel(
        question: "Which animal is known as man's best friend?",
        options: ["Cat", "Dog", "Fish", "Bird"],
        correctAnswer: 1,
        explanation:
            "Dogs are often referred to as man's best friend due to their loyalty and companionship.",
      ),
      QuizQuestionModel(
        question: "What is the main ingredient in bread?",
        options: ["Sugar", "Water", "Flour", "Salt"],
        correctAnswer: 2,
        explanation: "Flour is the primary ingredient used to make bread.",
      ),
      QuizQuestionModel(
        question: "What do bees produce?",
        options: ["Honey", "Milk", "Eggs", "Butter"],
        correctAnswer: 0,
        explanation: "Bees produce honey from the nectar of flowers.",
      ),
      QuizQuestionModel(
        question: "What is the largest land animal?",
        options: ["Elephant", "Lion", "Giraffe", "Rhino"],
        correctAnswer: 0,
        explanation: "The African elephant is the largest land animal.",
      ),
      QuizQuestionModel(
        question: "Which planet is known as the Red Planet?",
        options: ["Earth", "Mars", "Jupiter", "Saturn"],
        correctAnswer: 1,
        explanation:
            "Mars is often called the Red Planet because of its reddish appearance.",
      ),
      QuizQuestionModel(
        question: "What is the freezing point of water?",
        options: ["0°C", "32°C", "100°C", "50°C"],
        correctAnswer: 0,
        explanation: "The freezing point of water is 0 degrees Celsius.",
      ),
      QuizQuestionModel(
        question: "Which fruit is known for having seeds on the outside?",
        options: ["Banana", "Apple", "Strawberry", "Orange"],
        correctAnswer: 2,
        explanation:
            "Strawberries are unique because their seeds are on the outside of the fruit.",
      ),
    ];
  }

  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedProgress = prefs.getString(storageKey);
    if (savedProgress != null) {
      final List<dynamic> decoded = json.decode(savedProgress);
      questionsList =
          decoded.map((q) => QuizQuestionModel.fromJson(q)).toList();
      notifyListeners();
    }
  }

  Future<void> saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded =
        json.encode(questionsList.map((q) => q.toJson()).toList());
    await prefs.setString(storageKey, encoded);
  }

  void selectAnswer(int answerIndex) {
    if (!questionsList[currentQuestionIndex].isAnswered) {
      questionsList[currentQuestionIndex].selectedAnswerIndex =
          answerIndex; // Just store the index
      questionsList[currentQuestionIndex].isAnswered = true;
      saveProgress();
      notifyListeners();
    }
  }

  void nextQuestion() {
    if (questionsList.isNotEmpty &&
        currentQuestionIndex < questionsList.length - 1) {
      currentQuestionIndex++;
      notifyListeners();
    } else {
      print("No more questions available.");
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
    }
    notifyListeners();
  }

  // void setDataLoading(bool loading) {
  //   isDataLoading = loading;
  //   notifyListeners();
  // }
}
