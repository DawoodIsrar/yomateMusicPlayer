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

class FFFF extends StatelessWidget {
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
      ],
      excludeHidden: true,
    );

    setState(() {});
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

  final picker = ImagePicker();
  late File _video;
  String thumbnail = '';
  List<File> listImages = <File>[];
  List<File> listImage = <File>[];
  getVideothumbnail(File listimage) async {
    File file = await files;
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
      setState(() {
        thumbnail = thumb;
        listImages.add(File(thumbnail));
        print(listImages);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[200],
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
        backgroundColor: Colors.lightBlue[200],
        title: Text(
          'YoMate videos',
        ),
      ),
      body: files == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Center(
                  child: ElevatedButton(
                      onPressed: getVideothumbnail(files),
                      child: Text("CLICK"))),
            ),
    );
  }
}
