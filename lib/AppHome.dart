import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:mini_project/CPPQuiz.dart';
import 'package:mini_project/FilePicker.dart';
import 'package:mini_project/ResumeBasedQ.dart';
import 'package:mini_project/TextExtract.dart';
import 'package:mini_project/main.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';


class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  var titles=["Java","CPP","C Language","Python"];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: Column(
        children:<Widget> [
          Container(
            height: 380,
            //color: Colors.black12,
            decoration: const BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              boxShadow: [BoxShadow(
                blurRadius: 5,
                spreadRadius: 3,
                offset: Offset(0,3),
                color: Colors.black12
              )]
            ),
            child:Column(
              children: <Widget>[
                SizedBox(
                  height: 130,

                  child: Row(
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.only(top: 75,left: 30,bottom: 10),
                      child: Container(
                        //color: Colors.black,
                          height: 80,
                          decoration:const BoxDecoration (
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: IconButton(
                            onPressed: () {  },
                            icon: const Icon(Icons.person,
                            size: 30,),
                          ),
                      ),
                      ),

                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets
                                  .only(top: 60,right: 165,bottom: 0),
                                  child: const Text("Welcome!!",textAlign: TextAlign.left,style: TextStyle(fontSize: 11,fontFamily: "BebasNeue"),),
                                ),
                                Container(
                                  margin: const EdgeInsets
                                      .only(right: 122,top: 0),
                                  child: const Text("Student...",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,fontFamily: "BebasNeue"),)
                                ),
                              ],
                            )
                          ),

                      )
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50,left: 20,right: 20,bottom: 20),
                  child: Container(
                    height: 110,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white12,
                      width: 3,),
                      color: Colors.black26,
                    ),
                      child: Center(
                        child: IconButton(onPressed: ()async{
                            Filepicker fp=Filepicker();
                            File? resume=await fp.selectFile();
                            if(resume!=null){
                              Uint8List bytes = await resume.readAsBytes();
                              final PdfDocument document = PdfDocument(inputBytes: bytes);
                              String Content = PdfTextExtractor(document).extractText();
                              print(Content);
                              document.dispose();
                              //TextExtracted txt=const TextExtracted();
                              // txt.printLongString(content);
                              Navigator.push(context, MaterialPageRoute(builder:(content)=>RelativeQues(txt:Content,)));

                            }

                        }, icon: const Icon(Icons.file_upload_rounded,size: 50,color: Colors.white,shadows: [Shadow(color: Colors.black,blurRadius: 5,offset: Offset(0,5))],),),
                        ),
                      ),
                  )
                  ),
                
                
                  const Padding(padding: EdgeInsets.all(5),
                  child: Text("Upload your Resume here.",style: TextStyle(fontFamily: "BebasNeue",shadows:<Shadow>[
                    Shadow(blurRadius: 7,color: Colors.black26,offset: Offset(0,3))
                      ]
                    ),
                  ),
                  )
              ],
            ) ,
          ),
          Container(
            height: 95,
            child: Center(
              child: Container(
                padding: EdgeInsets.only(top: 60,bottom: 10),
                child: Text("Jump directly to Specific Quiz:",style: TextStyle(fontFamily: 'BebasNeue',fontSize: 18,shadows: [Shadow(blurRadius: 3,offset: Offset(5,5),color: Colors.black26)]),),
              )
            ),
          ),
          Container(
            height: 300,
            padding: EdgeInsets.all(20),
            child: CardSwiper(
              cardBuilder: (
                  BuildContext context,
                  int index,
                  int horizontalOffsetPercentage,
                  int verticalOffsetPercentage) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(
                      blurRadius: 6,spreadRadius: 6,offset: Offset(0,6),color: Colors.black26
                    )]
                  ),
                  height: 500,width: 400,
                  child: Padding(padding: EdgeInsets.only(top: 20),
                  child:InkWell(
                    onTap: (){
                      if(index==0){
                        String name="Quiz0";
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>QuizPrep(quizName: name)));
                      }
                      if(index==1){
                        String name="Quiz";
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>QuizPrep(quizName: name,)));
                      }
                      if(index==2){
                        String name="Quiz1";
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>QuizPrep(quizName: name)));
                      }
                      if(index==3){
                        String name="Quiz2";
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>QuizPrep(quizName: name)));
                      }
                    },

                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                          ),
                          Text(titles[index],style: TextStyle(fontSize: 20,fontFamily: 'BebasNeue',fontWeight: FontWeight.bold,shadows: [Shadow(color: Colors.black12)]),),
                          Text("Number Of Questions = 20",style: TextStyle(fontSize: 13,fontFamily: 'BebasNeue'),),
                          Text("Duration=20 Minutes",style: TextStyle(fontSize: 13,fontFamily: 'BebasNeue'),),
                      ]
                      )
                    ),

                  ) ,
                  )
                );
              },
              cardsCount: 4,
              allowedSwipeDirection: AllowedSwipeDirection.all(),
            )
          )
          ,
          Padding(padding: EdgeInsets.only(left: 310,top: 85),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.black45),
              boxShadow: [BoxShadow(
                blurRadius: 4,
                color: Colors.black45,offset: Offset(5,5)
              )]
            ),
            child: IconButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            }, icon: Icon(Icons.logout),),
          ),
          )

        ],
      ),

    );
  }
}
