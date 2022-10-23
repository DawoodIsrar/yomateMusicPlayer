import 'package:explorer/explorer.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:explorer/explorer.dart';
import 'package:explorer/explorer_io.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Directory appDocDir = await getApplicationDocumentsDirectory();
  runApp(Exploror(appDocDir: appDocDir,));
}

class Exploror extends StatefulWidget {
  const Exploror({
    required this.appDocDir,
   Key? key,
  }) : super(key: key);

  final Directory appDocDir;

  @override
  _ExplororState createState() => _ExplororState();
}

class _ExplororState extends State<Exploror> {
  late ExplorerController _controller;

  @override
  void initState() {
    _controller = ExplorerController(
      provider: IoExplorerProvider(
        entryPath: widget.appDocDir.path,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void filePressed(ExplorerFile file) {
    if (file.size! > 200000) {
      final snackBar =
          SnackBar(content: Text('Can\'t open files with size > 200kb'));

      // Find the Scaffold in the widget tree and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        localizationsDelegates: [
          ExplorerLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('ru', ''),
          const Locale('fr', ''),
        ],
        home: Scaffold(
          body: Explorer(
            controller: _controller,
            builder: (_) => [
              ExplorerToolbar(),
              ExplorerActionView(),
              ExplorerFilesGridView(),
            ],
            filePressed: filePressed,
          ),
        ),
      );
}