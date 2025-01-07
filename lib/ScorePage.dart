import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/AppHome.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ScorePage extends StatefulWidget {
  final int Score;
  final int totScore;
  const ScorePage({Key? key,required this.Score,required this.totScore}) : super(key: key);

  @override
  State<ScorePage> createState() => _ScorePageState(EndScore:  Score,total: totScore);

}

class _ScorePageState extends State<ScorePage> {
  int EndScore;
  int total;
   _ScorePageState({Key? key,required this.EndScore,required this.total});


  @override
  Widget build(BuildContext context) {
    var percentage=(EndScore/total);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 330,),
            Center(
              child: new CircularPercentIndicator(
                  radius: 100,
                lineWidth: 10,
                percent: percentage,
                center: Text("% Score:${(percentage*100).toString()}%"),
                progressColor: Colors.green,
              )
            ),
            SizedBox(height: 20,),
            Center(
              child: Text("Total Score: $EndScore"),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AppHome()),
                  );
                },
                child:Text("Home")
              ),
            ),
          ],
        ),
      ),
    );
  }
}
