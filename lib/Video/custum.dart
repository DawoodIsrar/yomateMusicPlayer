import 'dart:io';
import 'package:flutter/material.dart';
var path;

class CustomVideoTiles extends StatefulWidget {



  const CustomVideoTiles({Key? key,}) : super(key: key);

  @override
  _CustomVideoTilesState createState() => _CustomVideoTilesState();
}

class _CustomVideoTilesState extends State<CustomVideoTiles> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10,left:5.0,right: 5.0),
        child: Container(
          width: MediaQuery.of(context).size.width*0.2,
          height: MediaQuery.of(context).size.height*0.2,
    
          child: Column(
            children: [
              GestureDetector(
    
    
                onTap: (){
    
                  // BetterPlayerConfiguration betterPlayerConfiguration =
                  //
                  // BetterPlayerConfiguration(
                  //   controlsConfiguration: BetterPlayerControlsConfiguration(
                  //     enableAudioTracks: true,
                  //     showControls: true,
                  //
                  //   ),
                  //     fit: BoxFit.contain,
                  //     autoPlay: true,
                  //
                  //     autoDispose: true,
                  //     fullScreenAspectRatio: 1.0,
                  //     aspectRatio: 1.0,
                  //     fullScreenByDefault: true,
                  //
                  //     autoDetectFullscreenDeviceOrientation: true    );
                  // // print(files.elementAt(index).path);
                  // BetterPlayerDataSource dataSource = BetterPlayerDataSource(
                  //     BetterPlayerDataSourceType.file, widget.path);
                  // betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
                  // betterPlayerController.setupDataSource(dataSource);
    
                  
    setState(() {
    
    });
     Navigator.of(context).push(
       new MaterialPageRoute(
             builder: (BuildContext context) {
               return SerieExample();
             }));
                  //
                  // print(widget.path);
                  // controller = VlcPlayerController.file(
                  //   video,
                  //   hwAcc: HwAcc.FULL,
                  //   autoPlay: true,
                  //   options: VlcPlayerOptions(
                  //
                  //     advanced: VlcAdvancedOptions([
                  //
                  //       VlcAdvancedOptions.networkCaching(2000),
                  //     ]),
                  //     subtitle: VlcSubtitleOptions([
                  //       VlcSubtitleOptions.boldStyle(true),
                  //       VlcSubtitleOptions.fontSize(30),
                  //       VlcSubtitleOptions.outlineColor(VlcSubtitleColor.yellow),
                  //       VlcSubtitleOptions.outlineThickness(VlcSubtitleThickness.normal),
                  //       // works only on externally added subtitles
                  //       VlcSubtitleOptions.color(VlcSubtitleColor.navy),
                  //     ]),
                  //     rtp: VlcRtpOptions([
                  //       VlcRtpOptions.rtpOverRtsp(true),
                  //     ]),
                  //   ),
                  // );
                  // //var file=File();
                  //
    
                  // print("here");
                },
                child: Stack(
                  children: [
                    Container(
                      decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
          color: Colors.black,
    
      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7.0),
    
                        child:Text("widget.image")
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 90.0),child: Container(
                      child:Container(
    
                        height: 20.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Padding(
                              padding: const EdgeInsets.only(right:8.0),
                              child: Text("hello",style: TextStyle(fontSize: 13.0,color:  Colors.black==true? Colors.white:(Colors.white==true)? Colors.white:Colors.white),),
                            ),
    
    
                          ],
                        ),
                      ),
    
    
                    ),),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 10, 14, 14),
    
                ),
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Text("widget.name",style: TextStyle(fontSize: 14.0,color: Colors.white),),
                  )),
                   
    
            ],
          ),
        ),
            ]
          )
        )
      ),
    );
  }


}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Video Viewer Example',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Center(child: SerieExample()),
      ),
    );
  }
}

class SerieExample extends StatefulWidget {

  @override
  _SerieExampleState createState() => _SerieExampleState();
}

class _SerieExampleState extends State<SerieExample> {
 


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Text("hello center"),
      ),
    );
  }
}



// class PortraitVideoExample extends StatelessWidget {
//   const PortraitVideoExample({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Map<String, String> src = {
//       "1":
//           "https://assets.mixkit.co/videos/preview/mixkit-mysterious-pale-looking-fashion-woman-at-winter-39878-large.mp4",
//       "2":
//           "https://assets.mixkit.co/videos/preview/mixkit-winter-fashion-cold-looking-woman-concept-video-39874-large.mp4",
//     };

//     return VideoViewer(
//       language: VideoViewerLanguage.es,
//       source: VideoSource.fromNetworkVideoSources(src),
//       style: VideoViewerStyle(
//         settingsStyle: SettingsMenuStyle(paddingBetween: 10),
//       ),
//     );
//   }
// }
