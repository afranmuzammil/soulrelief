import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../builders/gradienticon.dart';
import '../contollers/currentSongContoller.dart';

class MiniPlayer extends StatefulWidget {
  MiniPlayer({Key? key,  this.onTap, this.onClose, this.songId}) : super(key: key);
  final Function? onTap;
  final Function? onClose;
  final String? songId;
  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  final db = FirebaseFirestore.instance;
  CurrnetSongController currnetSongController = Get.put(CurrnetSongController());

  @override
  initState(){
    super.initState();
    //setSong();
  }

  var songsIdFromController = "1rMHGBUIIxHxFX43Wef7Xhx97RlU_NHQ9";

  void setSong(){
    log("from set song");
    setState((){
      songsIdFromController = currnetSongController.currentSongID;
    });



  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return Container(
      color: Colors.white,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 71.0,
        child:currnetSongController.obx(
          (data)=> FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: db.collection("AllSongsList").doc( currnetSongController.currentSongID).get(),

            builder: (_, snapshot) {
              log("hello $data");
            //  log( currnetSongController.currentSongID);
              if (snapshot.hasError) return Text('Error = ${snapshot.error}');

              if (snapshot.hasData) {
                var data = snapshot.data!.data();
                var value = data!['song_name'];
                log("song name $value");


                return Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => widget.onTap!(),
                          // onTap: () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => Player()),
                          //   );
                          // },
                          child: Container(
                            width: 70,
                            height: 70,
                            child: Image.asset("assets/hidersiaf.png",
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${data!['song_name']}',
                                  style: TextStyle(color: Colors.black),
                                 // maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                              SizedBox(width: 8, height: 8),
                              Text('${data!['singer_name']}',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 12),
                                  //maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Icon(Icons.favorite_border, color:Colors.black),
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            log("ontap");
                            widget.onTap!();
                            setSong();
                          },
                          child: RadiantGradientMask(
                            child: Icon(Icons.play_arrow,
                                color: Colors.white, size: 30),
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                    Divider(color: colorTheme.background, height: 1),
                  ],
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        )
        /*Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => widget.onTap(),
                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => Player()),
                  //   );
                  // },
                  child: Container(
                    width: 70,
                    height: 70,
                    child: Image.asset("assets/hidersiaf.png",
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Wurkit (Original Mix)',
                          style: TextStyle(color: Colors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      SizedBox(width: 8, height: 8),
                      Text('Kyle Watson',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Icon(Icons.favorite_border, color: colorTheme.onPrimary),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {},
                  child: RadiantGradientMask(
                    child: Icon(Icons.play_arrow,
                        color: Colors.white, size: 30),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
            Divider(color: colorTheme.background, height: 1),
          ],
        ),*/
      ),
    );
  }
}
