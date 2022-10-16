import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:soulrelief/pages/home.dart';
import '../builders/gradienticon.dart';
import '../builders/gradienttext.dart';
import '../contollers/common.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:we_slide/we_slide.dart';
import 'package:rxdart/rxdart.dart';

import '../models/StorageModel.dart';
import '../models/initalizeHive.dart';
import '../widgets/letestcards.dart';

class SongPage extends StatefulWidget {
  const SongPage({Key? key, required this.songID}) : super(key: key);
  final String songID;

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  final _player = AudioPlayer();
  final db = FirebaseFirestore.instance;
  final likedListHive = LikedListHive.initLikedListDataHive();
  final likedSongsHive = LikedSongsHive.initLikedSongsDataHive();
  final recentSongsHive = RecentSongHive.initRecentSongDataHive();
  final recentSongListHive = RecentSongListHive.initRecentSongListDataHive();
  List<String> addinginList = [];
  var t = true;
  /// String songId="12ig9Z23DlI2frx0pb8DozUcqGrYsg7vQ";
  String? songId;

  //_SongPageState(this.songId);
  // var duration = await player.setUrl('https://foo.com/bar.mp3');
  // var duration = await player.setFilePath('/path/to/file.mp3');
  // var duration = await player.setAsset('path/to/asset.mp3');

  List songIDList = [];


