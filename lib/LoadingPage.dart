import 'package:flutter/material.dart';
import 'package:lio/Tour.dart';
import 'package:video_player/video_player.dart';

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
            MaterialPageRoute(builder: (BuildContext context) => Tour()));
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
        ],
      ),
    );
  }
}
