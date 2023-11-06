// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeEntityAdapter extends TypeAdapter<EmployeeEntity> {
  @override
  final int typeId = 201;

  @override
  EmployeeEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeEntity(
      id: fields[0] as int,
      name: fields[1] as String,
      role: fields[2] as String,
      joinDate: fields[3] as int,
      leaveDate: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.role)
      ..writeByte(3)
      ..write(obj.joinDate)
      ..writeByte(4)
      ..write(obj.leaveDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
