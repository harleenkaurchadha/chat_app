import 'package:firebase_core/firebase_core.dart';

import './message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Messages extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     final user = FirebaseAuth.instance.currentUser;
     return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
          builder: (ctx,chatSnapshot) {
       if(chatSnapshot.connectionState == ConnectionState.waiting) {
         return Center(
           child: CircularProgressIndicator(),
         );
       }
       final chatDocs = chatSnapshot.data.documents;
       return ListView.builder(
             reverse: true, //to order new message at bottom
             itemCount: chatDocs.length,
             itemBuilder: (ctx, index) => MessageBubble(
                   chatDocs[index]['text'],
                   chatDocs[index]['username'],
                   chatDocs[index]['userImage'],
                   chatDocs[index]['userId'] == user.uid,
                   key: ValueKey(chatDocs[index].documentID),               //every message has a unique id which is document ID
                 ),
           );
         },
       );
  }
}