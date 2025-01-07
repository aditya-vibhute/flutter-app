// Import required libraries
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/AfterResume.dart';
import 'package:mini_project/HRQuestion.dart';
import 'package:mini_project/Questions.dart';
import 'package:english_words/english_words.dart' as english_words;

import 'Quiz.dart';

// Define the StatefulWidget class
class RelativeQues extends StatefulWidget {
  final String txt;

  RelativeQues({Key? key, required this.txt}) : super(key: key);

  @override
  State<RelativeQues> createState() => _RelativeQuesState();
}

// Define the State class
class _RelativeQuesState extends State<RelativeQues> {
  // Declare a future to fetch questions
  late Future<List<Questions>> futureQuestions;
  late List<String> tokens;
  late Future<List<Questions>>  relatedQuestions;

  @override
  void initState(){
    super.initState();
    futureQuestions = getRandomQuestions();
  }

  List<String> castDynamicListToStringList(List<dynamic> dynamicList) {
    return dynamicList.map((e) => e.toString()).toList();
  }
  // Define a method to fetch random questions
  Future<List<Questions>> getRandomQuestions() async {
    try {
      // Get references to the collections
      CollectionReference collectionRefJava =
      FirebaseFirestore.instance.collection('Quiz0');
      CollectionReference collectionRefCPP =
      FirebaseFirestore.instance.collection('Quiz');
      CollectionReference collectionRefC =
      FirebaseFirestore.instance.collection('Quiz1');
      CollectionReference collectionRefPython =
      FirebaseFirestore.instance.collection('Quiz2');

      // Fetch documents from each collection
      QuerySnapshot querySnapshotJava = await collectionRefJava.get();
      QuerySnapshot querySnapshotCPP = await collectionRefCPP.get();
      QuerySnapshot querySnapshotC = await collectionRefC.get();
      QuerySnapshot querySnapshotPython = await collectionRefPython.get();

      // Define a list to store questions
      List<Questions> questions = [];

      // Add questions from each collection to the list
      questions.addAll(querySnapshotJava.docs.map((doc) {
        return Questions(
          doc['Question'],
          List<String>.from(doc['options']), // Cast options to List<String>
          doc['CorrectAnswer'],
        );
      }));

      questions.addAll(querySnapshotCPP.docs.map((doc) {
        return Questions(
          doc['Question'],
          List<String>.from(doc['options']), // Cast options to List<String>
          doc['CorrectAnswer'],
        );
      }));

      questions.addAll(querySnapshotC.docs.map((doc) {
        return Questions(
          doc['Question'],
          List<String>.from(doc['options']), // Cast options to List<String>
          doc['CorrectAnswer'],
        );
      }));

      questions.addAll(querySnapshotPython.docs.map((doc) {
        return Questions(
          doc['Question'],
          List<String>.from(doc['options']), // Cast options to List<String>
          doc['CorrectAnswer'],
        );
      }));

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
      }
      return uniqueQuestions;
    } catch (e) {
      print('Error fetching random questions: $e');
      return []; // or throw e; depending on your error handling strategy
    }
  }

  // Define a method to remove stop words and tokenize the string
  List<String> removeStopWordsAndTokenize(String userParagraph) {
    // Split the user paragraph into individual words
    List<String> userWords = userParagraph.toLowerCase().split(' ');

    // Remove stop-words and tokenize the string
    List<String> tokens = userWords.where((word) {
      return !english_words.all.contains(word);
    }).toList();
    print(tokens);
    return tokens;
  }

  Future<List<Questions>> fetchRelatedQuestions(List<String> tokens, Future<List<Questions>> questionListFuture) async {
    List<Questions> relatedQuestions = [];

    // Wait for the future to complete and then get the list of questions
    List<Questions> questionList = await questionListFuture;

    for (Questions question in questionList) {
      String questionText = question.question.toLowerCase();
      List<String> optionsText = question.options.map((option) => option.toLowerCase()).toList();
      String correctOption = question.correctAnswer.toLowerCase();

      // Check if any token matches the question text, options, or correct option
      if (tokens.any((token) =>
      questionText.contains(token.toLowerCase()) ||
          optionsText.any((option) => option.contains(token.toLowerCase())) ||
          token.toLowerCase() == correctOption)) {
        relatedQuestions.add(question);
      }

      if (relatedQuestions.length == 10) {
        break;
      }
    }
    return relatedQuestions;
  }


  // Override the build method
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
              child:Column(
                children: [
                  SizedBox(height: 300,),
                  Container(
                    padding: EdgeInsets.all(15),
                    height: 200,
                    child: Image.asset('assets/images/almostThere.png',scale: 1.5,),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: ElevatedButton(
                      onPressed: () async {
                        tokens = removeStopWordsAndTokenize(widget.txt);
                        relatedQuestions=fetchRelatedQuestions(tokens, futureQuestions);
                        List<Questions> relQues=await relatedQuestions;
                        HRQuestion(tokens: tokens);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AfterResume(quest: relQues, Tokens: tokens)));
                      },
                      child: Text('Tap to Continue..'),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),

    );
  }

}
