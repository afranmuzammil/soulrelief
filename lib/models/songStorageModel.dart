import 'package:hive/hive.dart';

part 'songStorageModel.g.dart';

///List of songs from firebase
@HiveType(typeId: 7)
class SongsList extends HiveObject {
  @HiveField(0)
  List<String> songID;

  SongsList(
    this.songID,
  );
}

@HiveType(typeId: 8)
class SingleSong extends HiveObject {


  @HiveField(0)
  String songId;
  @HiveField(1)
  String poetName;
  @HiveField(2)
  String albumName;
  @HiveField(3)
  String singerName;
  @HiveField(4)
  String audioLength;
  @HiveField(5)
  String songName;
  @HiveField(6)
  String composedBy;
  @HiveField(7)
  String audioImage;
  @HiveField(8)
  String audioFileSize;
  @HiveField(9)
  String lyrics;
  @HiveField(10)
  String domineName;


  SingleSong(
      this.songId,
      this.poetName,
      this.albumName,
      this.singerName,
      this.audioLength,
      this.songName,
      this.composedBy,
      this.audioImage,
      this.audioFileSize,
      this.lyrics,
      this.domineName
      );
}
