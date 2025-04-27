class RadioStation {
  final String name;
  final String url;
  final String favicon;
  final String country;

  RadioStation({
    required this.name,
    required this.url,
    required this.favicon,
    required this.country
  });

  factory RadioStation.fromJson(Map<String, dynamic> json) {
    return RadioStation(
      name: json['name'] ?? '',
      url: json['url_resolved'] ?? '',
      favicon: json['favicon'] ?? '',
      country: json['country'] ?? ''
    );
  }
}