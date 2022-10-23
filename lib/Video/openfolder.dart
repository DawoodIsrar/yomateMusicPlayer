import 'dart:io';

import 'package:bitslogicxplayer/Video/folders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission_handler/permission_handler.dart';

class Ofolder extends StatefulWidget {
 Ofolder({Key? key, required this.vp}) : super(key: key);
final String vp;
  @override
  _OfolderState createState() => _OfolderState();
}

class _OfolderState extends State<Ofolder> {
  var files;

  void getFiles() async { //asyn function to get list of files
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    for (StorageInfo storage in storageInfo) {
      print(storage.rootDir);
    }
   
    var fm = FileManager(root: Directory(widget.vp)); //
    files = await fm.filesTree(
      //set fm.dirsTree() for directory/folder tree list
      //optional, to filter files, remove to list all,
      //remove this if your are grabbing folder list
      excludeHidden: false,
      extensions: [
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
        "MP2",]

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
                  builder: (context) => Folders()));
            }
        ),
        backgroundColor: Colors.lightBlue[200],
        title: Text(
          'Videos',
        ),
      ),
      body:files == null? Center(child: CircularProgressIndicator()):
      ListView.builder(
        itemBuilder: (context, index) => Container(




          child:files == null? Text("Searching Files"):

          Card(
              child:ListTile(
                title: Text(files[index].path.split('/').last),
                leading: Icon(Icons.folder),
                trailing: Icon(Icons.delete, color: Colors.redAccent,),
                onTap:  (){
                 
                },
              )
          ),




        ),
        itemCount: files.length,
      ),
    );
  }
}
