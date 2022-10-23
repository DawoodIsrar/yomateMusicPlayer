import 'dart:io';
import 'package:bitslogicxplayer/Video/file.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thumbnails/thumbnails.dart';
class Thumbnail extends StatefulWidget {

  Thumbnail({Key? key, required this.vp}) : super(key: key);
  String vp;
  @override
  _ThumbnailState createState() => _ThumbnailState();
}
class _ThumbnailState extends State<Thumbnail> {
  final picker = ImagePicker();
  late File _video;
   String thumbnail='';
  initState(){
    _video = File(widget.vp);

  }
  getVideo() async {
    var file = await widget.vp;
    if (file != null) {
      setState(() {
        _video = File(file);
      });
      String thumb = await Thumbnails.getThumbnail(
        videoFile: _video.path,
        quality: 10,
        imageType: ThumbFormat.PNG,
      );
try {}catch(e){}
      setState(() {
        thumbnail = thumb;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: _video != null ? Image.file(File(thumbnail)) : Text("data"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          getVideo();
        },
      ),
    );
  }
}