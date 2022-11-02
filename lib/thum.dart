import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:bitslogicxplayer/Video/appinio.dart';
import 'package:bitslogicxplayer/Video/flick.dart';
import 'package:bitslogicxplayer/info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saf/saf.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:thumbnails/thumbnails.dart';
import 'Video/better.dart';

class TFF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyFileList(), //ca
      debugShowCheckedModeBanner: false, // ll MyFile List
    );
  }
}

//apply this class on home: attribute at MaterialApp()
class MyFileList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyFileList();
  }
}

class _MyFileList extends State<MyFileList> {
  var files;
  String thumbnail = '';
  List<File> listImages = <File>[];
  void getFiles() async {
    //asyn function to get list of files
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    for (StorageInfo storage in storageInfo) {
      print(storage.rootDir);
    }
    var root = storageInfo[0]
        .rootDir; //storageInfo[1] for SD card, geting the root directory
    var fm = FileManager(root: Directory(root)); //
    files = await fm.filesTree(
      //set fm.dirsTree() for directory/folder tree list
      extensions: [
        "MP4",
        "mp4",
        "MPG4",
        "AVD",
        "WMV",
        "AVI",
        "AVCHD",
        "FLV",
        "MKV",
        "MPEG",
        "MPE",
        "MPV",
        "OGG",
        "M4P",
        "M4V",
        "F4V",
        "WEBM",
        "MPG",
        "MP2",
        "QT"
      ],
      excludeHidden: true,
    );
    print("Entry to set state");
    setState(() {
      print("number of images in the files:" + files.length.toString());
      print("Enter to set state");
      getVideothumbnail(files);
      print("send to getthumb");
    });
  }

  final picker = ImagePicker();
  late File _video;
  getVideothumbnail(files) async {
    print("Entry to getthumb");
    String thumb = '';
    for (var i = 0; i < files.length; i++) {
      if (files[i] != null) {
        setState(() {
          _video = File(files[i].path);
          print("files in the loof:" + files[i].toString());
        });
        thumb = await Thumbnails.getThumbnail(
          videoFile: _video.path,
          quality: 10,
          imageType: ThumbFormat.PNG,
        );

        setState(() {
          thumbnail = thumb;
          print("Thumbnail files " + thumbnail.toString());
          listImages.add(File(thumb));
          print("Image of thumbnail in the LsitImage:" +
              listImages[i].toString());
        });
      }
    }
    setState(() {
      print("Images list item number:" + listImages.length.toString());
    });
  }

  @override
  void initState() {
    Future<bool> requestFilePermission() async {
      PermissionStatus result;

      if (Platform.isAndroid) {
        result = await Permission.storage.request();
      } else {
        result = await Permission.photos.request();
      }

      if (result.isGranted) {
        getFiles();
      }

      _video = File(files);
      return false;
    }

    requestFilePermission();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   iconTheme: IconThemeData(
        //     color: Colors.white,
        //   ),
        //   leading: IconButton(
        //       icon: Icon(Icons.arrow_back, color: Colors.white),
        //       onPressed: () {
        //         Navigator.of(context)
        //             .push(MaterialPageRoute(builder: (context) => Info()));
        //       }),
        //   backgroundColor: Colors.lightBlue[200],
        //   title: Text(
        //     'YoMate Device videos',
        //   ),
        // ),
        body: files == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: listImages.length,
                itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              Color(0xFFFDD0),
                              Color(0xFFFFED),
                            ], // Gr)),
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 4.0,
                                offset: Offset(-4, -4),
                                color: Colors.white),
                            BoxShadow(
                                blurRadius: 4.0,
                                offset: Offset(4, 4),
                                color: Colors.black12),
                          ]),
                      child: Stack(children: [
                        listImages[index].path == null
                            ? Center(child: CircularProgressIndicator())
                            // : Stack(
                            //     children: [
                            //       Align(
                            //         alignment: Alignment.center,
                            //         child: Image.file(
                            //           File(listImages[index].path),
                            //           alignment: Alignment.center,
                            //           width: 300,
                            //           height: 120,
                            //         ),
                            //       ),
                            //       Align(
                            //         alignment: Alignment.center,
                            //         child: Icon(
                            //           Icons.play_arrow,
                            //           size: 50,
                            //           color: Colors.white,
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ListTile(
                                    leading: listImages[index] == null
                                        ? Center(
                                            child: CircularProgressIndicator(
                                                color: Colors.lightBlue),
                                          )
                                        : Image.file(
                                            File(listImages[index].path),
                                            alignment: Alignment.center,
                                            width: 50,
                                            height: 50,
                                          ),
                                    title:
                                        Text(files[index].path.split('/').last),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Sampleplayer(
                                                      vp: files[index].path)));
                                    },
                                    // onLongPress: () {

                                    // },
                                  ),
                                ],
                              ),
                      ]),
                    )));
  }
}
