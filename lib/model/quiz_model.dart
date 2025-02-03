class QuizQuestionModel {
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;
  int? selectedAnswerIndex; // Changed from String? selectedAnswer
  bool isAnswered;

  QuizQuestionModel({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    this.selectedAnswerIndex, // Updated this line
    this.isAnswered = false,
  });

  Map<String, dynamic> toJson() => {
        'question': question,
        'options': options,
        'correctAnswer': correctAnswer,
        'explanation': explanation,
        'selectedAnswerIndex': selectedAnswerIndex, // Updated this line
        'isAnswered': isAnswered,
      };

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) =>
      QuizQuestionModel(
        question: json['question'],
        options: List<String>.from(json['options']),
        correctAnswer: json['correctAnswer'],
        explanation: json['explanation'],
        selectedAnswerIndex: json['selectedAnswerIndex'], // Updated this line
        isAnswered: json['isAnswered'],
      );
}
