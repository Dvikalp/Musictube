import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify_app/models/music.dart';
import 'package:spotify_app/screens/musicplayer.dart';
import 'package:spotify_app/screens/search.dart';
import 'package:spotify_app/screens/watch.dart';
import 'package:spotify_app/services/spotify_api.dart';
import 'home.dart';
import 'package:spotify_app/services/spotify_api.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final String artistID= '06HL4z0CvFAxyc27GXpf02';
  AudioPlayer _audioPlayer=new AudioPlayer();
  var Tabs=[];
  int currentTabIndex=0;
  Music? music;
  bool isPlaying=false;


  Widget MiniPlayer(Music? music,{bool stop =false}){
    this.music=music;
    if(music==null){
      return SizedBox();
    }
    if(currentTabIndex==2){
      _audioPlayer.stop();
      return SizedBox();
    }
    if(stop){
      isPlaying=false;
      _audioPlayer.stop();
    }
    setState(() {});
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>MusicPlayer(music,isPlaying))
        );
        //_audioPlayer.stop();
      },
      child:AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: Colors.blueGrey,
        height: 50,
        margin: EdgeInsets.only(left: 10,right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(music.image,fit: BoxFit.cover,),
            Text(music.name,style: TextStyle(color: Colors.white),),
            IconButton(onPressed: ()async{
              isPlaying=!isPlaying;
              if(isPlaying){
                await _audioPlayer.play(music.audioUrl);
              }
              else{
                await _audioPlayer.pause();
              }
              setState(() {});
            }, icon: isPlaying?Icon(Icons.pause,color: Colors.white,)
                :Icon(Icons.play_arrow,color: Colors.white,)),
          ],
        ),
      ) ,
    );
  }
  @override


  Future<void> apicalls() async {
    SpotifyApi.getArtist(artistID);

}
  void initState()  {
    super.initState();
    //apicalls();
    Tabs=[Home(MiniPlayer),Search(),WatchMusic()];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
                body: Tabs[currentTabIndex],
                backgroundColor: Colors.black,
                bottomNavigationBar: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MiniPlayer(music),
                      BottomNavigationBar(
                        currentIndex: currentTabIndex,
                        onTap: (currentIndex) {
                          currentTabIndex = currentIndex;
                          setState(() {});
                        },
                        selectedLabelStyle: TextStyle(color: Colors.white),
                        backgroundColor: Colors.black26,
                        fixedColor: Colors.white,
                        unselectedItemColor: Colors.white,
                        items: [
                          BottomNavigationBarItem(
                              icon: Icon(Icons.music_note, color: Colors.white),
                              label: 'Listen'),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.search, color: Colors.white),
                              label: 'Search'),
                          BottomNavigationBarItem(icon: Icon(
                              Icons.ondemand_video_outlined, color: Colors.white),
                              label: 'Watch'),
                        ],
                      ),
                    ]
                )
            );
          }
  }