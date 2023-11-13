// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todoClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class todosAdapter extends TypeAdapter<todos> {
  @override
  final int typeId = 1;

  @override
  todos read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return todos(
      fields[0] as String,
      fields[1] == null ? false : fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, todos obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is todosAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
