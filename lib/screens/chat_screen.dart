import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget{
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(onMessage: (msg){
      print(msg);
      return;
    }, onLaunch: (msg){                                           //when app is terminated &we need to enter key value pair of click_action in msg
      print(msg);
      return;
    }, onResume: (msg){                                           //when app is in background
      print(msg);
      return;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
           title: Text('Flutter Chat'),
          actions: [
            DropdownButton(
              underline: Container(),                                       //so that grey line does not appear
              icon: Icon(Icons.more_vert),
              dropdownColor: Theme.of(context).primaryIconTheme.color,
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        SizedBox(width: 8,),
                        Text('Logout'),
                      ],
                    ),
                  ),
                  value: 'logout',                                    //value to return if user selects this
                ),
              ],
              onChanged: (itemIdentifier){
                if(itemIdentifier == 'logout'){
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          ],
         ),
         body: Container(
           child: Column(
             children: [
               Expanded(
                   child: Messages(),
               ),
               NewMessage(),
             ],
           ),
         ),
      );
  }
}