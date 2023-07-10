import 'package:chewie/chewie.dart';
import 'package:spotify_app/services/voperations.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchMusic extends StatefulWidget {
  const WatchMusic({Key? key}) : super(key: key);

  @override
  State<WatchMusic> createState() => _WatchMusicState();
}

class _WatchMusicState extends State<WatchMusic> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [Colors.blueGrey.shade300,Colors.black,Colors.black])
          ),
          child: Column(
            children: [
              AppBar(
                title: Text('Good Morning',style: TextStyle(fontSize: 30),),
                actions: [Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.settings))],
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              SizedBox(height: 10,),
              Container(
                child: Column(
                  children: [
                    VideoItems(
                      videoID: 'nVjsGKrE6E8',
                    ),
                    VideoItems(
                        videoID:'e-ORhEE9VVg'
                    )
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
