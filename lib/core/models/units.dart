import 'package:json_annotation/json_annotation.dart';

enum Unit implements Comparable<Unit>{
  @JsonValue("kg")
  kg("kg"),

  @JsonValue("liters")
  liters("liters"),

  @JsonValue("pieces")
  pieces("pieces"),

  @JsonValue("cups")
  cups("cups"),

  @JsonValue("teaspoons")
  teaspoons("teaspoons"),

  @JsonValue("tablespoons")
  tablespoons("tablespoons");

  @override
  int compareTo(Unit other) {
    throw UnimplementedError();
  }

  final String name;
  const Unit(this.name);
}
