import 'package:hive/hive.dart';

part 'my_theme_mode.g.dart';

@HiveType(typeId: 1)
enum MyThemeMode {
  @HiveField(0)
  system,
  @HiveField(1)
  light,
  @HiveField(2)
  dark,
}
