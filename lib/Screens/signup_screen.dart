import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wslc_194_firebase_module/Screens/signin_screen.dart';
import 'package:wslc_194_firebase_module/Widgets/uihelper.dart';
import 'dart:developer';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  signup(String email,String password)async{
    if(email=="" && password==""){
      return log("Enter Required Field");
    }
    else{
      UserCredential? userCredential;
      try{
        userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
          log("User Created");
        });
      }
      on FirebaseAuthException catch(ex){
        log(ex.code.toString());
      }

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(emailController, "Enter Email", Icons.mail, false),
          UiHelper.CustomTextField(passwordController,"Enter Password", Icons.password, true),
          SizedBox(height: 20),
          ElevatedButton(onPressed: (){
            signup(emailController.text.toString(), passwordController.text.toString());
          }, child: Text("Sign Up")),
          SizedBox(height: 15),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
          }, child: Text("Sign In"))
      ],),
    );
  }
}
