import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Questions.dart';
import 'Quiz.dart';

class QuizPrep extends StatefulWidget {
  final String quizName;
  const QuizPrep({Key? key, required this.quizName}) : super(key: key);


  @override
  State<QuizPrep> createState() => _QuizPrepState();
}

class _QuizPrepState extends State<QuizPrep>  {
  Future<List<Questions>>? futureQuestions;


  @override
  void initState() {
    super.initState();
    // Fetch the list of questions when the widget is initialized
    futureQuestions = getRandomQuestions();
  }

  Future<List<Questions>> getRandomQuestions() async {
    try {
      // Get reference to the collection
      CollectionReference collectionRef =
      FirebaseFirestore.instance.collection(widget.quizName);

      // Get documents from the collection
      QuerySnapshot querySnapshot = await collectionRef.get();

      // Convert documents to Question objects
      List<Questions> questions = querySnapshot.docs.map((doc) {
        return Questions(
          doc['Question'],
          List<String>.from(doc['options']),
          doc['CorrectAnswer'],
        );
      }).toList();

      // Shuffle the questions
      questions.shuffle();

      // Ensure unique questions
      List<Questions> uniqueQuestions = [];
      Set<String> questionTexts = Set<String>();

      for (var question in questions) {
        if (!questionTexts.contains(question.question)) {
          uniqueQuestions.add(question);
          questionTexts.add(question.question);
        }
        if (uniqueQuestions.length >= 5) {
          break; // Break once we have enough unique questions
        }
      }

      return uniqueQuestions;
    } catch (e) {
      print('Error fetching random questions: $e');
      return []; // or throw e; depending on your error handling strategy
    }
  }



  @override
  Scaffold build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder<List<Questions>>(
        future: futureQuestions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            // Once questions are loaded, navigate to QuizDisplayPage
            return Center(
                child:ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Quiz(questions: snapshot.data!),
                      ),
                    );
                  },
                  child: Text('Start Quiz'),
                ),
            );
          }
        },
      ),

    );


  }
}
