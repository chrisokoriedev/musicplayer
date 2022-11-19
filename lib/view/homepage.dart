import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicplayer/view/bottomsheet.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentIndex = 0;
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongInfo> songs = [];
  // final GlobalKey<MainMusicSectionState> key =
  //     GlobalKey<MainMusicSectionState>();

  final ScrollController scrollController = ScrollController();
  double height = 50;

  @override
  void initState() {
    super.initState();
    getTrack();
  }

  @override
  void dispose() {
    super.dispose();
    songs.clear();
  }

  void getTrack() async {
    songs = await audioQuery.getSongs();
    setState(() {
      songs = songs;
    });
  }

  void changeTrack(bool isNext) {
    if (isNext) {
      if (currentIndex != songs.length - 1) {
        currentIndex++;
      }
    } else {
      if (currentIndex != 0) {
        currentIndex--;
      }
    }
    // key.currentState.setSong(songs[currentIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 1.0,
      ),
      body: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xff000e24),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff043c4a).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ]),
              child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/placeholder.png'),
                  ),
                  title: Text(
                    songs[index].title,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  ),
                  subtitle: Text(songs[index].artist,
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold)),
                  onTap: () {
                    currentIndex = index;
                  }),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: songs.length),
      bottomSheet: BottomSheetPage(height: height,),
    );
  }

 
}
