import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_project/AppHome.dart';
import 'package:mini_project/FireBaseAuth.dart';

class NewAccount extends StatelessWidget {
   NewAccount({super.key});

  final _ControllerFname= TextEditingController();
  final _ControllerLname=TextEditingController();
  final _ControllerEmail=TextEditingController();
  final _ControllerMob=TextEditingController();
  final _ControllerPass=TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        title: const Text("User Registration",style: TextStyle(fontFamily: 'BebasNeue',fontWeight: FontWeight.bold, shadows: <Shadow>[Shadow(blurRadius: 5,color: Colors.white)]),),
      ),
      drawer: const Text(""),
      body:Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              margin: const EdgeInsets.only(top: 50,bottom: 10,left: 70,right: 70),
              child: Center(child:Image.asset('assets/images/newuser.png'),)
            ),
            Container(
              child: const Text("Fill the following details: ",style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 165,
                    height: 30,
                    margin: const EdgeInsets.only(top: 40,left: 25,right: 25,bottom: 00),
                    child: const Text("1) Enter First Name:"),
                  ),
                  Container(
                    width: 165,
                    height: 30,
                    margin: const EdgeInsets.only(top: 40,left: 25,right: 25,bottom: 0),
                    child: const Text("2) Enter Last Name:"),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(top: 0,left: 20,right: 25,bottom: 10),
                  child:SizedBox(
                      width: 165,
                      height: 45,
                      child: TextField(
                        controller: _ControllerFname,
                        decoration: InputDecoration(

                          label: const Text("First Name"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                            )
                        ),

                      )
                  ) ,
                  )
                  ,
                  Padding(padding: const EdgeInsets.only(top: 0,left: 24,right: 25,bottom: 10),
                    child:SizedBox(
                        width: 165,
                        height: 45,
                        child: TextField(
                          controller: _ControllerLname,
                          decoration: InputDecoration(
                              label: const Text("Last Name"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)
                              )
                          ),

                        )
                    ) ,
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(right: 280,left: 20,top: 20),
                  child: Container(
                    child: const Text("3) Enter email ID:"),
                  ),
                  ),
                  Padding(padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      height: 49,
                      child:TextField(
                        controller: _ControllerEmail,
                        decoration: InputDecoration(
                          suffixText: ("@gmail.com"),
                          label: const Text("Email ID"),
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                          )
                        ),
                      )
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(right: 280,left: 20,top: 20),
                    child: Container(
                      child: const Text("4) Mobile Number:"),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(20),
                    child: SizedBox(
                        height: 49,
                        child:TextField(
                          controller: _ControllerMob,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(

                              label: const Text("Mobile Number"),
                              border:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                              )

                          ),
                        )
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(right: 260,left: 20,top: 20),
                    child: Container(
                      child: const Text("5) Create Password:"),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(20),
                    child: SizedBox(
                        height: 49,
                        child:TextField(
                          controller: _ControllerPass,
                          decoration: InputDecoration(
                              label: const Text("Password"),
                              border:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)
                              )
                          ),
                        )
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(25),
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    String firstName = _ControllerFname.text;
                  String lastName = _ControllerLname.text;
                  String email = _ControllerEmail.text;
                  String mobileNumber = _ControllerMob.text;
                  String password = _ControllerPass.text;
                  if(firstName.isEmpty){
                    showDialog(
                        context: context,
                        builder:(BuildContext){
                        return AlertDialog(
                          title: const Text("Name field is empty"),
                          content: const Text("Please fill all the fields"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.of(context).pop();
                            }, child: const Text("ok"))
                          ],

                        );
                    }

                    );
                  }else if(lastName.isEmpty){
                      showDialog(
                          context: context,
                          builder:(BuildContext){
                            return AlertDialog(
                              title: const Text("Last Name field is empty"),
                              content: const Text("Please fill all the fields"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: const Text("ok"))
                              ],

                            );
                          }

                      );
                    }else if(email.isEmpty){
                      showDialog(
                          context: context,
                          builder:(BuildContext){
                            return AlertDialog(
                              title: const Text("Email field is empty"),
                              content: const Text("Please fill all the fields"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: const Text("ok"))
                              ],

                            );
                          }

                      );
                    } else if(mobileNumber.isEmpty||mobileNumber.length<10||!RegExp(r'^[0-9]+$').hasMatch(mobileNumber)){
                      showDialog(
                          context: context,
                          builder:(BuildContext){
                            return AlertDialog(
                              title: const Text("Mobile Number Incorrect"),
                              content: const Text("Please fill all the fields"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: const Text("ok"))
                              ],

                            );
                          }

                      );
                    }else if(email.isEmpty){
                      showDialog(
                          context: context,
                          builder:(BuildContext){
                            return AlertDialog(
                              title: const Text("Enter valid email"),
                              content: const Text("Please fill all the fields"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                    child: const Text("ok"))
                              ],
                            );
                          }
                      );
                    }else if(password.isEmpty){
                    showDialog(
                        context: context,
                        builder:(BuildContext){
                          return AlertDialog(
                            title: const Text("Password Can't be empty."),
                            content: const Text("Please fill all the fields"),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.of(context).pop();
                              },
                                  child: const Text("ok"))
                            ],
                          );
                        }
                    );
                  }else{
                    WidgetsFlutterBinding.ensureInitialized();
                    await Firebase.initializeApp();
                    final auth = Auth();
                    final User=await auth.createUserWithEmailAndPass(email: email, pass: password);
                    CollectionReference UsersList=FirebaseFirestore.instance.collection('Users');
                    UsersList.add({
                      'First Name':_ControllerFname.text,
                      'Last Name':_ControllerLname.text,
                      'Email':_ControllerEmail.text,
                      'Mobile Number':_ControllerMob.text
                    });
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const AppHome()));
                  }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    elevation: 4
                  ),
                  child: const Text("Submit",style: TextStyle(color: Colors.white),),

                ),
              ),
            )
          ]
        ),
      ),

    );
  }
}


