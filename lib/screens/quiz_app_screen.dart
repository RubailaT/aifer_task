import 'package:aifer_task/constants/text_style_class.dart';
import 'package:aifer_task/provider/quiz_provider.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Title Bar
            _buildTitleBar(),
            SizedBox(height: 20),
            // Question Section
            _buildQuestionSection(quizProvider),
            SizedBox(height: 20),
            // Question Number and Navigation
            _buildQuestionNumberAndNavigation(quizProvider),
            SizedBox(height: 20),
            // Navigation buttons
            _buildNavigationButtons(quizProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleBar() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Text(
        "Quiz Application UI",
        style: TextStyleClass.primaryFont400(20, Colors.red),
      ),
    );
  }

  Widget _buildQuestionNumberAndNavigation(QuizProvider quizProvider) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            spreadRadius: 1,
          ),
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
          _buildQuestionNumberIndicators(quizProvider),
        ],
      ),
    );
  }

  Widget _buildQuestionNumberIndicators(QuizProvider quizProvider) {
    return Wrap(
      spacing: 8,
      children: List.generate(quizProvider.questionsList.length, (index) {
        bool isSelected = index == quizProvider.currentQuestionIndex;
        bool isNext = index == quizProvider.currentQuestionIndex + 1;
        Color containerColor = isSelected
            ? Colors.blue
            : isNext
                ? Colors.red
                : Colors.grey[300]!;
        return Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: containerColor,
          ),
          alignment: Alignment.center,
          child: Text(
            '${index + 1}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNavigationButtons(QuizProvider quizProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: quizProvider.previousQuestion,
          child: Text("Prev"),
        ),
        ElevatedButton(
          onPressed: quizProvider.nextQuestion,
          child: Text("Next"),
        ),
      ],
    );
  }

  Widget answerOption(String answer, int index) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final currentQuestion = quizProvider.currentQuestion;
    bool isSelected = currentQuestion.selectedAnswer == answer;
    bool isCorrect = index == currentQuestion.correctAnswer;

    // Determine the colors and styles based on the answer state
    Color? backgroundColor = Colors.white;
    Color borderColor = Colors.grey[300]!;
    Color textColor = Colors.black;

    if (currentQuestion.isAnswered) {
      if (isCorrect) {
        backgroundColor = Colors.green[100];
        borderColor = Colors.green;
        textColor = Colors.green[900]!;
      } else if (isSelected) {
        backgroundColor = Colors.red[100];
        borderColor = Colors.red;
        textColor = Colors.red[900]!;
      }
    }

    return GestureDetector(
      onTap: currentQuestion.isAnswered
          ? null
          : () {
              quizProvider.selectAnswer(index);
            },
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
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
          children: [
            Expanded(
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: isSelected || isCorrect
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
            if (currentQuestion.isAnswered && (isSelected || isCorrect))
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? Colors.green : Colors.red,
              ),
          ],
        ),
      ),
    );
  }

  // Update the _buildQuestionSection to include the explanation
  Widget _buildQuestionSection(QuizProvider quizProvider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Question ${quizProvider.currentQuestionIndex + 1}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            Divider(thickness: 1),
            SizedBox(height: 16),
            Text(
              "Explanation:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 8),
            Text(
              quizProvider.currentQuestion.explanation,
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue[900],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
