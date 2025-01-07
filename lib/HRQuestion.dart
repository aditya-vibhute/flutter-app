import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HRQuestion extends StatefulWidget {
  List<String> tokens;
  HRQuestion({super.key,required this.tokens});

  @override
  State<HRQuestion> createState() => _HRQuestionState();
}

class _HRQuestionState extends State<HRQuestion> {
  Map<String, List<String>> questionCategories = {
    'Skills': [
      'Can you tell me more about your experience with [specific skill]?',
      'How have you used your technical skills in your previous roles?',
  'What technical skills do you possess that are relevant to this position?',
  'Can you provide examples of projects where you applied these technical skills?',
  'How do you stay updated with the latest technologies and tools in your field?',
  'Have you ever encountered a technical problem that seemed unsolvable? How did you approach it?'
    ],
    'Education': [
      'What motivated you to pursue your degree',
      'How do you think your education has prepared you for this role?',
      'Can you share a challenging project or assignment you worked on during your studies?',
      'Have you pursued any additional courses or training relevant to your career?'
    ],
    'Teamwork': [
        'How do you approach working in a team environment?',
        'Can you give an example of a time when you had to resolve a conflict within a team?',
        'How do you communicate and collaborate with team members to achieve common goals?',
        'What role do you typically take on in a team setting and why?'

  ],
    'Decision Making': [
      'Can you provide an example of a time when you had to make a tough decision under pressure?',
      'What steps do you take to gather information and analyze data before making a decision?'
    ],
    'Communication and Interpersonal Skills': [
  'How do you ensure clear and effective communication with colleagues and clients?',
  'Can you provide an example of a time when you had to communicate complex information to a non-technical audience?',
  'How do you handle constructive criticism or feedback from peers and supervisors?',
  'Can you describe a situation where you had to persuade others to adopt your ideas or proposals?'
    ],
    'Career Goals and Motivation': [
  'What motivated you to apply for this position?',
  'Where do you see yourself professionally in the next 3-5 years?',
  'How does this role align with your long-term career goals?',
  'What aspects of our company culture and values resonate with you the most?',
    ],
    'Problem-Solving': [
      'Describe a situation where you encountered a problem at work and how you resolved it.',
      'How do you approach decision making when faced with multiple options or uncertainties?',
    ],
    'Hobbies': [
  'Can you tell me about some of your hobbies or interests outside of work?',
  'How do you balance your professional life with your hobbies?',
  'Have any of your hobbies provided you with skills or experiences that you have applied in your career?',
  'Can you share a memorable experience or achievement related to one of your hobbies?'
    ],
    'Leadership':[
  'Have you ever taken on a leadership role in a project or team? If so, what was your approach?',
  'How do you motivate and inspire others to achieve their goals?',
  'Can you provide an example of a time when you had to resolve a conflict within a team?',
  'What do you believe are the most important qualities of a good leader, and how do you embody those qualities?'
    ],
    'Sports,cricket,football,chess,kabaddi,kho-kho':[
  'Do you participate in any sports activities? If so, which ones and how often?',
  'How do you think participating in sports has contributed to your personal and professional development?',
  'Have you ever been part of a sports team or club? What role did you play, and how did it impact your teamwork skills?',
  'Can you share an example of a time when you faced a challenge in sports and how you overcame it?',
      'What is current state of sport you often play?'
    ]
    // Add more question categories and questions as needed
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

    return  Scaffold(
      appBar: AppBar(
        title: Text("Suggested HR Questions:",style: TextStyle(fontFamily: 'BebasNeue',fontWeight: FontWeight.bold),),
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
          ))
        ],
      )
    );
  }
}
