import 'package:flutter/material.dart';

import '../data/models/favorite_station.dart';
import '../data/repositories/radio_repository.dart';

class FavoriteViewModel extends ChangeNotifier {
  final RadioRepository repository;

  Stream<List<FavoriteStation>> get favoritesStream => repository.watchFavorites();

  FavoriteViewModel({required this.repository});

  Future<void> toggleFavorite(FavoriteStation station) async {
    await repository.deleteFavorite(station);
  }
}