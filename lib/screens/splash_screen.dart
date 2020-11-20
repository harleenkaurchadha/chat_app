import 'package:flutter/material.dart';

//screen to be displayed so as to avoid minor appearance of auth screen when authenticated user opens app
class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
            children: [
              Text('Loading...'),
              CircularProgressIndicator(),
        ],
      ),
      ),
    );
  }
}