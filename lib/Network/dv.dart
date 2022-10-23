import 'package:bitslogicxplayer/Network/downloading_dialog.dart';
import 'package:bitslogicxplayer/Network/downloadmp3.dart';
import 'package:bitslogicxplayer/info.dart';
import 'package:flutter/material.dart';

class Dv extends StatelessWidget {
  const Dv({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YoMate Player',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'YoMate Player'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController search = TextEditingController();
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Info()));
              }),
        title: const Text("Download video File"),
        backgroundColor: Colors.blue[300],
      ),
      body: SafeArea(
        child: Stack(
          children:[
          Center(
            child: Image.asset(
                    "assets/ylogo.png",
                    alignment: Alignment.center,
                    width:double.infinity,
                    height: double.infinity, 
                    color: Colors.black12.withOpacity(0.1),
                    
                  ),
          ),
            Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 40,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Please enter song url',
                  hintText: 'Enter url',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                controller: search,
              ),
              SizedBox(
                height: 30,
              ),
               TextFormField(
                decoration: InputDecoration(
                  labelText: 'Please enter song url',
                  hintText: 'Enter song url',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                controller: search,
              ), SizedBox(
                height: 30,
              ),
               TextFormField(
                decoration: InputDecoration(
                  labelText: 'Please enter song name to store in phone storage',
                  hintText: 'Enter song name',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                controller: name,
              ),
              FloatingActionButton(
                backgroundColor: Colors.blue[300],
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => DownloadingDialogV(search.text,name.text),
                  );
                },
                tooltip: 'Download File',
                child: const Icon(Icons.download),
              ),
            ],
          )),
          ] 
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
