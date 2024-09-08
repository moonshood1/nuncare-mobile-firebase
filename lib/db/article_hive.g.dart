// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticleHiveAdapter extends TypeAdapter<ArticleHive> {
  @override
  final int typeId = 0;

  @override
  ArticleHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArticleHive(
      id: fields[0] as String?,
      authorId: fields[1] as String?,
      img: fields[2] as String,
      title: fields[3] as String,
      description: fields[4] as String,
      content: fields[5] as String,
      authorName: fields[6] as String,
      createdAt: fields[7] as String,
      likes: (fields[8] as List?)?.cast<dynamic>(),
      isDraft: fields[9] as bool,
      isPublished: fields[10] as bool,
      isActive: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ArticleHive obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.authorId)
      ..writeByte(2)
      ..write(obj.img)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.content)
      ..writeByte(6)
      ..write(obj.authorName)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.likes)
      ..writeByte(9)
      ..write(obj.isDraft)
      ..writeByte(10)
      ..write(obj.isPublished)
      ..writeByte(11)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
