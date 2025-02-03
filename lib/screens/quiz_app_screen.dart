import 'package:aifer_task/constants/color_class.dart';
import 'package:aifer_task/constants/text_style_class.dart';
import 'package:aifer_task/model/quiz_model.dart';
import 'package:aifer_task/provider/quiz_provider.dart';
import 'package:aifer_task/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizAppScreen extends StatefulWidget {
  @override
  _QuizAppScreenState createState() => _QuizAppScreenState();
}

class _QuizAppScreenState extends State<QuizAppScreen> {
  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Consumer<QuizProvider>(builder: (context, snapshot, child) {
          return snapshot.isDataLoading
              ? AppUtils.loadingWidget(context, 50)
              : snapshot.questionsList.isEmpty
                  ? "No Questions Available"
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          // Title Bar
                          buildTitleBar(),
                          SizedBox(height: 20),
                          // Question Section
                          buildQuestionSection(quizProvider),
                          SizedBox(
                            width: 20,
                          ),

                          SizedBox(height: 20),
                        ],
                      ),
                    );
        }),
      ),
    );
  }

  Widget buildTitleBar() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          AppUtils.boxShadow(),
        ],
      ),
      child: Text(
        "Quiz Application UI",
        style: TextStyleClass.primaryFont400(20, Colors.red),
      ),
    );
  }

  Widget buildQuestionNumberAndNavigation(QuizProvider quizProvider) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 300,
      height: 450,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          AppUtils.boxShadow(),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                  "Question ${quizProvider.currentQuestionIndex + 1}/ ${quizProvider.questionsList.length}",
                  style: TextStyle(fontSize: 16)),
              InkWell(
                onDoubleTap: () {},
                child: Text("Need Help?"),
              ),
            ],
          ),
          SizedBox(height: 20),
          buildQuestionNumberIndicators(quizProvider),
        ],
      ),
    );
  }

  Widget buildQuestionNumberIndicators(QuizProvider quizProvider) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(quizProvider.questionsList.length, (index) {
        bool isSelected = index == quizProvider.currentQuestionIndex;
        QuizQuestionModel question = quizProvider.questionsList[index];

        // Determine the indicator color based on the answer status
        Color containerColor;
        if (question.isAnswered) {
          containerColor =
              (question.selectedAnswerIndex == question.correctAnswer)
                  ? Colors.green.shade100
                  : Colors.red.shade200;
        } else {
          containerColor = isSelected ? Colors.blue : Colors.grey[300]!;
        }

        return GestureDetector(
          onTap: () {
            quizProvider.setCurrentQuestionIndex(index);
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: containerColor,
            ),
            alignment: Alignment.center,
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget buildNavigationButtons(QuizProvider quizProvider) {
    return AppUtils.buttonsRow(
        previousOnTap: quizProvider.previousQuestion,
        nextOnTap: quizProvider.nextQuestion);
  }

  Widget answerOption(String answer, int index) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final currentQuestion = quizProvider.currentQuestion;

    bool isSelected = currentQuestion.selectedAnswerIndex == index;
    bool isCorrect = index == currentQuestion.correctAnswer;

    // Default colors
    Color containerColor = Colors.white;
    Color borderColor = Colors.grey[300]!;
    Color textColor = Colors.black;

    if (currentQuestion.isAnswered && isSelected) {
      if (isCorrect) {
        containerColor = Colors.green[50]!;
        borderColor = Colors.green;
        textColor = Colors.green[900]!;
      } else {
        containerColor = Colors.red[50]!;
        borderColor = Colors.red;
        textColor = Colors.red[900]!;
      }
    } else if (currentQuestion.isAnswered && isCorrect) {
      // Show correct answer after wrong selection
      containerColor = Colors.green[50]!;
      borderColor = Colors.green;
      textColor = Colors.green[900]!;
    }

    return GestureDetector(
      onTap: currentQuestion.isAnswered
          ? null
          : () => quizProvider.selectAnswer(index),
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight:
                      isSelected || (currentQuestion.isAnswered && isCorrect)
                          ? FontWeight.bold
                          : FontWeight.normal,
                ),
              ),
            ),
            if (currentQuestion.isAnswered && (isSelected || isCorrect))
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? Colors.green : Colors.red,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget buildQuestionSection(QuizProvider quizProvider) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          AppUtils.boxShadow(),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "Quiz Title",
            style: TextStyleClass.primaryFont400(20, ColorClass.bgColor),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Question ${quizProvider.currentQuestionIndex + 1}",
                      style: TextStyleClass.primaryFont500(20, Colors.black),
                    ),
                    SizedBox(height: 16),
                    Text(
                      quizProvider.currentQuestion.question,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    ...quizProvider.currentQuestion.options.asMap().entries.map(
                          (entry) => answerOption(entry.value, entry.key),
                        ),
                    SizedBox(height: 20),
                    if (quizProvider.currentQuestion.isAnswered) ...[
                      SizedBox(height: 8),
                      buildNavigationButtons(quizProvider),
                      SizedBox(height: 16),
                      Text(
                        "Explanation:",
                        style:
                            TextStyleClass.primaryFont600(18, ColorClass.black),
                      ),
                      SizedBox(height: 8),
                      Text(
                        quizProvider.currentQuestion.explanation,
                        style: TextStyleClass.primaryFont300(
                            15, ColorClass.bgColor),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: 20),
              buildQuestionNumberAndNavigation(quizProvider),
            ],
          ),
        ],
      ),
    );
  }
}
