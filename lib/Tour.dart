import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Tour extends StatefulWidget {
  @override
  _TourState createState() => _TourState();
}

class _TourState extends State<Tour> {
  int currentPage = 0;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    Future<FirebaseUser> _handleSignIn() async {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      return authResult.user;
    }

    void _signIn() {
      _handleSignIn().then((FirebaseUser user) {
        print(user.displayName);
        // List<String> _nameSplit = user.displayName.split(' ');
        // Firestore.instance.document('users/$globalUserId').setData({
        //   'image': user.photoUrl,
        //   'name': {'first': _nameSplit[0], 'last': _nameSplit[1]},
        //   //'mobile': int.parse(mobileNoController.text)
        // }, merge: true).then((e) {
        //   Navigator.pop(context);
        // });
      }).catchError((e) => print(e));
    }

    pageController.addListener(() {
      print("Current page " + pageController.page.toString());
    });
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
              });
            },
            controller: pageController,
            children: <Widget>[
              Stack(
                // alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/woman_sad.jpg'),
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                    top: 25,
                    right: 10,
                    child: Text(
                      'Everyone\nNeeds\nHelp',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Francois One',
                          // height: 1,
                          fontSize: 60),
                    ),
                  )
                ],
              ),
              Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/see-saw-loop.gif'),
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                    top: 25,
                    right: 10,
                    child: Text(
                      'Everybody Needs It.\nDo You Need it?',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Francois One',
                          // height: 1,
                          fontSize: 40),
                    ),
                  )
                ],
              ),
            ],
          ),
          Positioned(
              bottom: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    height: 50,
                    width: 150,
                    child: RaisedButton(
                      color: Colors.black.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 0.0,
                      onPressed: () {
                        if (pageController.page == 1.0) {
                          _signIn();
                        } else {
                          pageController.nextPage(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.ease);
                        }
                      },
                      child: Text(
                        currentPage == 0
                            ? 'Tell Me More'
                            : currentPage == 1? 'Yes I need it' : '',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.7)),
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
