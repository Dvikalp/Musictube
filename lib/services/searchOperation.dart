import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../screens/search.dart';

class CustomSearch extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(onPressed: (){
        query=' ';
      }, icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  // final CollectionReference songsCollection =
  // FirebaseFirestore.instance.collection('songs');
  // final FirebaseStorage storage = FirebaseStorage.instance;
  late String url;
  Future<void> getFromFire() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    for(int i=0;i<4;i++){
      Reference audioRef = storage.ref().child(query);
      url = await audioRef.getDownloadURL();
      print(url);
    }
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<void>(
      // future: songsCollection.where('title', isEqualTo: query).get(),
      future: getFromFire(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return Container(child: Text(url),);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text('No results found.');
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }

  ThemeData appBarTheme(BuildContext context){
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blueGrey.shade300,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
     primaryColor: Colors.white,
    );
  }
  
}