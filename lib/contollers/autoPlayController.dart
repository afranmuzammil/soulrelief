import 'dart:developer';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/StorageModel.dart';
import '../models/initalizeHive.dart';
import '../models/songStorageModel.dart';
import 'currentSongContoller.dart';

class AutoPlayController extends GetxController with StateMixin<dynamic>{
  final likedListHive = LikedListHive.initLikedListDataHive();
  final likedSongsHive = LikedSongsHive.initLikedSongsDataHive();
  final recentSongsHive = RecentSongHive.initRecentSongDataHive();
  final recentSongListHive = RecentSongListHive.initRecentSongListDataHive();
  final DownloadedSongsHive = DownloadedSongHive.initDownloadedSongDataHive();
  final DownloadedSongsListHive = DownloadedSongListHive.initDownloadedSongListDataHive();
  final CurrentSongHive = SingleSongHive.initSingleSongDataHive();
  final currentPlayListHive = CurrentPlayListHive.initCurrentPlayListDataHive();
 CurrnetSongController currnetSongController = Get.put(CurrnetSongController());
  @override
  Future<void> onInit() async {
    super.onInit();


  }


  void ChangePlayList(playlistName, nextSongIndex){
    log("in auto play");

    switch(playlistName){
      case "downloadSongs":{
        final singleSong = SingleSong(
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songID,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.poetName,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.albumName,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.artistName,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.audioLength,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songName,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.composedBy,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songImage,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.audioFileSize,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.lyrics,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.domineName
        );
        CurrentSongHive.put("currentSong", singleSong);
        currnetSongController.updateCurrentSong(
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songID,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.poetName,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.albumName,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.artistName,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.audioLength,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songName,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.composedBy,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songImage,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.audioFileSize,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.lyrics,
            DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.domineName
        );
      }
      break;
      case "likedSongs":{

        final singleSong = SingleSong(
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songID,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.poetName,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.albumName,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.artistName,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.audioLength,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songName,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.composedBy,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songImage,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.audioFileSize,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.lyrics,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.domineName
        );
        CurrentSongHive.put("currentSong", singleSong);
        currnetSongController.updateCurrentSong(
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songID,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.poetName,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.albumName,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.artistName,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.audioLength,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songName,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.composedBy,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songImage,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.audioFileSize,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.lyrics,
            likedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.domineName
        );

      }
      break;
      case "recentSongs":{
        final singleSong = SingleSong(
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songID,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.poetName,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.albumName,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.artistName,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.audioLength,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songName,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.composedBy,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songImage,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.audioFileSize,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.lyrics,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.domineName
        );
        CurrentSongHive.put("currentSong", singleSong);
        currnetSongController.updateCurrentSong(
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songID,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.poetName,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.albumName,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.artistName,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.audioLength,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songName,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.composedBy,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songImage,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.audioFileSize,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.lyrics,
            recentSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.domineName
        );
        

      }break;
      case "allSongs":{
        log("from all songs auto play ");
        String jsonString = currentPlayListHive.get("currentPlayList")!.songID[nextSongIndex].toString();
        jsonString = jsonString.replaceAll(':', '":"').replaceAll(', ', '","').replaceAll('@', ':');
        jsonString =  jsonString.replaceAll('{', '{"') ;
        jsonString =  jsonString.replaceAll('}', '"}') ;
        jsonString = jsonString.replaceAll(', ', '","').replaceAll(' null', 'null');
        jsonString = jsonString.replaceAllMapped(
          RegExp(r'\s\d+":"\d+'),
              (match) => match.group(0)!.replaceAll('":"', ':'),
        );
        jsonString = jsonString.replaceAll(RegExp('[\\x00-\\x1F\\x7F-\x9F]'), '');
     //   log(jsonString);
        Map<dynamic, dynamic> map = json.decode(jsonString);

        log(map["song_id"]);

        final singleSong = SingleSong(
            map["song_id"].toString().removeAllWhitespace,
            map["poet_name"],
            map["album_name"],
            map["singer_name"],
            map["audio_length"],
            map["song_name"],
            map["composed_by"],
            map["audio_image"],
            map["audio_file_size"],
            map["lyrics"],
            map["domine_name"]
        );
        CurrentSongHive.put("currentSong", singleSong);
        currnetSongController.updateCurrentSong(
            map["song_id"].toString().removeAllWhitespace,
            map["poet_name"],
            map["album_name"],
            map["singer_name"],
            map["audio_length"],
            map["song_name"],
            map["composed_by"],
            map["audio_image"],
            map["audio_file_size"],
            map["lyrics"],
            map["domine_name"]
        );
      }break;
      case "custom":{

      }break;
    }

  }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

}

class AutoPlayControllerBindings extends Bindings {
  @override
  void dependencies() {
    // log("hello");
    Get.lazyPut<AutoPlayController>(() => AutoPlayController());
  }
}