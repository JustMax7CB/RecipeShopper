import 'package:hive/hive.dart';

part 'units.g.dart';

@HiveType(typeId: 3)
enum UnitEnum implements Comparable<UnitEnum>{
  @HiveField(0)
  kg("kg"),
  @HiveField(1)
  liters("liters"),
  @HiveField(2)
  pieces("pieces"),
  @HiveField(3)
  cups("cups"),
  @HiveField(4)
  teaspoons("teaspoons"),
  @HiveField(5)
  tablespoons("tablespoons");

  @override
  int compareTo(UnitEnum other) {
    throw UnimplementedError();
  }

  final String name;
  const UnitEnum(this.name);
}


