class PrecipitationModel {
  final double h1;

  PrecipitationModel({required this.h1});

  factory PrecipitationModel.fromJson(dynamic json) {
    if (json == null) return PrecipitationModel(h1: 0.0);

    if (json is num) {
      return PrecipitationModel(h1: json.toDouble());
    } else if (json is Map<String, dynamic>) {
      return PrecipitationModel(h1: (json['1h'] as num?)?.toDouble() ?? 0.0);
    }
    return PrecipitationModel(h1: 0.0);
  }
}
