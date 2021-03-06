import 'package:flutter/material.dart';
import 'package:m8/navigation/navigation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:m8/question/question_brain.dart';

QuestionBrain brain = new QuestionBrain();

class QuizOne extends StatefulWidget {
  const QuizOne({Key? key}) : super(key: key);

  @override
  State<QuizOne> createState() => _QuizOneState();
}

class _QuizOneState extends State<QuizOne> {
  List<Widget> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = brain.getCorrectAnswer(); // getting the correct answer

    setState(() {
      if (brain.isFinished() == true) {
        Alert(context: context, title: 'Fim!', buttons: [
          DialogButton(
              child: Text("Refazer",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              color: Color(0xFF60D45C),
              onPressed: () {
                Navigator.pop(context);
              }),
          DialogButton(
              child: Text("Início",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              color: Color(0xFF60D45C),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavegacaoPage()),
                );
              }),
        ]).show();

        // question number is set to 0 again
        brain.reset();

        scoreKeeper.clear();
        // scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          // navtive method of list to add something
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
            size: 25.0,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
            size: 25.0,
          ));
        }

        brain.getNextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
        title: Text(
          'Lição 1',
          style: TextStyle(color: Color(0xFF60D45C)),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              color: Color(0xFF60D45C),
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                margin: EdgeInsets.all(30),
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Center(
                        child: Text(
                          brain.getQuestionText(),
                          style: TextStyle(fontSize: 21.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: Text('Verdadeiro'),
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Color(0xFF60D45C),
                            onSurface: Colors.grey,
                            textStyle: TextStyle(
                              fontSize: 25.0,
                            )),
                        onPressed: () {
                          checkAnswer(true);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Expanded(
                      child: TextButton(
                        child: Text('Falso'),
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.red.shade400,
                            onSurface: Colors.grey,
                            textStyle: TextStyle(
                              fontSize: 25.0,
                            )),
                        onPressed: () {
                          checkAnswer(false);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: scoreKeeper,
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
