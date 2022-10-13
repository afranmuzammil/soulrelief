import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulrelief/pages/songpage.dart';

class PoetPages extends StatefulWidget {
  const PoetPages({Key? key, required this.poetName}) : super(key: key);
  final String poetName;

  @override
  State<PoetPages> createState() => _PoetPagesState();
}

class _PoetPagesState extends State<PoetPages> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      appBar:  AppBar(
        title: Text("${widget.poetName}",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(icon:Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,), onPressed: () {
          Navigator.of(context).pop();
        },),
        elevation: 0,
        centerTitle: true,
      ),
      // backgroundColor: Colors.red,
      body: SafeArea(child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: db.collection('AllTaranas').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(
                  physics :NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: snapshot.data!.docs
                      .map((doc) => ListTile(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SongPage()),
                      );
                    },
                    leading: Container(
                      height: height*0.06,
                      width: width*0.12,
                      decoration:  BoxDecoration(

                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        // color: pictureBG,
                        image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/hqdefault.png')
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
                    title: Text(doc["songName"].toString()),
                    subtitle: Text("${doc["singerName"].toString()} . ${doc["audioLength"].toString()}"),
                    trailing: IconButton(onPressed: (){},icon: Icon(Icons.more_vert),),
                  )
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

          // Container(),
        ],
      )),
    );
  }
}

