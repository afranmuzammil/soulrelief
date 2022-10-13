import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import '../builders/gradienticon.dart';
import '../builders/gradienttext.dart';
import '../contollers/common.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

import 'package:rxdart/rxdart.dart';

class SongPage extends StatefulWidget {
  const SongPage({Key? key}) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  final _player = AudioPlayer();

  String songId="12ig9Z23DlI2frx0pb8DozUcqGrYsg7vQ";
  //_SongPageState(this.songId);
  // var duration = await player.setUrl('https://foo.com/bar.mp3');
  // var duration = await player.setFilePath('/path/to/file.mp3');
  // var duration = await player.setAsset('path/to/asset.mp3');

  @override
  void initState() {
    print("songid : $songId");
    super.initState();
    // WidgetsBinding.instance?.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

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
      await _player.setAudioSource(AudioSource.uri(Uri.parse(
          "https://drive.google.com/uc?export=view&id=$songId")));//1-HPfLLirpw2REb-quLmxq6MyEtQ3jZep
    } catch (e) {
      print("Error loading audio source: $e");
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
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
         // IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.black87,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.black87,))
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
        leading: IconButton(icon:Icon(Icons.keyboard_arrow_down_rounded,color: Colors.black,), onPressed: () {
          Navigator.of(context).pop();
        },),
        centerTitle: true,
      ),
      body: Container(
        height:height ,
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
                  shadowColor:Color(0xFFC3539A) ,
                  child: SizedBox(
                      height: height*0.6,
                      width: width*0.85,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GradientText(
                            "Muhammad jo dunya me",
                            style: TextStyle(
                                color: Color(0xFF5F7185),
                                fontSize: 18,
                                fontFamily: GoogleFonts.poppins().fontFamily,
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
                              shadowColor:Color(0xFFC3539A) ,
                              elevation: 20,
                              child: Container(
                                height: height*0.25,
                                width: width*0.45,
                                decoration:  BoxDecoration(

                                  borderRadius: BorderRadius.all(Radius.circular(14)),
                                  // color: pictureBG,
                                  image: DecorationImage(fit: BoxFit.fill, image: AssetImage("assets/Allama Iqbal.png")
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
                            IconButton( onPressed: () {  }, icon: Icon(Icons.favorite_border,color:Color(0XFF5F7185),) ,),
                            ControlButtons(_player),
                            IconButton( onPressed: () {  }, icon: Icon(Icons.playlist_add,color:Color(0XFF5F7185),) ,),

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
                  decoration:  BoxDecoration(
                    gradient:LinearGradient(
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
                      Container(),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child:  Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                          maxLines: 10,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: GoogleFonts.poppins().fontFamily,
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
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Opens volume slider dialog
        IconButton(
          icon: const Icon(Icons.volume_up),
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
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: RadiantGradientMask(child: Icon(Icons.play_arrow,color: Colors.white,size: 50,)),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        // Opens speed slider dialog
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
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