import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../builders/gradienttext.dart';

class AllDominePages extends StatefulWidget {
  const AllDominePages({Key? key}) : super(key: key);

  @override
  State<AllDominePages> createState() => _AllDominePagesState();
}

class _AllDominePagesState extends State<AllDominePages> {
  final db = FirebaseFirestore.instance;
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
            "Explore Domines",
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
        body: Column(
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
                      title: Text("Artists Name"),
                      subtitle: Text("19 songs"),
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

          ],
        ));
  }
}
