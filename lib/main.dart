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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hey There"),
      ),
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
  void initState() {
    _videoPlayerController.initialize().then((a) {
      setState(() {
        _videoPlayerController.play();
      });
    });
    _videoPlayerController.addListener(() {
      print(_videoPlayerController.value.position);
      if (_videoPlayerController.value.position ==
          _videoPlayerController.value.duration) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _videoPlayerController.value.size?.width ?? 0,
                height: _videoPlayerController.value.size?.height ?? 0,
                child: VideoPlayer(_videoPlayerController),
              ),
            ),
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
                      onPressed: () {
                        _videoPlayerController.seekTo(Duration(seconds: 0));
                      },
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
