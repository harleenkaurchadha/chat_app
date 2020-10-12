import 'package:flutter/services.dart';

import '../widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget{
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;                          //give instance of firebase auth package

  void _submitAuthForm(                                          //get data from authForm to handle the request to create new user in authScreen
      String email,
      String password,
      String username,
      bool isLogin,
      BuildContext ctx,
      ) async{
     AuthResult authResult;

     try {
       if (isLogin) {
         authResult = await _auth.signInWithEmailAndPassword(
             email: email,
             password: password
         );
       } else {
         authResult = await _auth.createUserWithEmailAndPassword(
             email: email,
             password: password
         );
       }
     } on PlatformException catch(err){                                  //error on firebase relating to invalid credentials
       var message = 'An error occurred, please check your credentials';

       if(err.message != null){
         message = err.message;
       }

       Scaffold.of(ctx).showSnackBar(
         SnackBar(
           content: Text(message),
           backgroundColor: Theme.of(ctx).errorColor,
         ),
       );
     } catch(err) {
       print(err);
     }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm),
    );
  }
}