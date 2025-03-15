// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'units.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UnitEnumAdapter extends TypeAdapter<UnitEnum> {
  @override
  final int typeId = 3;

  @override
  UnitEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UnitEnum.kg;
      case 1:
        return UnitEnum.liters;
      case 2:
        return UnitEnum.pieces;
      case 3:
        return UnitEnum.cups;
      case 4:
        return UnitEnum.teaspoons;
      case 5:
        return UnitEnum.tablespoons;
      default:
        return UnitEnum.kg;
    }
  }

  @override
  void write(BinaryWriter writer, UnitEnum obj) {
    switch (obj) {
      case UnitEnum.kg:
        writer.writeByte(0);
        break;
      case UnitEnum.liters:
        writer.writeByte(1);
        break;
      case UnitEnum.pieces:
        writer.writeByte(2);
        break;
      case UnitEnum.cups:
        writer.writeByte(3);
        break;
      case UnitEnum.teaspoons:
        writer.writeByte(4);
        break;
      case UnitEnum.tablespoons:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnitEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
