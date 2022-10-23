import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:bitslogicxplayer/Video/appinio.dart';
import 'package:bitslogicxplayer/Video/better.dart';
import 'package:bitslogicxplayer/Video/chiewie.dart';
import 'package:bitslogicxplayer/Video/flick.dart';
import 'package:chewie/chewie.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';

class Pick extends StatefulWidget {
  const Pick({Key? key}) : super(key: key);

  @override
  State<Pick> createState() => _PickState();
}

class _PickState extends State<Pick> {
  Future<void> openFile(_file) async {
    final file = await OpenFile.open(_file);
    print(file.message);
  }

  @override
  Widget build(BuildContext context) {
    PickedFile _pv;
    ImagePicker p = ImagePicker();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Bitlogicx Player',
        ),
      ),
      body: SafeArea(
          child: Container(
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
            Container(
                child: Column(
              children: [
                Image.asset(
                  'assets/m2.png',
                  height: 200,
                ),
                Column(
                  children: [
                    Text(
                      "PRESS THE BUTTON FOR PLAYING VIDEO",
                      style: TextStyle(fontSize: 15),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: FloatingActionButton(
                            heroTag: 'button1',
                            backgroundColor: Colors.redAccent,
                            onPressed: () async {
                              final pv =
                                  await p.getVideo(source: ImageSource.gallery);
                              if (pv == null) return;
                    
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Appinio_VP(
                                        vp: pv.path,
                                      )));
                            },
                            
                            tooltip: 'Pick Video from gallery',
                            child: const Icon(Icons.video_library),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: FloatingActionButton(
                              backgroundColor: Colors.redAccent,
                              onPressed: () async {
                                final pv = await p.getVideo(
                                    source: ImageSource.gallery);
                                if (pv == null) return;
                                      
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MyHomePagechiewe(vp: pv.path)));
                              },
                              heroTag: 'button2',
                              tooltip: 'Pick Video from gallery',
                              child: const Icon(
                                Icons.browse_gallery,
                              )),
                        ),
                      ],
                    ),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child:Text("floating button to navihgate to simpler player"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ))
          ],
        ),
      )),
    );
  }
}
