import 'package:bitslogicxplayer/provider/song_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';

import 'features/shared/ui/screens/AllSongs.dart';

class Audio extends StatelessWidget {
  const Audio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const AllSongs(),
    );
  }
}
