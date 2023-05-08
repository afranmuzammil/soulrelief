import 'package:hive/hive.dart';

part 'StorageModel.g.dart';

///single Liked Song
@HiveType(typeId: 0)
class LikedSong extends HiveObject{
  @HiveField(0)
  String songName;

  @HiveField(1)
  String songID;

  @HiveField(2)
  String artistName;

  @HiveField(3)
  String audioLength;

  @HiveField(4)
  String songImage;

  @HiveField(5)
  String poetName;

  @HiveField(6)
  String albumName;

  @HiveField(7)
  String composedBy;

  @HiveField(8)
  String audioFileSize;

  @HiveField(9)
  String lyrics;

  @HiveField(10)
  String domineName;



  LikedSong(
      this.songName,
      this.songID,
      this.artistName,
      this.audioLength,
      this.songImage,
      this.domineName,
      this.lyrics,
      this.audioFileSize,
      this.composedBy,
      this.albumName,
      this.poetName
      );

}
///List of liked songs
@HiveType(typeId: 1)
class LikedList extends HiveObject{


  @HiveField(0)
  List<String> songID;

  LikedList(this.songID,);

}

///PlayList Names
@HiveType(typeId: 2)
class PlayLists extends HiveObject{


  @HiveField(0)
  List<String> playListName;

  PlayLists(this.playListName,);

}



///PlayList songsList
@HiveType(typeId: 3)
class PlayListSongIdsList extends HiveObject{


  @HiveField(0)
  List<String> songID;

  PlayListSongIdsList(this.songID,);

}

///single songs for PlayListsList
@HiveType(typeId: 4)
class PlayListSingleSong extends HiveObject{
  @HiveField(0)
  String songName;

  @HiveField(1)
  String songID;

  @HiveField(2)
  String artistName;

  @HiveField(3)
  String audioLength;

  @HiveField(4)
  String songImage;



  PlayListSingleSong(
      this.songName,
      this.songID,
      this.artistName,
      this.audioLength,
      this.songImage
      );


}



///single Recent Song
@HiveType(typeId: 5)
class RecentSong extends HiveObject{
  @HiveField(0)
  String songName;

  @HiveField(1)
  String songID;

  @HiveField(2)
  String artistName;

  @HiveField(3)
  String audioLength;

  @HiveField(4)
  String songImage;


  @HiveField(5)
  String poetName;

  @HiveField(6)
  String albumName;

  @HiveField(7)
  String composedBy;

  @HiveField(8)
  String audioFileSize;

  @HiveField(9)
  String lyrics;

  @HiveField(10)
  String domineName;


  RecentSong(
      this.songName,
      this.songID,
      this.artistName,
      this.audioLength,
      this.songImage,
      this.domineName,
      this.lyrics,
      this.audioFileSize,
      this.composedBy,
      this.albumName,
      this.poetName
      );

}
///List of Recent songs
@HiveType(typeId: 6)
class RecentSongList extends HiveObject{


  @HiveField(0)
  List<String> songID;

  RecentSongList(this.songID,);

}

///single Downloaded Song
@HiveType(typeId: 9)
class DownloadedSong extends HiveObject{
  @HiveField(0)
  String songName;

  @HiveField(1)
  String songID;

  @HiveField(2)
  String artistName;

  @HiveField(3)
  String audioLength;

  @HiveField(4)
  String songImage;


  @HiveField(5)
  String poetName;

  @HiveField(6)
  String albumName;

  @HiveField(7)
  String composedBy;

  @HiveField(8)
  String audioFileSize;

  @HiveField(9)
  String lyrics;

  @HiveField(10)
  String domineName;


  @HiveField(11)
  String filePath;


  DownloadedSong(
      this.songName,
      this.songID,
      this.artistName,
      this.audioLength,
      this.songImage,
      this.domineName,
      this.lyrics,
      this.audioFileSize,
      this.composedBy,
      this.albumName,
      this.poetName,
      this.filePath
      );

}
///List of Downloaded songs
@HiveType(typeId: 10)
class DownloadedSongList extends HiveObject{


  @HiveField(0)
  List<String> songID;

  DownloadedSongList(this.songID,);

}

///Current Playlist
@HiveType(typeId: 11)
class CurrentPlayList extends HiveObject{


  @HiveField(0)
  List<String> songID;

  CurrentPlayList(this.songID,);

}

