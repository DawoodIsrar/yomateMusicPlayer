
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';


class MyHomePagechiewe extends StatefulWidget {
   MyHomePagechiewe({Key? key,required this.vp}) : super(key: key);
String vp;
  @override
  State<MyHomePagechiewe> createState() => _MyHomePagechieweState();
}

class _MyHomePagechieweState extends State<MyHomePagechiewe> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  void _initPlayer() async {
    videoPlayerController = VideoPlayerController.file(File(widget.vp));
    await videoPlayerController.initialize();

   final  chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: () => debugPrint('Option 1 pressed!'),
            iconData: Icons.chat,
            title: 'Option 1',
          ),
          OptionItem(
            onTap: () =>
                debugPrint('Option 2 pressed!'),
            iconData: Icons.share,
            title: 'Option 2',
          ),
        ];
      },
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chewie Video Player"),
      ),
      body: chewieController!=null? Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Chewie(
          
          controller: chewieController!,
        ),
      ) : Center(
        child: CircularProgressIndicator(),   
      ),
    );
  }
}
