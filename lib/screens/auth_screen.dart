import 'package:flutter/services.dart';
import '../widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget{
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;                          //give instance of firebase auth package
  var _isLoading = false;

  void _submitAuthForm(                                          //get data from authForm to handle the request to create new user in authScreen
      String email,
      String password,
      String username,
      bool isLogin,
      BuildContext ctx,
      ) async{
     AuthResult authResult;

     try {
       setState(() {
         _isLoading = true;
       });
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
         await Firestore.instance.collection('users').document(authResult.user.uid).setData({        //setData to store extra data for that document
           'username' : username,
           'email' : email,
         });
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
       setState(() {
         _isLoading = false;
       });
     } catch(err) {
       print(err);
       setState(() {
         _isLoading = false;
       });
     }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
          _submitAuthForm,
          _isLoading,
      ),
    );
  }
}