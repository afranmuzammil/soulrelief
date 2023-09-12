import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';

import 'package:soulrelief/pages/songpage.dart';
import 'package:text_scroll/text_scroll.dart';

import '../builders/gradienticon.dart';
import '../contollers/currentSongContoller.dart';
import '../models/initalizeHive.dart';
import '../models/songStorageModel.dart';

class RecentCards extends StatelessWidget {
  RecentCards({


    Key? key, required this.poetName, required this.albumName, required this.songName, required this.artistName, required this.audioImage, required this.audioFileSize, required this.audioLength, required this.composedBy, required this.domineName, required this.lyrics, required this.SongID,
  }) : super(key: key);
  final String poetName;
  final String albumName;
  final String songName;


  final String artistName;
  final String audioImage;
  final String audioFileSize;
  final String audioLength;
  final String composedBy;
  final String domineName;
  final String lyrics;
  final String SongID;
  CurrnetSongController currnetSongController = Get.put(CurrnetSongController());
  final CurrentSongHive = SingleSongHive.initSingleSongDataHive();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
      child: InkWell(
        onTap: () {
          log("hello i am from recent cards");
          final singleSong = SingleSong(SongID, poetName, albumName, artistName, audioLength, songName, composedBy, audioImage, audioFileSize, lyrics, domineName);
          CurrentSongHive.put("currentSong", singleSong);
          currnetSongController.updateCurrentSong(SongID, poetName, albumName, artistName, audioLength, songName, composedBy, audioImage, audioFileSize, lyrics, domineName);
        },
        child: Container(
          height: height * 0.15,
          width: width * 0.5,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    /*BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                    )*/
                  ],
                  /*border: Border.all(
                      color: Colors.white.withOpacity(0.2), width: 0.0),*/

                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.2)
                    ],
                    stops: [0.0, 1.0],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  // color: pictureBG,
                  image:
                      DecorationImage(fit: BoxFit.fill, image: AssetImage(audioImage.toString())
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
              Container(
                padding: const EdgeInsets.fromLTRB(0, 3, 3, 0),
                alignment: Alignment.topRight,
                child: Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      border: Border.all(color: Colors.transparent),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    // child: IconButton(
                    //   padding: EdgeInsets.zero,
                    //   icon: Icon(Icons.favorite_outline, color: Colors.white),
                    //   onPressed: () {
                    //     log("i am heart iocn");
                    //   },
                    // )
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 3, 3, 16),
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   colors: [Color(0xffdf99da), Colors.transparent, Color(0xffdf99da)],
                  //   begin: Alignment.bottomLeft,
                  //   end: Alignment.topRight,
                  // ),
                  //  color: Color(0xff),
                  border: Border.all(color: Colors.transparent),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(14),
                  ),
                ),
                child: Container(
                  height: height * 0.07,
                  width: width * 0.34,
                  alignment: Alignment.bottomLeft,
                  // decoration: BoxDecoration(
                  //   gradient:LinearGradient(
                  //     colors: [Color(0xffdf99da), Colors.transparent ],
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomRight,
                  //   ),
                  //   // color: Colors.white,
                  //   border: Border.all(color: Colors.transparent),
                  //   // borderRadius: const BorderRadius.all(
                  //   //   Radius.circular(20),
                  //   // ),
                  // ),
                  child: TextScroll(songName.toString(),
                      textAlign: TextAlign.start,
                      velocity:  Velocity(pixelsPerSecond: Offset(12, 0)),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w400)),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 3, 3, 0),
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   colors: [Color(0xffdf99da), Colors.transparent, Color(0xffdf99da)],
                  //   begin: Alignment.bottomLeft,
                  //   end: Alignment.topRight,
                  // ),
                  //  color: Color(0xff),
                  border: Border.all(color: Colors.transparent),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(14),
                  ),
                ),
                child: Container(
                  height: height * 0.07,
                  width: width * 0.2,
                  alignment: Alignment.centerRight,
                  // decoration: BoxDecoration(
                  //   gradient:LinearGradient(
                  //     colors: [Color(0xffdf99da), Colors.transparent ],
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomRight,
                  //   ),
                  //   // color: Colors.white,
                  //   border: Border.all(color: Colors.transparent),
                  //   // borderRadius: const BorderRadius.all(
                  //   //   Radius.circular(20),
                  //   // ),
                  // ),
                  child: IconButton(
                    icon: RadiantGradientMask(
                        child: Icon(
                          SongID  == currnetSongController.currentSongID? Icons.pause_circle_filled_outlined:Icons.play_circle_filled_rounded,
                          color: Colors.white, size: 36,)),
                    iconSize: 44.0,
                    onPressed: (){},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
