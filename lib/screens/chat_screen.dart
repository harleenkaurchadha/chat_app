import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
           title: Text('Flutter Chat'),
          actions: [
            DropdownButton(
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
              Firestore.instance
              .collection('chats/A6pkO1VU0FJNhc8YpM40/messages')
              .add({
                'text': 'This was added by clicking the button'
              });
            }),
      );
  }
}