import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_ex/path_provider_ex.dart';

class DownloadingDialogmp3 extends StatefulWidget {
  DownloadingDialogmp3(String this.urlmp3, String this.name, {super.key,});
String urlmp3;
String name;
  @override
  _DownloadingDialogmp3State createState() => _DownloadingDialogmp3State();
}

class _DownloadingDialogmp3State extends State<DownloadingDialogmp3> {
  Dio dio = Dio();
  double progress = 0.0;

  void startDownloading() async {
   String url = widget.urlmp3;

     String fileName = widget.name;
 print('video url :'+url);
     print('video name :'+fileName);
    String path = await _getFilePath(fileName);

    await dio.download(
      url,
      path,
      onReceiveProgress: (recivedBytes, totalBytes) {
        setState(() {
          progress = recivedBytes / totalBytes;
        });

        print(progress);
      },
      deleteOnError: true,
    ).then((_) {
      Navigator.pop(this.context);
    });
  }

  Future<String> _getFilePath(String filename) async {
    
List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    for (StorageInfo storage in storageInfo) {
      print(storage.rootDir);
    }
    var dir = storageInfo[0].rootDir; 


  if(!Directory("${dir}/filename").existsSync()){
    Directory("${dir}/filename").createSync(recursive: true);
  }
    return "${dir}/$filename";
  }

  @override
  void initState() {
    super.initState();
    startDownloading();
  }

  @override
  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toInt().toString();

    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Downloading: $downloadingprogress%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}