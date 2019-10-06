import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lio/DatabaseService/DatabaseService.dart';
import 'package:lio/HomePage.dart';
import 'package:lio/LoadingPage.dart';
import 'package:provider/provider.dart';
import 'Models/User.dart';
import 'Tour.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  DatabaseService databaseService = DatabaseService();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
        )
      ],
      child: MaterialApp(
        title: 'Lio',
        // home: LoadingPage(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder:
              (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              bool isLoggedIn = snapshot.hasData;
              if (isLoggedIn) {
                globalUserId = snapshot.data.uid;
              }
              return isLoggedIn ? LoadingPage() : LoadingPage();
            } else {
              return Scaffold(
                  body: Container(
                      child: Center(
                          child: Text(
                              'If you see this screen please restart the app or contact the dev'))));
            }
          },
        ),
      ),
    );
  }
}
