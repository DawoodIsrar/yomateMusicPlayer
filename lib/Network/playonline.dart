import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

class POnline extends StatefulWidget {
  const POnline({Key? key}) : super(key: key);

  @override
  State<POnline> createState() => _POnlineState();
}

class _POnlineState extends State<POnline> {
  late Future<void> _launch;
  String url = "https://www.google.com/";
  Future<void> launchedBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, forceSafariVC: true,enableJavaScript: true);
    }
  }
  String urly = "https://www.youtube.com/";
   Future<void> launchedYoutube(String urly) async {
    if (await canLaunch(urly)) {
      await launch(urly, forceWebView: true, forceSafariVC: true,enableJavaScript: true);
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[300],
          title: Text(
            'YoMate Play online',
          ),
        ),
        body: Column(
          children: [
            Container(
              child: ElevatedButton(
                  onPressed: () {
                   setState(() {
                      launchedBrowser(url);
                   });
                  },
                  child: Text("google")),
            ),
             Container(
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      launchedYoutube(urly);
                    });
                  },
                  child: Text("youtube")),
            ),
          ],
        ));
  }
}
