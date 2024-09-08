// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medecine_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedecineHiveAdapter extends TypeAdapter<MedecineHive> {
  @override
  final int typeId = 2;

  @override
  MedecineHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedecineHive(
      id: fields[0] as String,
      name: fields[2] as String,
      group: fields[4] as String,
      dci: fields[5] as String,
      regime: fields[6] as String,
      category: fields[3] as String,
      price: fields[7] as int,
      img: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MedecineHive obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.img)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.group)
      ..writeByte(5)
      ..write(obj.dci)
      ..writeByte(6)
      ..write(obj.regime)
      ..writeByte(7)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedecineHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
