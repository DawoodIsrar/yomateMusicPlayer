
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchedYoutube extends StatefulWidget {
  const LaunchedYoutube({Key? key}) : super(key: key);

  @override
  State<LaunchedYoutube> createState() => _LaunchedYoutubeState();
}

class _LaunchedYoutubeState extends State<LaunchedYoutube> {
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
      body: Container(
        margin: EdgeInsets.all(35),
        child: Center(
          child: TextButton(
            child: Text("Click Here for Open Youtube", style: TextStyle(fontSize: 20),),
            onPressed: (){
              launchedYoutube(urly);
            },

          ),
        )
      ),

    );
  }
}
