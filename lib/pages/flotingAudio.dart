import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulrelief/pages/songpage.dart';

import '../builders/gradienticon.dart';
import '../contollers/currentSongContoller.dart';
import '../models/initalizeHive.dart';

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
  final CurrentSongHive = SingleSongHive.initSingleSongDataHive();

  @override
  initState(){
    super.initState();
    //setSong();
  }

  bool isfirst = true;
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
        child:Column(
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
                    child: Image.asset("assets/kdefult.png",
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${CurrentSongHive.get("currentSong")?.songName}',
                          //'${data!['song_name']}',
                          style: TextStyle(color: Colors.black),
                          // maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      SizedBox(width: 8, height: 8),
                      Text('${CurrentSongHive.get("currentSong")?.singerName}',
                          //'${data!['singer_name']}',
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
                    SongPage(songID: currnetSongController.currentSongID,).createState().initState();

                    widget.onTap!();
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
        )

        /*isfirst?
        FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          //future: db.collection("AllSongsList").doc(currnetSongController.currentSongID).get(),

          builder: (_, snapshot) {
            WidgetsBinding.instance.addPostFrameCallback((_){

              if(isfirst){
                setState(() {
                  isfirst = false;
                });
                log(isfirst.toString());
              }

            });

            log("hello ${snapshot.connectionState}");
            //  log( currnetSongController.currentSongID);


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
                          child: Image.asset("assets/kdefult.png",
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${CurrentSongHive.get("currentSong")?.songName}',
                                //'${data!['song_name']}',
                                style: TextStyle(color: Colors.black),
                                // maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            SizedBox(width: 8, height: 8),
                            Text('${CurrentSongHive.get("currentSong")?.singerName}',
                                //'${data!['singer_name']}',
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
                          SongPage(songID: currnetSongController.currentSongID,).createState().initState();

                          widget.onTap!();
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
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Some Thing went wrong please try restating the Application ",
                  overflow: TextOverflow.visible,
                  style: TextStyle(),
                ),
              );
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: Text(
                      "Some Thing went wrong please try restating the Application ${snapshot.hasError}",
                      overflow: TextOverflow.visible,
                      style: TextStyle(),
                    ),
                  );

                  break;

                case ConnectionState.waiting:
                  return Column(
                    children: [
                      Center(child: CircularProgressIndicator()),
                      Center(
                        child: Text("Please wait While loading"),
                      ),
                    ],
                  );
                  // children =  [
                  //   Center(child: Text("Please wait While loading"),),
                  //
                  // ];
                  break;
                case ConnectionState.active:
                  return Center(child: CircularProgressIndicator());

                  // children =  [
                  //         Center(child: CupertinoActivityIndicator()),
                  //       ];
                  break;
                case ConnectionState.done:
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
                              child: Image.asset("assets/kdefult.png",
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
                              SongPage(songID: currnetSongController.currentSongID,).createState().initState();

                              widget.onTap!();
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
                  break;
              }

            }

            return Center(child: CircularProgressIndicator(color: Colors.red,));
          },
        )
            : currnetSongController.obx(
          (data)=> FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          //  future: db.collection("AllSongsList").doc(currnetSongController.currentSongID).get(),
            builder: (_, snapshot) {
              log("hello ${snapshot.connectionState}");
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
                            child: Image.asset("assets/kdefult.png",
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
                     //       setSong();
                            SongPage(songID:currnetSongController.currentSongID ,).createState().initState();
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
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Some Thing went wrong please try restating the Application ",
                    overflow: TextOverflow.visible,
                    style: TextStyle(),
                  ),
                );
              } else {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: Text(
                        "Some Thing went wrong please try restating the Application ",
                        overflow: TextOverflow.visible,
                        style: TextStyle(),
                      ),
                    );

                    break;

                  case ConnectionState.waiting:
                    return Column(
                      children: [
                        Center(child: CircularProgressIndicator()),
                        Center(
                          child: Text("Please wait While loading"),
                        ),
                      ],
                    );
                    // children =  [
                    //   Center(child: Text("Please wait While loading"),),
                    //
                    // ];
                    break;
                  case ConnectionState.active:
                    return Center(child: CircularProgressIndicator());

                    // children =  [
                    //         Center(child: CupertinoActivityIndicator()),
                    //       ];
                    break;
                  case ConnectionState.done:
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
                                child: Image.asset("assets/kdefult.png",
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
                                SongPage(songID: currnetSongController.currentSongID,).createState().initState();

                                widget.onTap!();
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
                    break;
                }

              }

              return Center(child: CircularProgressIndicator());
            },

          ),
        )*/


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


/*
FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          //  future: db.collection("AllSongsList").doc(currnetSongController.currentSongID).get(),
            builder: (_, snapshot) {
              log("hello ${snapshot.connectionState}");
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
                            child: Image.asset("assets/kdefult.png",
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
                     //       setSong();
                            SongPage(songID:currnetSongController.currentSongID ,).createState().initState();
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
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Some Thing went wrong please try restating the Application ",
                    overflow: TextOverflow.visible,
                    style: TextStyle(),
                  ),
                );
              } else {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: Text(
                        "Some Thing went wrong please try restating the Application ",
                        overflow: TextOverflow.visible,
                        style: TextStyle(),
                      ),
                    );

                    break;

                  case ConnectionState.waiting:
                    return Column(
                      children: [
                        Center(child: CircularProgressIndicator()),
                        Center(
                          child: Text("Please wait While loading"),
                        ),
                      ],
                    );
                    // children =  [
                    //   Center(child: Text("Please wait While loading"),),
                    //
                    // ];
                    break;
                  case ConnectionState.active:
                    return Center(child: CircularProgressIndicator());

                    // children =  [
                    //         Center(child: CupertinoActivityIndicator()),
                    //       ];
                    break;
                  case ConnectionState.done:
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
                                child: Image.asset("assets/kdefult.png",
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
                                SongPage(songID: currnetSongController.currentSongID,).createState().initState();

                                widget.onTap!();
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
                    break;
                }

              }

              return Center(child: CircularProgressIndicator());
            },

          ),
 */