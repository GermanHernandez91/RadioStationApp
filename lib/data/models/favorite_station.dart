import 'package:floor/floor.dart';
import 'package:radio_stations_app/data/models/radio_station.dart';

@entity
class FavoriteStation {
  @primaryKey
  final String url;

  final String name;
  final String favicon;
  final String country;

  FavoriteStation({
    required this.url,
    required this.name,
    required this.favicon,
    required this.country,
  });
}

extension FavoriteStationMapper on FavoriteStation {
  RadioStation toRadioStation() {
    return RadioStation(
      name: name,
      url: url,
      favicon: favicon,
      country: country,
    );
  }
}