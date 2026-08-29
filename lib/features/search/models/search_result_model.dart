class SearchResultModel {
  final String name;
  final double lat;
  final double lon;
  final String countryCode;

  SearchResultModel({
    required this.name,
    required this.lat,
    required this.lon,
    required this.countryCode,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      name: json['name'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
      countryCode: json['country'] as String? ?? '',
    );
  }
}
