class SearchResultModel {
  final String name;
  final double lat;
  final double lon;
  final String country;
  final String? state;
  final Map<String, String>? localNames;

  SearchResultModel({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    this.state,
    this.localNames,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    Map<String, String>? parsedLocalNames;
    if (json['local_names'] != null) {
      parsedLocalNames = Map<String, String>.from(json['local_names']);
    }

    return SearchResultModel(
      name: json['name'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
      country: json['country'] as String? ?? '',
      state: json['state'] as String?,
      localNames: parsedLocalNames,
    );
  }
}
