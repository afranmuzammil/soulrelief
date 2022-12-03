import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../builders/gradienttext.dart';
import '../../models/initalizeHive.dart';
import '../songpage.dart';

class LikedSongsPage extends StatefulWidget {
  const LikedSongsPage({Key? key}) : super(key: key);

  @override
  State<LikedSongsPage> createState() => _LikedSongsPageState();
}

class _LikedSongsPageState extends State<LikedSongsPage> {
  final likedListHive = LikedListHive.initLikedListDataHive();
  final likedSongsHive = LikedSongsHive.initLikedSongsDataHive();
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
            IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.black87,)),
            IconButton(onPressed: (){}, icon: Icon(Icons.settings,color: Colors.black87,))
          ],
          title: GradientText(
            "Liked Songs",
            style: TextStyle(
                color: Color(0xFF5F7185),
                fontSize: 20,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.bold),
            gradient: LinearGradient(colors: [
              Color(0xffdf99da), Color(0xff668fd7)
            ]),
          ),
          leading: IconButton(icon:Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,), onPressed: () {
            Navigator.of(context).pop();
          },),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              likedListHive.get("likedSongs")!.songID.isNotEmpty?
              ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: likedListHive.get("likedSongs")!.songID.length ,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  SongPage(songID: likedSongsHive.get("${likedListHive.get("likedSongs")!.songID[index]}")!.songID,)),
                      );
                    },
                    leading: Container(
                      height: height*0.06,
                      width: width*0.12,
                      decoration:  BoxDecoration(

                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        // color: pictureBG,
                        image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/Tarana- Voice of Islam.png')
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
                    title: Text(likedSongsHive.get("${likedListHive.get("likedSongs")!.songID[index]}")!.songName),
                    subtitle: Text("${likedSongsHive.get("${likedListHive.get("likedSongs")!.songID[index]}")!.artistName} • ${likedSongsHive.get("${likedListHive.get("likedSongs")!.songID[index]}")!.audioLength}"),
                    trailing: IconButton(onPressed: (){},icon: Icon(Icons.more_vert),),
                  );
              },
              ):
                  Center(child:Text("Your liked songs will be shown here",style: TextStyle(color: Colors.grey),))

            ],
          ),
        ));
  }
}
