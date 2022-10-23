import 'package:bitslogicxplayer/Audio/play.dart';
import 'package:bitslogicxplayer/Video/folders.dart';
import 'package:bitslogicxplayer/features/shared/ui/screens/NowPlaying.dart';
import 'package:bitslogicxplayer/newFile.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:file_picker/file_picker.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:just_audio/just_audio.dart';

class SongList extends StatefulWidget {
  SongList({Key? key}) : super(key: key);

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  final audioQuery = new OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();
  List<SongModel> songmodelList = [];
  @override
  void initState() {
    // TODO: implement initState

    requestPermission();
  }

  requestPermission() {
    Permission.storage.request();
  }

  playSong(String? uri) {
    try {
      audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri.toString())));
      audioPlayer.play();
    } on Exception {
      log("error parsing song");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("YoMate MP3"),
          backgroundColor: Colors.lightBlue[200],
        ),
        body: FutureBuilder<List<SongModel>>(
          future: audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true,
          ),
          builder: (context, item) {
            songmodelList.addAll(item.data!);
            if (item.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
                child: Stack(children: [
              ListView.builder(
                itemBuilder: (context, index) {
                  songmodelList.addAll(item.data!);
                  return Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            Color(0xC4A484),
                            Color(0xFFFDD0),
                            Color(0xFFFFED),
                          ], // Gr)),
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 4.0,
                              offset: Offset(-4, -4),
                              color: Colors.white),
                          BoxShadow(
                              blurRadius: 4.0,
                              offset: Offset(4, 4),
                              color: Colors.black12),
                        ]),
                    child: ListTile(
                      leading: QueryArtworkWidget(
                        id: item.data![index].id,
                        type: ArtworkType.AUDIO,
                        artworkFit: BoxFit.cover,
                        artworkScale: 10,
                        nullArtworkWidget: Image.asset("assets/mr1.png"),
                      ),
                      title: Text(
                        item.data![index].displayName,
                        style: TextStyle(fontSize: 15),
                      ),
                      onTap: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Play(
                                    song: item.data![index],
                                    audioPlayer: audioPlayer,
                                    songModelList: [],
                                  )),
                        );
                      }),
                    ),
                  );
                },
                itemCount: item.data!.length,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NowPlaying(
                                songModelList: songmodelList,
                                audioPlayer: audioPlayer)));
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 15, 15),
                    child: const CircleAvatar(
                      backgroundColor: Colors.lightBlue,
                      radius: 30,
                      child: Icon(
                        color: Colors.white,
                        Icons.play_arrow,
                      ),
                    ),
                  ),
                ),
              ),
            ]));
          },
        ));
  }
}

class Play extends StatefulWidget {
  Play(
      {Key? key,
      required this.song,
      required this.audioPlayer,
      required List songModelList})
      : super(key: key);
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
        ? setState(() {
            widget.audioPlayer.seekToNext();
          })
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
                        print(widget.audioPlayer.hasNext);
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
                          print(widget.audioPlayer.hasNext);
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
