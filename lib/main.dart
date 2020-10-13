import './screens/auth_screen.dart';
import './screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,                           //since purple is dark so that we end up with black text on purple
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,                            //to make sure we have right contrast color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
         ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,             //stream will emit a value whenever auth state changes
        builder: (ctx, userSnapshot) {
         if(userSnapshot.hasData) {                                   //we did find a token
           return ChatScreen();
         }
          return AuthScreen();
         }),
    );
  }
}

