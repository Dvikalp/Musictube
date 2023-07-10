import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/music.dart';
import 'app.dart';
class MusicPlayer extends StatefulWidget {
  Music music;
  bool isPlaying;
  MusicPlayer(this.music,this.isPlaying);
  //const MusicPlayer({Key? key}) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState(music,isPlaying);
}

class _MusicPlayerState extends State<MusicPlayer> {
  Music music;
  bool isPlaying;
  _MusicPlayerState(this.music,this.isPlaying);

  Duration duration=Duration.zero;
  Duration position=Duration.zero;
  AudioPlayer _audioPlayer=new AudioPlayer();
  //AudioCache? cache;
  IconData? playBtn;
  @override
  void initState() {
    if(isPlaying){
      playBtn=Icons.pause;
    }
    else{
      playBtn=Icons.play_arrow;
    }
    //cache=AudioCache(fixedPlayer: _audioPlayer);
    /*_audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state==PlayerState.PLAYING;
      });
    });*/
    
    _audioPlayer.onDurationChanged.listen((t){
      setState(() {
        duration=t;
      });
    });

    _audioPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        position=p;
      });
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [Colors.blueGrey.shade300,Colors.black,Colors.black,Colors.black])
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 100,),
            Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(music.image,height: 400,fit: BoxFit.fill,)),
            ),
            SizedBox(height: 50,),
            Container(
              alignment: Alignment.topLeft,
              child: Text(music.name,style: TextStyle(color: Colors.white,fontSize: 30),),
            ),
            SizedBox(height: 10,),
            Container(
              alignment: Alignment.topLeft,
              child: Text(music.desc,style: TextStyle(color: Colors.white70,fontSize: 20),),
            ),
            Container(
              child: SliderTheme(
                data: SliderThemeData(
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                ),
                child: Slider.adaptive(
                  min: 0,
                  max: 240,
                  value: position.inSeconds.toDouble(),
                  onChanged: (value)async{
                    Duration newPos=Duration(seconds: value.toInt());
                    await _audioPlayer.seek(newPos);
                    await _audioPlayer.resume();
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.white70,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${position.inMinutes}:${position.inSeconds.remainder(60)}",style: TextStyle(color: Colors.white),),
                    Text("${duration.inMinutes}:${duration.inSeconds.remainder(60)}",style: TextStyle(color: Colors.white),)
                  ],
                )),
            Container(
              child: IconButton(
                iconSize: 40,
                color: Colors.white,
                onPressed: (){
                  if(!isPlaying){
                    setState(() async {
                      _audioPlayer.stop();
                      await _audioPlayer.play(music.audioUrl,isLocal: false);
                      isPlaying=true;
                      playBtn=Icons.pause;
                    });
                  }
                  else{
                    setState(() async {
                      await _audioPlayer.pause();
                      isPlaying=false;
                      playBtn=Icons.play_arrow;
                    });
                  }
                },
                icon: Icon(playBtn),
              ),
            )
          ],
        ),
      ),
    );
  }
}
