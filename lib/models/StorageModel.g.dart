// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StorageModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LikedSongAdapter extends TypeAdapter<LikedSong> {
  @override
  final int typeId = 0;

  @override
  LikedSong read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LikedSong(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[10] as String,
      fields[9] as String,
      fields[8] as String,
      fields[7] as String,
      fields[6] as String,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LikedSong obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.songName)
      ..writeByte(1)
      ..write(obj.songID)
      ..writeByte(2)
      ..write(obj.artistName)
      ..writeByte(3)
      ..write(obj.audioLength)
      ..writeByte(4)
      ..write(obj.songImage)
      ..writeByte(5)
      ..write(obj.poetName)
      ..writeByte(6)
      ..write(obj.albumName)
      ..writeByte(7)
      ..write(obj.composedBy)
      ..writeByte(8)
      ..write(obj.audioFileSize)
      ..writeByte(9)
      ..write(obj.lyrics)
      ..writeByte(10)
      ..write(obj.domineName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LikedSongAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LikedListAdapter extends TypeAdapter<LikedList> {
  @override
  final int typeId = 1;

  @override
  LikedList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LikedList(
      (fields[0] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, LikedList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.songID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LikedListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlayListsAdapter extends TypeAdapter<PlayLists> {
  @override
  final int typeId = 2;

  @override
  PlayLists read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayLists(
      (fields[0] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlayLists obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.playListName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlayListSongIdsListAdapter extends TypeAdapter<PlayListSongIdsList> {
  @override
  final int typeId = 3;

  @override
  PlayListSongIdsList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayListSongIdsList(
      (fields[0] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlayListSongIdsList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.songID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListSongIdsListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlayListSingleSongAdapter extends TypeAdapter<PlayListSingleSong> {
  @override
  final int typeId = 4;

  @override
  PlayListSingleSong read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayListSingleSong(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlayListSingleSong obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.songName)
      ..writeByte(1)
      ..write(obj.songID)
      ..writeByte(2)
      ..write(obj.artistName)
      ..writeByte(3)
      ..write(obj.audioLength)
      ..writeByte(4)
      ..write(obj.songImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListSingleSongAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecentSongAdapter extends TypeAdapter<RecentSong> {
  @override
  final int typeId = 5;

  @override
  RecentSong read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentSong(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[10] as String,
      fields[9] as String,
      fields[8] as String,
      fields[7] as String,
      fields[6] as String,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RecentSong obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.songName)
      ..writeByte(1)
      ..write(obj.songID)
      ..writeByte(2)
      ..write(obj.artistName)
      ..writeByte(3)
      ..write(obj.audioLength)
      ..writeByte(4)
      ..write(obj.songImage)
      ..writeByte(5)
      ..write(obj.poetName)
      ..writeByte(6)
      ..write(obj.albumName)
      ..writeByte(7)
      ..write(obj.composedBy)
      ..writeByte(8)
      ..write(obj.audioFileSize)
      ..writeByte(9)
      ..write(obj.lyrics)
      ..writeByte(10)
      ..write(obj.domineName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentSongAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecentSongListAdapter extends TypeAdapter<RecentSongList> {
  @override
  final int typeId = 6;

  @override
  RecentSongList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentSongList(
      (fields[0] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecentSongList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.songID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentSongListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DownloadedSongAdapter extends TypeAdapter<DownloadedSong> {
  @override
  final int typeId = 9;

  @override
  DownloadedSong read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadedSong(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[10] as String,
      fields[9] as String,
      fields[8] as String,
      fields[7] as String,
      fields[6] as String,
      fields[5] as String,
      fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DownloadedSong obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.songName)
      ..writeByte(1)
      ..write(obj.songID)
      ..writeByte(2)
      ..write(obj.artistName)
      ..writeByte(3)
      ..write(obj.audioLength)
      ..writeByte(4)
      ..write(obj.songImage)
      ..writeByte(5)
      ..write(obj.poetName)
      ..writeByte(6)
      ..write(obj.albumName)
      ..writeByte(7)
      ..write(obj.composedBy)
      ..writeByte(8)
      ..write(obj.audioFileSize)
      ..writeByte(9)
      ..write(obj.lyrics)
      ..writeByte(10)
      ..write(obj.domineName)
      ..writeByte(11)
      ..write(obj.filePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadedSongAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DownloadedSongListAdapter extends TypeAdapter<DownloadedSongList> {
  @override
  final int typeId = 10;

  @override
  DownloadedSongList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadedSongList(
      (fields[0] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, DownloadedSongList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.songID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadedSongListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CurrentPlayListAdapter extends TypeAdapter<CurrentPlayList> {
  @override
  final int typeId = 11;

  @override
  CurrentPlayList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentPlayList(
      (fields[0] as List).cast<String>(),
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentPlayList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.songID)
      ..writeByte(1)
      ..write(obj.CurrentPlaylistName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentPlayListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
