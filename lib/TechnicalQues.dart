import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TechnicalQues extends StatefulWidget {
  List<String> tokens;
  TechnicalQues({super.key,required this.tokens});

  @override
  State<TechnicalQues> createState() => _TechnicalQuesState();
}

class _TechnicalQuesState extends State<TechnicalQues> {
  Map<String, List<String>> questionCategories ={
    'Python': [
  'Explain the difference between list and tuple in Python.',
  'What are decorators in Python and how do they work?',
  'What is the difference between == and is in Python?',
  'How does Python manage memory?',
  'Explain the use of generators in Python.',
  'What is a Python virtual environment and why is it used?',
  'Discuss the difference between append() and extend() methods in Python lists.',
  'Explain the concept of Pythons lambda functions.',
  'Describe the purpose of the __init__ method in Python classes.',
  'How does exception handling work in Python?'
    ],
    'Java':[
  'What is the difference between == and .equals() in Java?',
  'Describe the difference between ArrayList and LinkedList in Java.',
  'Explain the concept of method overloading and method overriding in Java.',
  'What is the purpose of the final keyword in Java?',
  'Discuss the difference between HashMap and HashTable in Java.',
  'Explain the use of the static keyword in Java.',
  'Describe the difference between checked and unchecked exceptions in Java.',
  'What is the purpose of the super keyword in Java?',
  'Discuss the concept of multithreading in Java.',
  'Explain the difference between String and StringBuffer/StringBuilder in Java.'
    ],
    'JavaScript':[
  'Explain the difference between undefined and null in JavaScript.',
  'What are closures in JavaScript and how are they used?',
  'Describe event bubbling and event capturing in JavaScript.',
  'Discuss the concept of prototypal inheritance in JavaScript.',
  'What are promises in JavaScript and how do they work?',
  'Explain the use of arrow functions in JavaScript.',
  'What is the purpose of the this keyword in JavaScript?',
  'Describe the differences between == and === operators in JavaScript.',
  'Discuss the concept of hoisting in JavaScript.',
  'How does asynchronous programming work in JavaScript?',
    ],
    'Data Structures':[
  'Discuss the difference between arrays and linked lists.',
  'What is a stack and how is it implemented?',
  'Describe the concept of a binary search tree (BST).',
  'Explain the difference between breadth-first search (BFS) and depth-first search (DFS).',
  'What is the time complexity of various operations in a binary heap?',
  'Discuss the concept of hashing and hash tables.',
  'Describe the difference between a queue and a priority queue.',
  'Explain the concept of balanced vs unbalanced trees.',
  'What is the purpose of a trie data structure?',
  'Discuss the advantages and disadvantages of various data structures.',
    ],
    'Database':[
      'What is normalization and why is it important in database design?',
      'Explain the difference between SQL and NoSQL databases.',
      'Discuss the ACID properties of database transactions.',
      'Describe the purpose of primary keys and foreign keys in relational databases.',
      'What is indexing and how does it improve database performance?',
      'Discuss the differences between inner join, outer join, and cross join in SQL.',
      'Explain the concept of database transactions and isolation levels.',
      'What are stored procedures and how are they used in databases?',
      'Describe the difference between clustered and non-clustered indexes.',
      'What is denormalization and when is it appropriate to use?',
    ],
    'C':[
  'Explain the difference between #include <filename> and #include "filename" in C.',
  'What is the purpose of volatile keyword in C?',
  'Describe the difference between malloc() and calloc() functions in C.',
  'Explain the difference between ++i and i++ in C.',
  'What is a pointer in C? How is it different from an array?',
  'Discuss the concept of bitwise operators in C.',
  'What is a structure in C? How is it different from a union?',
  'Explain the purpose of const keyword in C.',
  'Describe the use of typedef keyword in C.',
  'How does recursion work in C? Provide an example.',
    ],
    'C++':[
  'Discuss the differences between C and C++.',
  'What is object-oriented programming (OOP) and how is it implemented in C++?',
  'Explain the concept of constructor and destructor in C++.',
  'Describe the difference between pass by value and pass by reference in C++.',
  'Discuss the difference between inheritance and composition in C++.',
  'What is polymorphism in C++? Provide examples.',
  'Explain the use of virtual functions in C++.',
  'What is an abstract class in C++? How is it different from an interface?',
  'Describe the concept of templates in C++.',
  'Discuss the advantages and disadvantages of using C++ over other programming languages.'
    ]
  };
  @override
  Widget build(BuildContext context) {
    List<String> questionsToAsk = [];
    for (String token in widget.tokens) {
      for (String category in questionCategories.keys) {
        if (token.contains(category.toLowerCase())) {
          List<String> categoryQuestions = questionCategories[category]!;
          questionsToAsk.addAll(categoryQuestions);
          questionsToAsk.shuffle();

        }
      }
    }

    questionsToAsk = questionsToAsk.take(10).toList();
    return Scaffold(

        appBar: AppBar(
          title: Text("Suggested Interview Questions:",style: TextStyle(fontFamily: 'BebasNeue',fontWeight: FontWeight.bold),),
        ),
        body: Column(
          children: [
            Expanded(
                child: Center(
                    child: ListView.builder(
                        itemCount: questionsToAsk.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(questionsToAsk[index],
                                style: TextStyle(
                                    fontFamily: 'BebasNeue',
                                    fontSize: 18
                                ),
                              ),
                              contentPadding: EdgeInsets.all(20),
                              // Add more customization to the ListTile as needed
                            ),
                          );
                        }
                    )
                )
            )
          ],
        )
    );
  }
}
