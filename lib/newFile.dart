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

class FF extends StatelessWidget {
  FF(List<File> listImages);

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

    setState(() {
      print(
          "NO of files recieve from thumnail:" + listImages.length.toString());
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

  final picker = ImagePicker();
  late File _video;
  String thumbnail = '';
  List<File> listImages = <File>[];

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
          backgroundColor: Colors.lightBlue[200],
          title: Text(
            'YoMate Device videos',
          ),
        ),
        body: files == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: files.length,
                itemBuilder: (context, index) => GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      return Container(
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
                          Align(
                            alignment: Alignment.center,
                            child: Image.file(
                              File(listImages[index].toString()),
                              alignment: Alignment.center,
                              width: 100,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ListTile(
                                title: Text(files[index].path.split('/').last),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          Sampleplayer(vp: files[index].path)));
                                },
                                onLongPress: () {},
                              ),
                            ],
                          ),
                        ]),
                      );
                    })));
  }
}
