import 'dart:developer';
import 'dart:io';
import 'package:bitslogicxplayer/Audio/songs.dart';
import 'package:bitslogicxplayer/Network/dmp3.dart';
import 'package:bitslogicxplayer/Network/downloading_dialog.dart';
import 'package:bitslogicxplayer/Network/downloadmp3.dart';
import 'package:bitslogicxplayer/Network/dv.dart';
import 'package:bitslogicxplayer/Network/playonline.dart';
import 'package:bitslogicxplayer/Video/custom_video_tiles.dart';
import 'package:bitslogicxplayer/Video/folders.dart';
import 'package:bitslogicxplayer/Video/new.dart';
import 'package:bitslogicxplayer/Video/videoHome.dart';
import 'package:bitslogicxplayer/Video/videos.dart';
import 'package:bitslogicxplayer/audio_main.dart';
import 'package:bitslogicxplayer/features/shared/ui/screens/AllSongs.dart';
import 'package:bitslogicxplayer/futurelist.dart';
import 'package:bitslogicxplayer/newFile.dart';
import 'package:bitslogicxplayer/Network/playonline.dart';
import 'package:bitslogicxplayer/thum.dart';
import 'package:bitslogicxplayer/thumbnail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Videos',
      style: optionStyle,
    ),
    Text(
      'Index 1: Audios',
      style: optionStyle,
    ),
    Text(
      'Index 2: Folders',
      style: optionStyle,
    ),
    Text(
      'Index 3: Network',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TFF()),
        );
      } else if (index == 1) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SongList()));
      } else if (index == 2) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Folders()));
      } else if (index == 3) {
        launchedYoutube(urly);
      }
    });
  }

  String urlm = "https://www.acethinker.com/url-to-mp3";
  Future<void> launchedMp3(String urlm) async {
    if (await canLaunch(urlm)) {
      await launch(urlm,
          forceWebView: true, forceSafariVC: true, enableJavaScript: true);
    }
  }

  String urly = "https://www.youtube.com/";
  Future<void> launchedYoutube(String urly) async {
    if (await canLaunch(urly)) {
      await launch(urly,
          forceWebView: true, forceSafariVC: true, enableJavaScript: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[200],
        title: Text(
          'Yomate Player',
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.video_file_sharp, color: Colors.black),
            label: 'Videos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.audio_file_sharp, color: Colors.black),
            label: 'Audios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_open_sharp, color: Colors.black),
            label: 'Folders',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_outlined,
              color: Colors.black,
            ),
            label: 'Search',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue[300],
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(),
              child: Image.asset(
                "assets/ylogo.png",
                alignment: Alignment.center,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.play_arrow,
                size: 20,
              ),
              title: Text(
                'MP3 Player',
                style: TextStyle(color: Colors.lightBlue[300]),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SongList()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.play_arrow,
                size: 20,
              ),
              title: Text(
                'Video Player',
                style: TextStyle(color: Colors.lightBlue[300]),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => TFF()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.play_arrow,
                size: 20,
              ),
              title: Text(
                'Device Folders',
                style: TextStyle(color: Colors.lightBlue[300]),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Folders()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.play_arrow,
                size: 20,
              ),
              title: Text(
                'Play online',
                style: TextStyle(color: Colors.lightBlue[300]),
              ),
              onTap: () {
                launchedYoutube(urly);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.play_arrow,
                size: 20,
              ),
              title: Text(
                'Download MP3',
                style: TextStyle(color: Colors.lightBlue[300]),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Dmp3()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.play_arrow,
                size: 20,
              ),
              title: Text(
                'Download videos',
                style: TextStyle(color: Colors.lightBlue[300]),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Dv()));
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/ylogo.png",
                alignment: Alignment.center,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "A music Player is the Sound Track of your life     (-Dick clark).",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      "BitLogicx Music Player plays your mp3,mp4 songs, recordings, and other audio and video with the passion and quality of good Sound and picture.",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
