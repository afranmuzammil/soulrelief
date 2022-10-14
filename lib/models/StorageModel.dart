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

  LikedSong(
      this.songName,
      this.songID,
      this.artistName,
      this.audioLength
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

  PlayListSingleSong(
      this.songName,
      this.songID,
      this.artistName,
      this.audioLength
      );


}


