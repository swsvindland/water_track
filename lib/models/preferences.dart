enum Unit {imperial, metric}

class Preferences {
  Unit unit;

  Preferences({this.unit});

  static Preferences empty() {
    return Preferences(unit: Unit.imperial);
  }

  factory Preferences.fromMap(Map data) {
    data = data ?? { };
    return Preferences(
        unit: data['unit'] ?? Unit.imperial,
    );
  }

  static Map<String, dynamic> toMap(Preferences data) {
    data = data ?? { };
    return {
      'unit': data.unit,
    };
  }

  void changeUnit() {
    if (unit == Unit.imperial) {
      this.unit = Unit.metric;
    } else {
      this.unit = Unit.imperial;
    }
  }
}