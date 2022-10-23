import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

_backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());

  String vp;
}

class AudioPlayerTask extends BackgroundAudioTask {
  final _audioPlayer = AudioPlayer();
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Background Music"),
              actions: [
                IconButton(
                    icon: Icon(Icons.stop),
                    onPressed: () {
                      AudioService.stop();
                    })
              ],
            ),
            body: Center(
              child: Column(
                children: [
                  StreamBuilder<MediaItem>(builder: (_, snapshot) {
                    return Text(snapshot.data?.title ?? "title");
                  }),
                  StreamBuilder<PlaybackState>(
                      stream: AudioService.playbackStateStream,
                      builder: (context, snapshot) {
                        final playing = snapshot.data?.playing ?? false;
                        if (playing)
                          return ElevatedButton(
                              child: Text("Pause"),
                              onPressed: () {
                                AudioService.pause();
                              });
                        else
                          return ElevatedButton(
                              child: Text("Play"),
                              onPressed: () {
                                if (AudioService.running) {
                                  AudioService.play();
                                } else {
                                  AudioService.start(
                                    backgroundTaskEntrypoint:
                                        _backgroundTaskEntrypoint,
                                  );
                                }
                              });
                      }),
                  ElevatedButton(
                      onPressed: () async {
                        await AudioService.skipToNext();
                      },
                      child: Text("Next Song")),
                  ElevatedButton(
                      onPressed: () async {
                        await AudioService.skipToPrevious();
                      },
                      child: Text("Previous Song")),
                  StreamBuilder<Duration>(
                    stream: AudioService.positionStream,
                    builder: (_, snapshot) {
                      final mediaState = snapshot.data;
                      return Slider(
                        value: mediaState?.inSeconds?.toDouble() ?? 0,
                        min: 0,
                        onChanged: (val) {
                          AudioService.seekTo(Duration(seconds: val.toInt()));
                        },
                      );
                    },
                  )
                ],
              ),
            )));
  }
}
