import 'dart:io';
import 'dart:typed_data';

import 'package:bitslogicxplayer/futurelist.dart';
import 'package:bitslogicxplayer/newFile.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/services.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';
import 'package:wakelock/wakelock.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video_player/video_player.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class Sampleplayer extends StatefulWidget {
  Sampleplayer({Key? key, required this.vp}) : super(key: key);
  String vp;

  @override
  State<Sampleplayer> createState() => _SampleplayerState();
}

class _SampleplayerState extends State<Sampleplayer> {
  ChewieController? _chewieController;
  // ignore: unused_field

  VideoPlayerController? _videoPlayerController;
  bool Wakelocktogger = true;
  late FlickManager flickManager;

  bool wakeLock = true;
  @override
  void initState() {
    super.initState();

    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.file(File(widget.vp)),
      autoInitialize: true,
      autoPlay: true,
      
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  final String _vimeoVideoUrl = 'https://vimeo.com/70591644';
  double _scale = 1.0;
  double _previousScale = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yomate Player"),
        backgroundColor: Colors.lightBlue[200],
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {


            }),
      ),
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xFFFDD0),
              Color(0xFFFFED),
            ], // Gr)),
          )),
          child: Column(
            children: [
              SafeArea(
                  child: Container(
                width: double.infinity,
                height: 300,
                child: GestureDetector(
                    onScaleStart: (ScaleStartDetails d) {
                      print(d);
                      _previousScale = _scale;
                      setState(() {});
                    },
                    onScaleUpdate: (ScaleUpdateDetails d) {
                      _scale = _previousScale * d.scale;
                      setState(() {});
                    },
                    onScaleEnd: (ScaleEndDetails d) {
                      _previousScale = 1.0;
                      setState(() {});
                    },
                    child: Transform(
                      transform:
                          Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                      alignment: FractionalOffset.center,
                      child: Container(
                        width: 200,
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FlickVideoPlayer(
                              flickManager: flickManager,
                             
                            ),
                          ),
                        ),
                      ),
                    )),
              ))
            ],
          )),
    );
  }
}
