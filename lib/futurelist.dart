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
//import package files
import 'package:thumbnails/thumbnails.dart';

import 'Video/better.dart';

class FFF extends StatelessWidget {
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
      ], //optional, to filter files, remove to list all,
      //remove this if your are grabbing folder list
      excludeHidden: false,
    );

    setState(() {}); //update the UI
  }

  @override
  void initState() {
    Future<bool> requestFilePermission() async {
      PermissionStatus result;
      // In Android we need to request the storage permission,
      // while in iOS is the photos permission
      if (Platform.isAndroid) {
        result = await Permission.storage.request();
      } else {
        result = await Permission.photos.request();
      }

      if (result.isGranted) {
        getFiles(); //call getFiles() function on initial state.

      }
      _video = File(files);
      return false;
    }

    requestFilePermission();
    super.initState();
  }

  final picker = ImagePicker();
  late File _video;
  String thumbnail = '';
  List<File> listImages = <File>[];
  getVideo(File f) async {
    File file = await f;
    if (file != null) {
      setState(() {
        _video = File(file.path);
      });
      String thumb = await Thumbnails.getThumbnail(
        videoFile: _video.path,
        quality: 10,
        imageType: ThumbFormat.PNG,
      );
      try {} catch (e) {}
      thumbnail = thumb;
      listImages.add(File(thumb));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Info()));
              }),
          backgroundColor: Colors.lightBlue[300],
          title: Text(
            'Device videos',
          ),
        ),
        body: Container(
          child: Center(
            child: ElevatedButton(onPressed: (){}, child: Text("press to see list of videos")),
          ),
        ));
  }
}
