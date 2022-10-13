import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../builders/gradienttext.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({Key? key}) : super(key: key);

  @override
  State<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {

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
          "Downloads",
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
            Container(
              child: Text("downloads"),
            ),
          ],
        ));
  }
}
