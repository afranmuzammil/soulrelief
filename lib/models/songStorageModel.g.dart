// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songStorageModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongsListAdapter extends TypeAdapter<SongsList> {
  @override
  final int typeId = 7;

  @override
  SongsList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongsList(
      (fields[0] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, SongsList obj) {
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
      other is SongsListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SingleSongAdapter extends TypeAdapter<SingleSong> {
  @override
  final int typeId = 8;

  @override
  SingleSong read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SingleSong(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      fields[7] as String,
      fields[8] as String,
      fields[9] as String,
      fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SingleSong obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.songId)
      ..writeByte(1)
      ..write(obj.poetName)
      ..writeByte(2)
      ..write(obj.albumName)
      ..writeByte(3)
      ..write(obj.singerName)
      ..writeByte(4)
      ..write(obj.audioLength)
      ..writeByte(5)
      ..write(obj.songName)
      ..writeByte(6)
      ..write(obj.composedBy)
      ..writeByte(7)
      ..write(obj.audioImage)
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
      other is SingleSongAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
