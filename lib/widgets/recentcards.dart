import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';

import 'package:soulrelief/pages/songpage.dart';

class RecentCards extends StatelessWidget {
  RecentCards({
    required this.songName,
    required this.coverImageUrl,
    Key? key,
  }) : super(key: key);

  final String songName;
  final String coverImageUrl;

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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SongPage()),
          );
        },
        child: Container(
          height: height * 0.15,
          width: width * 0.5,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffdf99da), Color(0xff668fd7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  // color: pictureBG,
                  image:
                      DecorationImage(fit: BoxFit.fill, image: AssetImage(coverImageUrl.toString())
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
                padding: const EdgeInsets.fromLTRB(0, 3, 3, 0),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffdf99da), Colors.transparent, Color(0xffdf99da)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  // color: Colors.white,
                  border: Border.all(color: Colors.transparent),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(14),
                  ),
                ),
                child: Container(
                  height: height * 0.06,
                  width: width * 0.5,
                  alignment: Alignment.center,
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
                  child: Text(songName.toString(),
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
