import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';

class BottomSheetPage extends StatefulWidget {
  final double height;
  SongInfo songInfo;
  Function changeTrack;
  final GlobalKey<BottomSheetPageState> bottomSheetKey;
   BottomSheetPage(
      {Key? key,
      required this.height,
      required this.bottomSheetKey,
      required this.changeTrack,
      required this.songInfo})
      : super(key: key);

  @override
  State<BottomSheetPage> createState() => BottomSheetPageState();
}

class BottomSheetPageState extends State<BottomSheetPage> {
  double minSongLevel = 0.0;
  double maxSongLevel = 0.0;
  double currentSongLevel = 0.0;
  String currentTime = '', maxTime = '';
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;

  @override
  void dispose() {
    super.dispose();
  }

  void changeStats() {
    setState(() {
      isPlaying = !isPlaying;
    });

    if (isPlaying) {
      player.play();
    } else {
      player.pause();
    }
  }

  String getTimePeriod(double value) {
    Duration duration = Duration(milliseconds: value.round());
    return [duration.inMinutes, duration.inSeconds]
        .map((element) => element.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  void setSong(SongInfo songInfo) async {
    widget.songInfo = songInfo;
    await player.setUrl(widget.songInfo.uri);
    currentSongLevel = minSongLevel;
    maxSongLevel = player.duration!.inMilliseconds.toDouble();
    setState(() {
      currentTime = getTimePeriod(currentSongLevel);
      maxTime = getTimePeriod(maxSongLevel);
    });
    isPlaying = false;
    changeStats();
    player.positionStream.listen((duration) {
      currentSongLevel = duration.inMilliseconds.toDouble();
      setState(() {
        currentTime = getTimePeriod(currentSongLevel);
      });
    });
  }

  double? height;
  @override
  void initState() {
    super.initState();
    height = widget.height;
    setSong(widget.songInfo);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          height = 900;
        });
      },
      child: AnimatedContainer(
        width: double.infinity,
        height: widget.height,
        color: Colors.red,
        duration: const Duration(milliseconds: 500),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            widget.height == 50
                ? Container()
                : WillPopScope(
                    onWillPop: () async {
                      setState(() {
                        height = 50;
                      });
                      return false;
                    },
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        int sen = 8;
                        if (details.delta.dy > sen) {
                          setState(() {
                            height = 50;
                          });
                        }
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.abc),
                            IconButton(
                              icon: Icon(Icons.arrow_drop_down),
                              onPressed: () {
                                setState(() {
                                  height = 50;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
