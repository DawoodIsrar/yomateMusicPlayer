import 'dart:io';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:file_picker/src/platform_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video_player/video_player.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
class Appinio_VP extends StatefulWidget {
   Appinio_VP({Key? key, required this.vp}) : super(key: key);
   
   final String vp;

  @override
  State<Appinio_VP> createState() => _Appinio_VPState();
}

class _Appinio_VPState extends State<Appinio_VP> {
   late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  String videoUrl =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.file(File(widget.vp))
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }
  double _scale = 1.0;
  double _previousScale = 1.0;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("BITS VIDEO PLAYER"),
      ),
      body: Container(
        width: double.infinity,
       
         decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xff1f005c),
            Color(0xff5b0060),
            Color(0xff870160),
            Color(0xffac255e),
            Color(0xffca485c),
            Color(0xffe16b5c),
            Color(0xfff39060),
            Color(0xffffb56b),
          ], // Gr)),
        )),
        child: Column(
          
          children: [
            SafeArea(
              child: 
                 Container(
                  width: double.infinity,
                  height: 400,
                   child: GestureDetector(
                      onScaleStart: (ScaleStartDetails d){
                        print(d);
                        _previousScale = _scale;
                        setState(() {
                          
                        });
                      },
                      onScaleUpdate: (ScaleUpdateDetails d){
                                 _scale = _previousScale * d.scale;
                                 setState(() {
                                   
                                 });
                      },
                      onScaleEnd: (ScaleEndDetails d){
                        _previousScale = 1.0;
                        setState(() {
                          
                        });
                      },
                       
                         child: Transform(
                          transform: Matrix4.diagonal3(Vector3(_scale,_scale,_scale)),
                          alignment: FractionalOffset.center,
                           child:
                                 CustomVideoPlayer(
                                               customVideoPlayerController: _customVideoPlayerController
                                             ),
                              
                         ),
                       
                     ),
                   
                 ),
     
              ),
            
          ],
        )
         
      
      ),
    );
  }
}