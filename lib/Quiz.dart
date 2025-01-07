import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/ScorePage.dart';

import 'Questions.dart';

class Quiz extends StatefulWidget {
  final List<Questions> questions;

  const Quiz({Key? key, required this.questions}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int _currentPageIndex = 0;
  int Score = 0;
  late int selectindex;
  List<Color> _optionColors = [
    Colors.black38,
    Colors.black38,
    Colors.black38,
    Colors.black38
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz.'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: _buildQuestionCard(widget.questions[_currentPageIndex]),
            ),
            //SizedBox(height: 9),
            Padding(
              padding: EdgeInsets.only(bottom: 33),
              child: ElevatedButton(
                onPressed: () {
                  if(widget.questions[_currentPageIndex].options[selectindex]==widget.questions[_currentPageIndex].correctAnswer){
                    setState(() {
                      Score=Score+1;
                      print(Score);

                    });
                  }
                  if (_currentPageIndex < (widget.questions.length) - 1) {
                    setState(() {
                      _currentPageIndex = _currentPageIndex + 1;
                      // Reset option colors
                      _optionColors = [
                        Colors.black38,
                        Colors.black38,
                        Colors.black38,
                        Colors.black38
                      ];
                    });
                  }
                  else {
                    if(widget.questions[_currentPageIndex].options[selectindex]==widget.questions[_currentPageIndex].correctAnswer){
                      setState(() {
                        Score=Score+1;
                        print(Score);
                      });
                    }
                    showDialog(
                      context: context,
                      builder: (BuildContext) {
                        return AlertDialog(
                          title: Text("Quiz Finished!"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ScorePage(Score: Score,totScore: widget.questions.length,),
                                  ),
                                );
                              },
                              child: Text("Score Page."),
                            )
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Next'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(Questions question) {
    return Card(
      margin: EdgeInsets.all(30),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 50),
                height: 120,
                child: Image.asset('assets/images/question.png'),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                child: Text(
                  question.question,
                  style: TextStyle(fontSize: 20, fontFamily: 'BebasNeue'),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 35),
            Column(
              children: List.generate(
                question.options.length,
                    (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      // Reset colors
                      _optionColors = [
                        Colors.black38,
                        Colors.black38,
                        Colors.black38,
                        Colors.black38
                      ];
                      // Change color of selected option
                      _optionColors[index] = Colors.green;
                      print(index);
                      selectindex=index;

                      print("Selected otion=$selectindex");
                      print("Correct option=${question.correctAnswer}");
                    });
                  },
                  child: Container(
                    height: 60,
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: _optionColors[index],
                    ),
                    child: Text(
                      question.options[index],
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
