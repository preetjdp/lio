import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lio',
      home: LoadingPage(),
    );
  }
}

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset('assets/lio_video.mp4');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          // Container(
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: AssetImage('assets/lio_loop.gif'),
          //           fit: BoxFit.cover)),
          // ),
          AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio,
            child: VideoPlayer(_videoPlayerController),
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
                      color: Colors.white.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      elevation: 0.0,
                      onPressed: () {},
                      child: Text(
                        'Lets Go',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7)),
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
