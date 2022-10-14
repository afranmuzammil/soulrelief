import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:soulrelief/models/StorageModel.dart';
import 'package:soulrelief/pages/home.dart';
import 'package:soulrelief/widgets/navigationbar.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Hive.registerAdapter(LikedSongAdapter());
  Hive.registerAdapter(LikedListAdapter());
  Hive.registerAdapter(PlayListsAdapter());
  Hive.registerAdapter(PlayListSongIdsListAdapter());
  Hive.registerAdapter(PlayListSingleSongAdapter());

  await Hive.openBox<LikedSong>("LikedSong");
  await Hive.openBox<LikedList>("LikedList");
  await Hive.openBox<PlayLists>("PlayLists");
  await Hive.openBox<PlayListSongIdsList>("PlayListSongIdsList");
  await Hive.openBox<PlayListSingleSong>("PlayListSingleSong");

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
        (value) => runApp(
      const MyApp(),
    ),
  );
 // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const NavBar(),
    );
  }
}

