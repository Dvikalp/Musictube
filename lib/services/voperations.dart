import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoItems extends StatefulWidget {
  final String videoID;
  const VideoItems({required this.videoID});

  @override
  State<VideoItems> createState() => _VideoItemsState(videoID);
}

class _VideoItemsState extends State<VideoItems> {
  final String videoID;
  _VideoItemsState(this.videoID);
  // late ChewieController chewieController;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   chewieController=ChewieController(
  //     videoPlayerController: videoPlayerController,
  //       aspectRatio:5/8,
  //       autoInitialize: true,
  //       autoPlay: false,
  //       looping: false,
  //       errorBuilder: (context, errorMessage) {
  //         return Center(
  //           child: Text(
  //             errorMessage,
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         );
  //   },);}
  // @override
  // void dispose() {
  //   super.dispose();
  //   chewieController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: YoutubePlayer(
          controller: YoutubePlayerController(
              initialVideoId: videoID,
              flags: YoutubePlayerFlags(autoPlay: false, loop: false)),
          showVideoProgressIndicator: true,

        ));
  }
}
