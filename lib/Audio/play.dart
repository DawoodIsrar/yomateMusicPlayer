import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter/cupertino.dart';

class Play extends StatefulWidget {
  Play({Key? key, required this.audioPlayer, required this.song})
      : super(key: key);
  final List<SongModel> songModelList = [];
  final SongModel song;
  final AudioPlayer audioPlayer;
  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> {
  Duration d = Duration();
  Duration p = Duration();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playSong();
  }

  bool isPlayng = false;
  playSong() {
    try {
      widget.audioPlayer.setAudioSource(AudioSource.uri(
        Uri.parse(widget.song.uri!),
        tag: MediaItem(
          // Specify a unique ID for each media item:
          id: '${widget.song.id}',
          // Metadata to display in the notification:
          album: "${widget.song.album}",
          title: "${widget.song.displayNameWOExt}",
          artUri: Uri.parse('${widget.song.artistId}}'),
          artist: "${widget.song.artist}",
        ),
      ));
      widget.audioPlayer.play();
      isPlayng = true;
    } on Exception {
      log("error parsing song");
    }
    widget.audioPlayer.durationStream.listen((duration) {
      setState(() {
        d = duration!;
      });
    });
    widget.audioPlayer.positionStream.listen((pos) {
      setState(() {
        p = pos;
      });
    });
  }

  void SliderChange(int seconds) {
    Duration d = Duration(seconds: seconds);
    widget.audioPlayer.seek(d);
  }

  void next(AudioPlayer audioPlayer) {
    audioPlayer.hasNext
        ? widget.audioPlayer.seekToNext()
        : setState(() {
            widget.audioPlayer.seekToNext();
          });
  }

  void prev(AudioPlayer audioPlayer) {
    widget.audioPlayer.seekToPrevious();
    setState(() {
      widget.audioPlayer.seekToPrevious();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YoMate MP3"),
        backgroundColor: Colors.lightBlue[200],
      ),
      body: SafeArea(
          child: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: QueryArtworkWidget(
            id: widget.song.id,
            type: ArtworkType.AUDIO,
            nullArtworkWidget: Icon(
              Icons.music_note,
              size: 35,
            ),
            keepOldArtwork: true,
          ),
        ),
        Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFFFFFF),
                Color(0xff81D4F4),
              ], // Gr)),
            )),
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.black26,
                    radius: 150,
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(top: 10),
                            width: 150,
                            height: 150,
                            child: QueryArtworkWidget(
                              id: widget.song.id,
                              type: ArtworkType.AUDIO,
                              keepOldArtwork: true,
                              nullArtworkWidget: Image.asset("assets/mr1.png"),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.song.displayNameWOExt,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.song.artist.toString(),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(p.toString().split(".")[0]),
                    Expanded(
                        child: Slider(
                            activeColor: Colors.black54,
                            min: const Duration(microseconds: 0)
                                .inSeconds
                                .toDouble(),
                            value: p.inSeconds.toDouble(),
                            max: d.inSeconds.toDouble(),
                            onChanged: (value) {
                              setState(() {
                                SliderChange(value.toInt());
                                value = value;
                              });
                            })),
                    Text(d.toString().split(".")[0]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (widget.audioPlayer.hasPrevious) {
                            widget.audioPlayer.seekToPrevious();
                          }
                        });
                      },
                      child: Icon(Icons.skip_previous, size: 50),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (isPlayng) {
                              widget.audioPlayer.pause();
                            } else {
                              widget.audioPlayer.play();
                            }
                            isPlayng = !isPlayng;
                          });
                        },
                        icon: Icon(
                          isPlayng ? Icons.pause : Icons.play_arrow,
                          size: 50,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (widget.audioPlayer.hasNext) {
                            widget.audioPlayer.seekToNext();
                          }
                        });
                      },
                      child: Icon(Icons.skip_next, size: 50),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              ],
            )),
      ])),
    );
  }
}
