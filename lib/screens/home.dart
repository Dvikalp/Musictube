import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spotify_app/services/moperations.dart';
import 'package:spotify_app/services/operations.dart';
import 'package:spotify_app/models/category.dart';
import 'package:http/http.dart'as http;
import '../models/music.dart';
import '../services/spotify_api.dart';
import 'app.dart';

class Home extends StatefulWidget {
  Function _miniPlayer;
  Home(this._miniPlayer);
  //const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState(_miniPlayer);
}

class _HomeState extends State<Home> {
  Function _miniPlayer;
  _HomeState(this._miniPlayer);
  @override
  Widget createCategory(Catigory category){
    return Container(
      color: Colors.blueGrey.shade400,
      child: Row(
        children: [
          Image.network(category.imageURL,fit:BoxFit.cover),
          Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(category.name,style: TextStyle(color: Colors.white),))
        ],
      ),
    );
  }
  List<Widget> createListofCategories(){
    List<Catigory> categoryList = Operations.getCategories();
    List<Widget> categories=categoryList.map((Catigory category) => createCategory(category)).toList();
    return categories;
  }

  Widget createMusic(Music music){
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              _miniPlayer(music,stop:true);
            },
            child:Column(
              children: [
                Container(
                height: 200,
                width: 200,
                child: Image.network(music.image,fit: BoxFit.cover,),
              ),
              Text(music.name,style: TextStyle(color: Colors.white,fontSize: 20)),
              Text(music.desc,style:TextStyle(color: Colors.white60)),
            ]) ,
          ),
          /*Container(
              height: 200,
              width: 200,
              child: InkWell(
                  onTap: (){
                    _miniPlayer(music,stop:true);
                  },
                  child: Image.network(music.image,fit: BoxFit.cover,))),*/
          //Text(music.name,style: TextStyle(color: Colors.white)),
          //Text(music.desc,style:TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  List<String> audioUrl=[];
  List<String> urlList=['OldTownRoad.mp3','Unholy.mp3','LookAtMe.mp3','RemedyForBrokenHeart.mp3'];
  Future<void> getFromFire() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    audioUrl.clear();
    for(int i=0;i<4;i++){
      Reference audioRef = storage.ref().child(urlList[i]);
      String url = await audioRef.getDownloadURL();
      audioUrl.add(url);
    }
  }


  @override
  void initState() {
    super.initState();

  }


  Widget createMusicList(String label){
    List<Music> musicList =MOperations(audioUrl).getMusic();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.all(10),
            child: Text(label,style: TextStyle(color: Colors.white,fontSize: 40),)),
        Container(
          height: 300,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx,index){
                return createMusic(musicList[index]);
              },
              itemCount: musicList.length,
          ),
        ),]
    );
  }
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future:getFromFire(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          else{
            return SingleChildScrollView(
              child: SafeArea(child: Container(
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
                      padding: EdgeInsets.all(10),
                      height: 220,
                      child: GridView.count(
                        childAspectRatio: 5/2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: createListofCategories(),
                        crossAxisCount: 2,
                      ),
                    ),
                    createMusicList('Music List'),
                    createMusicList('Popular Playlist'),
                  ],
                ),
              )),
            );
          }
        });
  }
}
