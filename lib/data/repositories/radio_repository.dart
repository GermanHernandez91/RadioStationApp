import 'package:radio_stations_app/data/dao/favorite_dao.dart';
import 'package:radio_stations_app/data/models/radio_station.dart';
import 'package:radio_stations_app/data/services/radio_service.dart';

import '../models/favorite_station.dart';

class RadioRepository {
  final RadioService _service;
  final FavoriteDao _favoriteDao;

  RadioRepository({
    required RadioService service,
    required FavoriteDao favoriteDao,
  }) : _service = service, _favoriteDao = favoriteDao;

  Future<List<RadioStation>> getStations() => _service.fetchStations();

  Future<List<FavoriteStation>> getFavorites() => _favoriteDao.getAllFavorites();

  Stream<List<FavoriteStation>> watchFavorites() => _favoriteDao.watchAllFavorites();

  Future<void> toggleFavorite(RadioStation station) async {
    final alreadyFavorite = await _favoriteDao.isFavorite(station.url) ?? false;

    if (alreadyFavorite) {
      _removeFavorite(station);
    } else {
      _addFavorite(station);
    }
  }

  Future<void> deleteFavorite(FavoriteStation station) async {
    await _favoriteDao.deleteFavorite(station);
  }

  Future<void> _addFavorite(RadioStation station) async {
    await _favoriteDao.insertFavorite(FavoriteStation(
      url: station.url,
      name: station.name,
      favicon: station.favicon,
      country: station.country,
    ));
  }

  Future<void> _removeFavorite(RadioStation station) async {
    await _favoriteDao.deleteFavorite(FavoriteStation(
      url: station.url,
      name: station.name,
      favicon: station.favicon,
      country: station.country,
    ));
  }
}