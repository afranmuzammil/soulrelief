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
    );
  }

  @override
  void write(BinaryWriter writer, LikedSong obj) {
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
    );
  }

  @override
  void write(BinaryWriter writer, RecentSong obj) {
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
