import 'package:hive/hive.dart';

part 'units.g.dart';

@HiveType(typeId: 2)
enum UnitEnum implements Comparable<UnitEnum>{
  @HiveField(0)
  kg("kg"),
  @HiveField(2)
  grams("grams"),
  @HiveField(3)
  liters("liters"),
  @HiveField(4)
  pieces("pieces"),
  @HiveField(5)
  cups("cups"),
  @HiveField(6)
  teaspoons("teaspoons"),
  @HiveField(7)
  tablespoons("tablespoons");

  @override
  int compareTo(UnitEnum other) {
    throw UnimplementedError();
  }

  final String name;
  const UnitEnum(this.name);
}


