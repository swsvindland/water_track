import 'package:vnum/vnum.dart';

class Preferences {
  Unit unit;
  int waterGoal;
  int totalGoal;
  int drinkSize;

  Preferences({this.unit, this.waterGoal, this.totalGoal, this.drinkSize});

  void setWaterGoal(int value) {
    waterGoal = value;
  }

  void setTotalGoal(int value) {
    totalGoal = value;
  }

  void setDrinkSize(int value) {
    drinkSize = value;
  }

  static Preferences empty() {
    return Preferences(
        unit: Unit.imperial, waterGoal: 96, totalGoal: 128, drinkSize: 8);
  }

  factory Preferences.fromMap(Map data) {
    data = data ?? {};
    return Preferences(
        unit: Unit.define(data['unit']) ?? Unit.imperial,
        waterGoal: data['waterGoal'] ?? (data['unit'] == Unit.imperial ? 96 : 3000),
        totalGoal: data['totalGoal'] ?? (data['unit'] == Unit.imperial ? 128 : 4000),
        drinkSize: data['drinkSize'] ?? (data['unit'] == Unit.imperial ? 8 : 200),);
  }

  static Map<String, dynamic> toMap(Preferences data) {
    data = data ?? {};
    return {
      'unit': data.unit.value,
      'waterGoal': data.waterGoal,
      'totalGoal': data.totalGoal,
      'drinkSize': data.drinkSize
    };
  }

  void changeUnit() {
    if (unit == Unit.imperial) {
      this.unit = Unit.metric;
      this.waterGoal = 3000;
      this.totalGoal = 4000;
      this.drinkSize = 200;
    } else {
      this.unit = Unit.imperial;
      this.waterGoal = 96;
      this.totalGoal = 128;
      this.drinkSize = 8;
    }
  }
}

@VnumDefinition
class Unit extends Vnum<String> {
  /// Cases
  static const Unit imperial = const Unit.define("imperial");
  static const Unit metric = const Unit.define("metric");

  /// Constructors
  const Unit.define(String fromValue) : super.define(fromValue);

  factory Unit(String value) => Vnum.fromValue(value, Unit);
}
