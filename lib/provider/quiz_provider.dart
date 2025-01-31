import 'package:aifer_task/model/quiz_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class QuizProvider extends ChangeNotifier {
  List<QuizQuestion> questionsList = [];
  int currentQuestionIndex = 0;
  final String storageKey = 'quiz_progress';
  List<bool> selectedOptions = [false, false, false, false];
  List<int> selectedOptionList = [];

  // List<QuizQuestion> get questions => questionsList;
  // int get currentQuestionIndex => _currentQuestionIndex;
  QuizQuestion get currentQuestion => questionsList[currentQuestionIndex];

  QuizProvider() {
    _initializeQuestions();
    loadProgress();
  }

  void _initializeQuestions() {
    questionsList = [
      QuizQuestion(
        question: "What is the capital of France?",
        options: ["London", "Berlin", "Paris", "Madrid"],
        correctAnswer: 2,
        explanation: "Paris is the capital and largest city of France.",
      ),
      QuizQuestion(
        question: "Who painted the Mona Lisa?",
        options: [
          "Vincent van Gogh",
          "Pablo Picasso",
          "Leonardo da Vinci",
          "Michelangelo"
        ],
        correctAnswer: 2,
        explanation:
            "The Mona Lisa is a famous painting created by the Italian Renaissance artist Leonardo da Vinci.",
      ),
      QuizQuestion(
        question: "What is the largest planet in our solar system?",
        options: ["Mars", "Jupiter", "Saturn", "Neptune"],
        correctAnswer: 1,
        explanation:
            "Jupiter is the largest planet in our solar system, with a diameter of approximately 142,984 km.",
      ),
      QuizQuestion(
        question: "What is the currency used in the United Kingdom?",
        options: ["Euro", "Pound Sterling", "US Dollar", "Yen"],
        correctAnswer: 1,
        explanation:
            "The currency used in the United Kingdom is the Pound Sterling (£).",
      ),
      QuizQuestion(
        question: "What is the tallest mammal in the world?",
        options: ["Elephant", "Giraffe", "Rhinoceros", "Hippopotamus"],
        correctAnswer: 1,
        explanation:
            "The giraffe is the tallest living terrestrial animal, with males reaching up to 5.7 meters (18.7 feet) in height.",
      ),
      QuizQuestion(
        question: "What is the smallest country in the world by land area?",
        options: ["Vatican City", "Monaco", "Nauru", "Tuvalu"],
        correctAnswer: 0,
        explanation:
            "Vatican City is the smallest internationally recognized independent state in the world, with an area of just 0.17 square miles (0.44 square kilometers).",
      ),
      QuizQuestion(
        question: "What is the largest ocean in the world?",
        options: [
          "Atlantic Ocean",
          "Indian Ocean",
          "Arctic Ocean",
          "Pacific Ocean"
        ],
        correctAnswer: 3,
        explanation:
            "The Pacific Ocean is the largest of the world's five oceans, covering an area of approximately 63 million square miles (163 million square kilometers).",
      ),
      QuizQuestion(
        question: "Who is the current President of the United States?",
        options: [
          "Donald Trump",
          "Joe Biden",
          "Barack Obama",
          "Hillary Clinton"
        ],
        correctAnswer: 1,
        explanation:
            "Joe Biden is the current President of the United States, having assumed office on January 20, 2021.",
      ),
      QuizQuestion(
        question: "What is the tallest mountain in the world?",
        options: ["K2", "Everest", "Kangchenjunga", "Lhotse"],
        correctAnswer: 1,
        explanation:
            "Mount Everest, located on the border of Nepal and Tibet, is the highest mountain in the world, with a peak elevation of 29,032 feet (8,849 meters).",
      ),
      QuizQuestion(
        question: "What is the name of the largest mammal on Earth?",
        options: [
          "African Elephant",
          "Blue Whale",
          "Sperm Whale",
          "Humpback Whale"
        ],
        correctAnswer: 1,
        explanation:
            "The blue whale is the largest mammal on Earth, with adult individuals reaching lengths of up to 30 meters (98 feet) and weighing up to 190 metric tons.",
      ),
    ];
  }

  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedProgress = prefs.getString(storageKey);
    if (savedProgress != null) {
      final List<dynamic> decoded = json.decode(savedProgress);
      questionsList = decoded.map((q) => QuizQuestion.fromJson(q)).toList();
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
    if (questionsList[currentQuestionIndex].isAnswered) return;

    questionsList[currentQuestionIndex].selectedAnswer =
        questionsList[currentQuestionIndex].options[answerIndex];
    questionsList[currentQuestionIndex].isAnswered = true;

    saveProgress();
    notifyListeners();
  }

  void goToQuestion(int index) {
    if (index >= 0 && index < questionsList.length) {
      currentQuestionIndex = index;
      notifyListeners();
    }
  }

  void nextQuestion() {
    // submitAnswer(context, currentQuestionIndex);
    if (currentQuestionIndex < questionsList.length - 1) {
      currentQuestionIndex++;
      resetOptions();
      if (selectedOptionList[currentQuestionIndex] != -1) {
        selectedOptions[selectedOptionList[currentQuestionIndex]] = true;
      }
    }
    notifyListeners();
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      resetOptions();
      if (selectedOptionList[currentQuestionIndex] != -1) {
        selectedOptions[selectedOptionList[currentQuestionIndex]] = true;
      }
    }
    notifyListeners();
  }

  void resetOptions() {
    selectedOptions = [false, false, false, false];
  }
}
