import 'package:brew_crew/Services/auth.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/Services/database.dart';

import 'brewList.dart';

class Home extends StatelessWidget {

  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
        value:DataBaseService().brews,
        child:Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text("How do like your Coffee?",

        ),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            label: Text("Log out"),
            icon:Icon(Icons.person),
            onPressed: () async{
              await FirebaseAuth.instance.signOut();
              return _auth;
            },
          )
        ],

      ),
      body: BrewList(),
    )
    );

  }
}
    