class TemperatureModel {
  final double current;
  final double? min;
  final double? max;
  final double? morn;
  final double? day;
  final double? eve;
  final double? night;

  TemperatureModel({
    required this.current,
    this.min,
    this.max,
    this.morn,
    this.day,
    this.eve,
    this.night,
  });

  factory TemperatureModel.fromJson(dynamic json) {
    if (json == null) return TemperatureModel(current: 0.0);

    if (json is num) {
      return TemperatureModel(current: json.toDouble());
    } else if (json is Map<String, dynamic>) {
      return TemperatureModel(
        current: (json['day'] as num?)?.toDouble() ?? 0.0,
        min: (json['min'] as num?)?.toDouble(),
        max: (json['max'] as num?)?.toDouble(),
        morn: (json['morn'] as num?)?.toDouble(),
        day: (json['day'] as num?)?.toDouble(),
        eve: (json['eve'] as num?)?.toDouble(),
        night: (json['night'] as num?)?.toDouble(),
      );
    }
    return TemperatureModel(current: 0.0);
  }
}
