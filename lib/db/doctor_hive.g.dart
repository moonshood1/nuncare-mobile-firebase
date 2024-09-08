// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoctorHiveAdapter extends TypeAdapter<DoctorHive> {
  @override
  final int typeId = 3;

  @override
  DoctorHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorHive(
      id: fields[0] as String?,
      firebaseId: fields[1] as String,
      firstName: fields[2] as String,
      lastName: fields[3] as String,
      bio: fields[4] as String,
      sex: fields[5] as String,
      hospital: fields[6] as String,
      speciality: fields[7] as String,
      otherSpeciality: fields[8] as String?,
      university: fields[9] as String,
      countryUniversity: fields[10] as String,
      years: fields[11] as int,
      img: fields[12] as String,
      phone: fields[13] as String,
      district: fields[14] as String,
      region: fields[15] as String,
      city: fields[16] as String,
      address: fields[17] as String,
      lat: fields[18] as double,
      lng: fields[19] as double,
      email: fields[20] as String,
      orderNumber: fields[21] as String,
      promotion: fields[22] as String,
      isActive: fields[24] as bool,
      deviceId: fields[23] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DoctorHive obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firebaseId)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.bio)
      ..writeByte(5)
      ..write(obj.sex)
      ..writeByte(6)
      ..write(obj.hospital)
      ..writeByte(7)
      ..write(obj.speciality)
      ..writeByte(8)
      ..write(obj.otherSpeciality)
      ..writeByte(9)
      ..write(obj.university)
      ..writeByte(10)
      ..write(obj.countryUniversity)
      ..writeByte(11)
      ..write(obj.years)
      ..writeByte(12)
      ..write(obj.img)
      ..writeByte(13)
      ..write(obj.phone)
      ..writeByte(14)
      ..write(obj.district)
      ..writeByte(15)
      ..write(obj.region)
      ..writeByte(16)
      ..write(obj.city)
      ..writeByte(17)
      ..write(obj.address)
      ..writeByte(18)
      ..write(obj.lat)
      ..writeByte(19)
      ..write(obj.lng)
      ..writeByte(20)
      ..write(obj.email)
      ..writeByte(21)
      ..write(obj.orderNumber)
      ..writeByte(22)
      ..write(obj.promotion)
      ..writeByte(23)
      ..write(obj.deviceId)
      ..writeByte(24)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
