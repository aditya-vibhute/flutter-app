import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/AppHome.dart';
import 'package:mini_project/NewAcc.dart';
import 'package:mini_project/splashscreen.dart';
import 'package:mini_project/FireBaseAuth.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _ControllerName=TextEditingController();
  final _ControllerPassword=TextEditingController();
  bool passwordVisible=false;

  @override
  void initState(){
    super.initState();
    passwordVisible=true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 360,
            width: 430,
            child: Padding(padding: const EdgeInsets.only(top: 150,left: 0,right: 0,bottom: 0),
              child: Image.asset('assets/images/logo.jpeg',scale: 1.5,),
            ),
          ),
          Container(
            color: Colors.white,
            child: const Center(
              child: SizedBox(
                height: 50,
                child: Text("Log-In" ,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25,fontFamily: 'BebasNeue',shadows:<Shadow>[
                  Shadow(blurRadius: 15,color: Colors.black26,offset: Offset(0,3))
                ]),),
              ),
              //child: Text("Log In" ,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            ),
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30,bottom: 10,left: 40,right: 40),
                child: TextField(
                  controller: _ControllerName,
                  decoration: InputDecoration(
                    label: const Text("Enter Email...."),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    )
                  ),
                ),
              )
            ),

          ),
          Container(
            color: Colors.white,
            child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: TextField(
                    controller: _ControllerPassword,
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                        label: const Text("Password...."),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(
                                  () {
                                passwordVisible = !passwordVisible;
                              },
                            );
                          },
                          icon: Icon(passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),),

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),

                        )
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                )
            ),

          ),
          Container(
            height: 70,
            color: Colors.white,
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  String Name=_ControllerName.text;
                  String Pass=_ControllerPassword.text;
                  if(Name.isEmpty||Pass.isEmpty){
                    showDialog(context: context, builder:(BuildContext)
                      return AlertDialog(
                        title: const Text("Fill all Fields"),
                        content: const Text("All fields are mandatory to fill"),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.of(context).pop();
                          }, child: const Text("ok"))
                        ],
                      );
                    }
                    );
                  }

                  else{
                    await Firebase.initializeApp();
                    final auth=Auth();
                    final User=await auth.signInWithEmailAndPass(email: Name, pass: Pass);
                    if(User!=null){
                      log("Login Successfull.");
                      final snackbar=SnackBar(content: Text("Login successfull!"));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const AppHome()));
                    }
                    else{
                      final snackbar=SnackBar(content: Text("Entered Password or Email is incorrect.."));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                  }


                },
                style:ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 5
                ),
                child: const Text("Submit",style: TextStyle(color: Colors.white),)
              ),
            ),
          ),
          Container(
            height: 40,
            color: Colors.white,
          ),
          Container(
            color: Colors.white,
            child: const Text("Don't have an Account?"),
          ),
          Container(
            color: Colors.white,
            child: TextButton( onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NewAccount()));
            }, child: const Text("Create Account"),),
          )
        ],
      )
    );
  }
}


