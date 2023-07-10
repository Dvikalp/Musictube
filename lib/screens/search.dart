import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/searchOperation.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [Colors.blueGrey.shade300,Colors.black,Colors.black])
          ),
          child: Column(
            children: [
              AppBar(
                title: Text('Search Your Song',style: TextStyle(fontSize: 30),),
                actions: [IconButton(onPressed: (){
                  showSearch(context: context, delegate: CustomSearch());
                }, icon: Icon(Icons.search))],
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
            ],
          ),
        ));
  }
}
