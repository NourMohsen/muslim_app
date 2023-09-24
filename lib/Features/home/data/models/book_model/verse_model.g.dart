// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VerseModelAdapter extends TypeAdapter<VerseModel> {
  @override
  final int typeId = 0;

  @override
  VerseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VerseModel(
      surahNumber: fields[0] as int,
      verseContent: fields[2] as String?,
      verseNumber: fields[1] as int,
      verseEnglish: fields[3] as String?,
      verseAudioUrl: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VerseModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.surahNumber)
      ..writeByte(1)
      ..write(obj.verseNumber)
      ..writeByte(2)
      ..write(obj.verseContent)
      ..writeByte(3)
      ..write(obj.verseEnglish)
      ..writeByte(4)
      ..write(obj.verseAudioUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VerseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
