import 'package:flutter/material.dart';
import '../data/models/favorite_station.dart';
import '../data/models/radio_station.dart';
import '../data/repositories/radio_repository.dart';

class RadioViewModel with ChangeNotifier {
  final RadioRepository repository;

  List<RadioStation> _stations = [];

  List<RadioStation> _filteredStations = [];

  Stream<List<FavoriteStation>> get favoritesStream => repository.watchFavorites();

  bool isLoading = false;
  String? errorMessage;

  RadioViewModel({required this.repository});

  List<RadioStation> get stations => _filteredStations;

  Future<void> fetchStations() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      _stations = await repository.getStations();
      _filteredStations = _stations;
    } catch (e) {
      errorMessage = 'Failed to load stations';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(RadioStation station) async {
    await repository.toggleFavorite(station);
  }

  void filterStations(String query) {
    if (query.isEmpty) {
      _filteredStations = _stations;
    } else {
      _filteredStations = _stations
          .where((station) => station.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}