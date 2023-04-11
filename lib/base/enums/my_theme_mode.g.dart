// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_theme_mode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyThemeModeAdapter extends TypeAdapter<MyThemeMode> {
  @override
  final int typeId = 1;

  @override
  MyThemeMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MyThemeMode.system;
      case 1:
        return MyThemeMode.light;
      case 2:
        return MyThemeMode.dark;
      default:
        return MyThemeMode.system;
    }
  }

  @override
  void write(BinaryWriter writer, MyThemeMode obj) {
    switch (obj) {
      case MyThemeMode.system:
        writer.writeByte(0);
        break;
      case MyThemeMode.light:
        writer.writeByte(1);
        break;
      case MyThemeMode.dark:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyThemeModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
