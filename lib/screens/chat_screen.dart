import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: StreamBuilder(
             stream: Firestore.instance                                                    //to fetch data from firestore database
             .collection('chats/A6pkO1VU0FJNhc8YpM40/messages')
             .snapshots(),
             builder: (ctx, streamSnapshot) {
               if(streamSnapshot.connectionState == ConnectionState.waiting){       //so that we don't have null data initially
                 return Center(
                   child: CircularProgressIndicator(),
                 );
               }
               final documents= streamSnapshot.data.documents;
               return ListView.builder(                              //listView builder is regenerated whenever new value of stream is received
               itemCount: documents.length,
               itemBuilder: (ctx,index) => Container(
                padding: EdgeInsets.all(8),
                child: Text(documents[index]['text']),
              ),
             );
         },
         ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
                                               //emits new values whenever data changes to give it real time aspect

            }),
      );
  }
}