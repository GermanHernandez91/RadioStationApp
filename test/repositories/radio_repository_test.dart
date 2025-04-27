import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:radio_stations_app/data/models/favorite_station.dart';
import 'package:radio_stations_app/data/repositories/radio_repository.dart';
import 'package:radio_stations_app/data/dao/favorite_dao.dart';
import 'package:radio_stations_app/data/services/radio_service.dart';
import 'package:radio_stations_app/data/models/radio_station.dart';

class MockRadioService extends Mock implements RadioService {}
class MockFavoriteDao extends Mock implements FavoriteDao {}

void main() {
  late RadioRepository repository;
  late MockRadioService mockService;
  late MockFavoriteDao mockDao;

  setUpAll(() {
    registerFallbackValue(
      RadioStation(
        url: 'https://fallback.com',
        name: 'Fallback Station',
        favicon: '',
        country: 'Nowhere',
      ),
    );
  });

  setUp(() {
    mockService = MockRadioService();
    mockDao = MockFavoriteDao();
    repository = RadioRepository(service: mockService, favoriteDao: mockDao);
  });

  test('Should fetch stations', () async {
    when(() => mockService.fetchStations()).thenAnswer((_) async => [
      RadioStation(url: 'url1', name: 'Station 1', favicon: 'icon1', country: 'Country 1')
    ]);

    final stations = await repository.getStations();

    expect(stations, isNotEmpty);
    expect(stations.first.name, 'Station 1');
  });

  test('Should fetch favorites', () async {
    when(() => mockDao.getAllFavorites()).thenAnswer((_) async => [
      FavoriteStation(url: 'url1', name: 'Station 1', favicon: 'icon1', country: 'Country 1')
    ]);

    final stations = await repository.getFavorites();

    expect(stations, isNotEmpty);
    expect(stations.first.name, 'Station 1');
  });
}