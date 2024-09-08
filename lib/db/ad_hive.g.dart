// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdAdapter extends TypeAdapter<Ad> {
  @override
  final int typeId = 1;

  @override
  Ad read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ad(
      id: fields[0] as String?,
      label: fields[1] as String,
      img: fields[2] as String,
      company: fields[3] as String,
      description: fields[4] as String,
      websiteLink: fields[5] as String,
      isActive: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Ad obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.img)
      ..writeByte(3)
      ..write(obj.company)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.websiteLink)
      ..writeByte(6)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
