import 'dart:ui';

import 'package:flutter/material.dart';

class Tour extends StatelessWidget {
  void signInWithGoogle() {
    
  }
  final PageController pageController = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    pageController.addListener(() {
      print("Current page " + pageController.page.toString());
    });
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          PageView(
            controller: pageController,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/woman_sad.jpg'),
                            fit: BoxFit.cover)),
                  ),
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
                          signInWithGoogle();
                        } else {
                          pageController.nextPage(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.ease);
                        }
                      },
                      child: Text(
                        'Tell Me More',
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
