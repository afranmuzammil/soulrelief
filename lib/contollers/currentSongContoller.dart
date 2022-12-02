

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../pages/flotingAudio.dart';

class CurrnetSongController extends GetxController with StateMixin<dynamic>{

 String currentSongID = "1-9FK-1CjeA3JJaHyIeyyDTQ0k7pbGWMf";
 String currentsongName = "Khudi ka sirr e Nihan La ilaaha ilallah (Bangalore version)";
 String currentpoetName = "";
 String currentalbumName= "";
 String currentartistName= "";
 String currentaudioImage= "";
 String currentaudioFileSize= "";
 String currentaudioLength= "";
 String currentcomposedBy= "";
 String currentdomineName= "";
 String currentlyrics= "";


 @override
 Future<void> onInit() async {
   super.onInit();

   setSong();
 }

 setSong(){
   currentSongID = "1-9FK-1CjeA3JJaHyIeyyDTQ0k7pbGWMf";
   update();
   change(value, status: RxStatus.success());
 }

 updateCurrentSong(newSongID, poetName, albumName, artistName, audioLength, songName, composedBy, audioImage, audioFileSize, lyrics, domineName){
   log(currentSongID);
   currentSongID = newSongID;
   currentpoetName =poetName;
   currentalbumName =albumName;
   currentsongName =songName;
   currentartistName =artistName;
   currentaudioImage =audioImage;
   currentaudioFileSize =audioFileSize;
   currentaudioLength =audioLength;
   currentcomposedBy =composedBy;
   currentdomineName =domineName;
   currentlyrics =lyrics;

   update();
   log(currentSongID);
   //var contx =  MiniPlayer(onTap: (){},).createState().context;
   //MiniPlayer(onTap: (){},).createState().build(contx);
   change(value, status: RxStatus.success());

 }


 getSong(songId) async {
   /*await FirebaseFirestore.instance
       .collection("AllSongsList").doc(songId).get()
       .then((value) {
     change(value, status: RxStatus.success());
   },onError: (error){
         log("error while getting song data $error");
     change(null, status: RxStatus.error(error.toString()));
   }
   );*/
 }



 AddSongsToHive()async{
   log("in add hive");
   var f = await FirebaseFirestore.instance
       .collection("AllSongsList");
   log("from add songs to hive: ${f}");

 }


 @override
 void onClose() {
   // TODO: implement onClose
   super.onClose();
 }

}

class CurrnetSongControllerBindings extends Bindings {
  @override
  void dependencies() {
    // log("hello");
    Get.lazyPut<CurrnetSongController>(() => CurrnetSongController());
  }
}