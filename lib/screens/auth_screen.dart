import 'dart:io';
import 'package:flutter/services.dart';
import '../widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
      File image,
      bool isLogin,
      BuildContext ctx,
      ) async{
     UserCredential authResult;

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
          //uploading image on the firebase
         final ref = FirebaseStorage.instance.ref()       //ref gives access to our root cloud storage bucket & child creates path to store file
             .child('user_image')
             .child(authResult.user.uid + '.jpg');                      //create file with this name in user_image folder
         
         await ref.putFile(image);                        //put file to the ref path & onComplete makes it a future event

         final url = await ref.getDownloadURL();  //to get a url for uploaded file so that we can use in future & no need to scan firebase every time

         await FirebaseFirestore.instance.collection('users').doc(authResult.user.uid).set({        //setData to store extra data for that document
           'username' : username,
           'email' : email,
           'image_url' : url,
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