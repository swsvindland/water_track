import 'package:vnum/vnum.dart';

class Preferences {
  Unit unit;
  int waterGoal;
  int totalGoal;
  int drinkSize;
  int start;
  int end;

  Preferences({this.unit, this.waterGoal, this.totalGoal, this.drinkSize, this.start, this.end});

  void setWaterGoal(int value) {
    waterGoal = value;
  }

  void setTotalGoal(int value) {
    totalGoal = value;
  }

  void setDrinkSize(int value) {
    drinkSize = value;
  }

  void setStartTime(int value) {
    start = value;
  }

  void setEndTime(int value) {
    end = value;
  }

  static Preferences empty() {
    return Preferences(
        unit: Unit.imperial, waterGoal: 96, totalGoal: 128, drinkSize: 8, start: 7, end: 20);
  }

  factory Preferences.fromMap(Map data) {
    data = data ?? {};

    return Preferences(
        unit: Unit.define(data['unit']) ?? Unit.imperial,
        waterGoal: data['waterGoal'] ?? (data['unit'] == Unit.imperial ? 96 : 3000),
        totalGoal: data['totalGoal'] ?? (data['unit'] == Unit.imperial ? 128 : 4000),
        drinkSize: data['drinkSize'] ?? (data['unit'] == Unit.imperial ? 8 : 200),
        start: data['start'].toDate().hour,
        end: data['end'].toDate().hour
    );
  }

  static Map<String, dynamic> toMap(Preferences data) {
    data = data ?? {};
    return {
      'unit': data.unit.value,
      'waterGoal': data.waterGoal,
      'totalGoal': data.totalGoal,
      'drinkSize': data.drinkSize,
      'start': DateTime.parse('2000-01-01 ${data.start.toString().padLeft(2, '0')}:00:00'),
      'end': DateTime.parse('2000-01-01 ${data.end.toString().padLeft(2, '0')}:00:00'),
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
