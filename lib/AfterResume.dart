import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/HRQuestion.dart';
import 'package:mini_project/Quiz.dart';
import 'package:mini_project/TechnicalQues.dart';

import 'Questions.dart';

class AfterResume extends StatelessWidget {
  List<String> Tokens;
  final List<Questions> quest;
   AfterResume({super.key,required this.quest,required this.Tokens});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 120,),
            Container(
              height: 170,
              child: Image.asset('assets/images/suggestion.png'),
              
            ),
            SizedBox(height:20 ,),
            Text("Based on Your Resume we Suggest:",style: TextStyle(fontFamily: 'BebasNeue'),),
            Expanded( // Wrap ListView with Expanded
              child: Center(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.only(top: 20, bottom: 0, left: 20, right: 20),
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey,
                          border: Border.all(color: Colors.black,width: 3)
                        ),
                        child: Center(child: Text("Technical Quiz.",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'BebasNeue',fontSize: 20),)),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Quiz(questions: quest)));
                      },
                    ),
                    //SizedBox(height: 30),
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey,
                          border: Border.all(color: Colors.black,width: 3)
                        ),
                        child: Center(child: Text("HR Questions.",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'BebasNeue',fontSize: 20),)),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HRQuestion(tokens: Tokens)));
                      },
                    ),
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.only(top:0,bottom: 20,left: 20,right: 20),
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey,
                            border: Border.all(color: Colors.black,width: 3)
                        ),
                        child: Center(child: Text("Technical Interview Questions.",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'BebasNeue',fontSize: 20),)),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TechnicalQues(tokens: Tokens)));
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