  @override
  void initState() {
    addinginList = likedListHive.get("likedSongs")?.songID??[];
    songId = widget.songID;
    print("songid : $songId");
    super.initState();
    // WidgetsBinding.instance?.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // statusBarColor: Colors.black,
    ));


    _init();
  }

  List<DocumentSnapshot>? documentList;


  Future<void> _init() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    // Try to load audio from a source and catch any errors.
    try {
      await _player.setAudioSource(AudioSource.uri(
        Uri.parse(
            "https://drive.google.com/uc?export=view&id=$songId"),
        tag: MediaItem(
          // Specify a unique ID for each media item:
          id: '1',
          // Metadata to display in the notification:
          album: "Album name",
          title: "Song name",
          artUri: Uri.parse("https://drive.google.com/uc?export=view&id=$songId"),
        ),
      )); //1-HPfLLirpw2REb-quLmxq6MyEtQ3jZep

      await FirebaseFirestore.instance
          .collection("song_ids_list").doc("song_ids").get().then((value) =>
      {
        log("whrere ${value["all_ids"][0]}"),

        setState(() {
          for (int i = 0; i <= value["all_ids"].length; i++) {
            if (songIDList.contains(value["all_ids"][i]) == false) {
              songIDList.add(value["all_ids"][i]);
              log("hello ${songIDList}");
            }
          }
        }),

      });



      // s.map((event) => log(event.data().toString()));


    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  nextSong() {
    int currentSongIndex = songIDList.indexOf(songId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        log("currnt index $currentSongIndex song list ${songIDList.length}");
        if (songIDList.length != (currentSongIndex+1)) {
          songId = songIDList[currentSongIndex + 1];

        }
      });
    });
  }

  prvSong() {
    int currentSongIndex = songIDList.indexOf(songId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if(songIDList.length != 1){
          songId = songIDList[currentSongIndex - 1];
        }

      });
    });
  }



  addSongToRecent(songID,songName,artistName,audioLength,songImage){
    List<String> listOfRecentSong = recentSongListHive.get("recentSongs")?.songID??[];

    if(listOfRecentSong.contains(songID)== false){
      final songData = RecentSong(songName, songID, artistName, audioLength, songImage);
      if(listOfRecentSong.length == 5){
        listOfRecentSong.removeLast();
      }
      recentSongsHive.put("$songID", songData).then((value) {

        setState(() {
          listOfRecentSong.add("$songID");
            t=false;
        });

        final SongId = RecentSongList(listOfRecentSong);
        recentSongListHive.put("recentSongs", SongId);
      });
    }

  }

  @override
  void dispose() {
    // WidgetsBinding.instance?.removeObserver(this);
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
              (position, bufferedPosition, duration) =>
              PositionData(
                  position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    final WeSlideController _controller = WeSlideController();
    final double _panelMinSize = 127.0;
    final double _panelMaxSize = MediaQuery
        .of(context)
        .size
        .height;
    final size = MediaQuery
        .of(context)
        .size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            // IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.black87,)),
            IconButton(onPressed: () {

                log(recentSongListHive.get("recentSongs")!.songID.toString());

            }, icon: Icon(Icons.more_vert, color: Colors.black87,))
          ],
          // title: GradientText(
          //   "Albums",
          //   style: TextStyle(
          //       color: Color(0xFF5F7185),
          //       fontSize: 20,
          //       fontFamily: GoogleFonts.poppins().fontFamily,
          //       fontWeight: FontWeight.bold),
          //   gradient: LinearGradient(colors: [
          //     Color(0xffdf99da), Color(0xff668fd7)
          //   ]),
          // ),
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black,), onPressed: () {
            Navigator.of(context).pop();
          },),
          centerTitle: true,
        ),
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: db.collection("AllSongsList").doc(songId).get(),
          builder: (_, snapshot) {
            if (snapshot.hasError) return Text('Error = ${snapshot.error}');

            if (snapshot.hasData) {
              var data = snapshot.data!.data();
              var value = data!['song_name'];
              log("song name $value");

              if(t){
              addSongToRecent(data!['song_id'],data!['song_name'],data!['singer_name'],data!['audio_length'],data!['audio_image']);

              }
              return Container(
                height: height,
                width: width,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(

                      children: [
                        // Container(
                        //   height: height * 0.2,
                        //   width: width,
                        //   // color: Colors.red,
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Image(
                        //         image: AssetImage(
                        //           "assets/tarnana.png",
                        //         ),
                        //         height: height * 0.12,
                        //         width: width * 0.3,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          elevation: 10,
                          shadowColor: Color(0xFFC3539A),
                          child: SizedBox(
                              height: height * 0.66,
                              width: width * 0.85,

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GradientText(
                                    "${data!['song_name']}",
                                    style: TextStyle(
                                        color: Color(0xFF5F7185),
                                        fontSize: 18,
                                        fontFamily: GoogleFonts
                                            .poppins()
                                            .fontFamily,
                                        fontWeight: FontWeight.bold),
                                    gradient: LinearGradient(colors: [
                                      Color(0xffdf99da), Color(0xff668fd7)
                                    ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 22, 0.0, 50),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16.0),
                                      ),
                                      shadowColor: Color(0xFFC3539A),
                                      elevation: 20,
                                      child: Container(
                                        height: height * 0.25,
                                        width: width * 0.45,
                                        decoration: BoxDecoration(

                                          borderRadius: BorderRadius.all(Radius.circular(14)),
                                          // color: pictureBG,
                                          image: DecorationImage(fit: BoxFit.fill,
                                              image: AssetImage("assets/Allama Iqbal.png")
                                            //NetworkImage(
                                            //  "${Product.products[index].imageUrl}")
                                            // CachedNetworkImageProvider(
                                            //   items.body["featuredClothingItems"][index]["coverImage"]
                                            //       .toString(),
                                            // ),
                                          ),
                                        ),
                                        // child: CachedNetworkImage(
                                        //   placeholder: (context, imgUrl) => const Text("Image is loading"),
                                        //   imageUrl: products.body["items"][index]["coverImage"].toString(),
                                        // ),
                                      ),
                                    ),
                                  ),
                                  StreamBuilder<PositionData>(
                                    stream: _positionDataStream,
                                    builder: (context, snapshot) {
                                      final positionData = snapshot.data;
                                      return SeekBar(

                                        duration: positionData?.duration ?? Duration.zero,
                                        position: positionData?.position ?? Duration.zero,
                                        bufferedPosition:
                                        positionData?.bufferedPosition ?? Duration.zero,
                                        onChangeEnd: _player.seek,
                                      );
                                    },
                                  ),
                                  Row(

                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [

                                      ControlButtons(_player, songIdList: songIDList,
                                        currentSongID: songId!,
                                        Nextsong: () {
                                          nextSong();
                                        },
                                        prvsong: () {
                                          prvSong();
                                        },),


                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton( onPressed: () {

                                          if(addinginList.contains(data!['song_id'])== false){
                                            final songData = LikedSong("${data!['song_name']}", "${data!['song_id']}", "${data!['singer_name']}", "${data!['audio_length']}","{data!['audio_image']}");
                                            likedSongsHive.put("${data!['song_id']}", songData).then((value) {

                                              setState(() {
                                                addinginList.add("${data!['song_id']}");
                                              });

                                              final SongId = LikedList(addinginList);
                                              likedListHive.put("likedSongs", SongId);
                                            });
                                          }
                                          if(addinginList.contains(data!['song_id'])== true){

                                            likedSongsHive.delete(data!['song_id']).then((value) {

                                              setState(() {
                                                addinginList.remove("${data!['song_id']}");
                                              });

                                              final SongId = LikedList(addinginList);
                                              likedListHive.put("likedSongs", SongId);
                                            });
                                          }


                                      }, icon: addinginList.contains(data!['song_id'])?RadiantGradientMask(child: Icon(Icons.favorite,color:Colors.white,),)
                                          :Icon(Icons.favorite_border,color:Color(0XFF5F7185),)
                                        ,),
                                        Text("${data!['album_name']}".toUpperCase(),style :TextStyle(
                                            color: Color(0xFF5F7185),
                                            fontSize: 16,
                                            fontFamily: GoogleFonts.poppins().fontFamily,
                                            fontWeight: FontWeight.w600)),
                                        IconButton( onPressed: () {
                                          const snackBar = SnackBar(
                                            // padding:EdgeInsets.only(bottom: 10),

                                            content: Text('Coming soon ',style: TextStyle(color: Colors.black),),
                                            behavior: SnackBarBehavior.floating,
                                            //      elevation: 10,
                                            backgroundColor: Colors.white,
                                            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                            // action: SnackBarAction(
                                            // //  label: 'Undo',
                                            //   onPressed: () {
                                            //     // Some code to undo the change.
                                            //   },
                                            // ),
                                          );

                                          // Find the ScaffoldMessenger in the widget tree
                                          // and use it to show a SnackBar.
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        }, icon: Icon(Icons.playlist_add,color:Color(0XFF5F7185),) ,),
                                    ],
                                  )
                                  //  ControlButtons(_player),
                                  // Display seek bar. Using StreamBuilder, this widget rebuilds
                                  // each time the position, buffered position or duration changes.

                                ],
                              )
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: height,
                          width: width * 0.85,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff3B4C77), Color(0xffD1549E)],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            // color: pictureBG,

                          ),
                          child: ContainedTabBarView(
                            tabBarProperties: TabBarProperties(
                              indicatorColor: Colors.white,
                            ),
                            initialIndex: 1,
                            tabs: [
                              Text('Next'),
                              Text('Lyrics'),
                              Text("Info")
                            ],
                            views: [
                              Container(
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: db.collection('AllSongsList').snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {
                                      return
                                        ListView(
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          children: snapshot.data!.docs
                                              .map((doc) =>
                                              ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    songId = doc["song_id"].toString();
                                                    _init();
                                                  });
                                                  print(doc["song_id"].toString());
                                                },
                                                leading: Container(
                                                  height: height * 0.06,
                                                  width: width * 0.12,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(0)),
                                                    // color: pictureBG,
                                                    image: DecorationImage(fit: BoxFit.fill,
                                                        image: AssetImage('assets/hqdefault.png')
                                                      //NetworkImage(
                                                      //  "${Product.products[index].imageUrl}")
                                                      // CachedNetworkImageProvider(
                                                      //   items.body["featuredClothingItems"][index]["coverImage"]
                                                      //       .toString(),
                                                      // ),
                                                    ),
                                                  ),
                                                  // child: CachedNetworkImage(
                                                  //   placeholder: (context, imgUrl) => const Text("Image is loading"),
                                                  //   imageUrl: products.body["items"][index]["coverImage"].toString(),
                                                  // ),
                                                ),
                                                title: Text(doc["song_name"].toString(),
                                                  style: TextStyle(color: Colors.white),),
                                                subtitle: Text("${doc["singer_name"]
                                                    .toString()} • ${doc["audio_length"]
                                                    .toString()}",
                                                    style: TextStyle(color: Colors.white)),
                                                trailing: IconButton(onPressed: () {},
                                                  icon: Icon(Icons.more_vert),
                                                  color: Colors.white,),
                                              ),


                                          ).toList(),
                                        );

                                      // ListView.builder(
                                      //     scrollDirection: Axis.vertical,
                                      //     shrinkWrap: true,
                                      //     physics: ScrollPhysics(),
                                      //     itemCount: 3,
                                      //     itemBuilder: (BuildContext context,int index){
                                      //
                                      //     });
                                    }
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "${data["lyrics"].toString()}",
                                  maxLines: 10,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontFamily: GoogleFonts
                                          .poppins()
                                          .fontFamily,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container()
                            ],
                            onChange: (index) => print(index),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        )


    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;
  final List songIdList;
  final String currentSongID;
  final VoidCallback Nextsong;
  final VoidCallback prvsong;

  const ControlButtons(this.player,
      {Key? key, required this.songIdList, required this.currentSongID, required this.Nextsong, required this.prvsong,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        // Opens volume slider dialog
        IconButton(
          icon: RadiantGradientMask(child: Icon(Icons.volume_up, color: Colors.white,)),
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              value: player.volume,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),
        IconButton(
          icon: RadiantGradientMask(
              child: Icon(Icons.fast_rewind_rounded, color: Colors.white, size: 40)),
          onPressed: () {
            int currentSongIndex = songIdList.indexOf(currentSongID);
            prvsong();

            // showSliderDialog(
            //   context: context,
            //   title: "Adjust volume",
            //   divisions: 10,
            //   min: 0.0,
            //   max: 1.0,
            //   value: player.volume,
            //   stream: player.volumeStream,
            //   onChanged: player.setVolume,
            // );
          },
        ),

        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: CircularProgressIndicator(color: Color(0XFFD1549E),),
              );
            } else if (playing != true) {
              return IconButton(
                icon: RadiantGradientMask(
                    child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 50,)),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: RadiantGradientMask(child: Icon(Icons.pause, color: Colors.white, size: 50,)),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: RadiantGradientMask(
                    child: Icon(Icons.replay, color: Colors.white, size: 50,)),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        // Opens speed slider dialog
        SizedBox(
          width: 55.0,
          child: IconButton(
            icon: RadiantGradientMask(
                child: Icon(Icons.fast_forward_rounded, color: Colors.white, size: 40)),
            onPressed: () {
              Nextsong();
              // showSliderDialog(
              //   context: context,
              //   title: "Adjust volume",
              //   divisions: 10,
              //   min: 0.0,
              //   max: 1.0,
              //   value: player.volume,
              //   stream: player.volumeStream,
              //   onChanged: player.setVolume,
              // );
            },
          ),
        ),
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) =>
              IconButton(
                icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  showSliderDialog(
                    context: context,
                    title: "Adjust speed",
                    divisions: 10,
                    min: 0.5,
                    max: 1.5,
                    value: player.speed,
                    stream: player.speedStream,
                    onChanged: player.setSpeed,
                  );
                },
              ),
        ),
      ],
    );
  }
}