import 'package:flutter/material.dart';
import 'package:quizler_app/question.dart';
import 'package:quizler_app/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // this is the method to check the correct answer
  void checkAnswer(bool pickedAnswer) {
    bool checkCorrect = quizBrain.getAnswerText();
    setState(() {
      if (quizBrain.isFinished()) {
        // This is an alert Dialog Box code
        Alert(
          context: context,
          type: AlertType.success,
          title: "Quiz Complete",
          desc: "You Quiz is Complete by Clicking on restart you attempt again",
          buttons: [
            DialogButton(
              onPressed: () {
                quizBrain.questionNumber = 0;
                quizBrain.scoreKeeper.clear();
                Navigator.of(context).pop();
              },
              width: 120,
              child: const Text(
                "Restart",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();
        // checking conditions wheather to add correct and wrong icon according to user selection
      } else if (checkCorrect == pickedAnswer) {
        quizBrain.scoreKeeper.add(const Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        quizBrain.scoreKeeper.add(const Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
    });
    setState(() {
      quizBrain.increaseQuestoinNumber(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(children: [...quizBrain.scoreKeeper]),
      ],
    );
  }
}
