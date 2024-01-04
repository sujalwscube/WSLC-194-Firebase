import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wslc_194_firebase_module/Screens/homescreen.dart';
import 'package:wslc_194_firebase_module/Widgets/uihelper.dart';
import 'dart:developer';
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  signIn(String email,String password)async{
    if(email=="" && password==""){
      return log("Enter Required Field's");
    }
    else{
      UserCredential? userCredential;
      try{
        userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        });
      }
      on FirebaseAuthException catch(ex){
        return log(ex.code.toString());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In Screen"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        UiHelper.CustomTextField(emailController, "Enter Email", Icons.mail, false),
        UiHelper.CustomTextField(passwordController, "Enter Password", Icons.password, false),
        SizedBox(height: 20),
        ElevatedButton(onPressed: (){
          signIn(emailController.text.toString(), passwordController.text.toString());
        }, child: Text("Sign In"))
      ],),
    );
  }
}
