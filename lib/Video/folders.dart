import 'dart:io';
import 'package:bitslogicxplayer/Video/appinio.dart';
import 'package:bitslogicxplayer/Video/flick.dart';
import 'package:bitslogicxplayer/Video/openfolder.dart';
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



class Folders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: MyFileList(), //ca
      debugShowCheckedModeBanner: false,// ll MyFile List
    );
  }
}

//apply this class on home: attribute at MaterialApp()
class MyFileList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyFileList();
  }
}

class _MyFileList extends State<MyFileList>{
  var files;

  void getFiles() async { //asyn function to get list of files
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    for (StorageInfo storage in storageInfo) {
      print(storage.rootDir);
    }
    var root = storageInfo[0].rootDir; //storageInfo[1] for SD card, geting the root directory
    var fm = FileManager(root: Directory(root)); //
    files = await fm.filesTree(
      //set fm.dirsTree() for directory/folder tree list
      //optional, to filter files, remove to list all,
      //remove this if your are grabbing folder list
      excludeHidden: true,

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
  String thumbnail='';
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
      try {}catch(e){}


    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Info()));
            }
        ),
        backgroundColor: Colors.lightBlue[200],
        title: Text(
          'Device Folders',
        ),
      ),
      body:files == null? Center(child: CircularProgressIndicator()):
      ListView.builder(
        itemBuilder: (context, index) => Container(




          child:files == null? Text("Searching Files"):

          Card(
              child:Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Color(0xC4A484),
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
                child: ListTile(
                  title: Text(files[index].path.split('/').last),
                  leading: Icon(Icons.folder),

                  onTap:  (){
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Ofolder(vp: files[index].path)));
                  },
                ),
              )
          ),




        ),
        itemCount: files.length,
      ),
    );

  }
}