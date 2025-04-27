import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:radio_stations_app/view_models/radio_view_model.dart';
import 'package:radio_stations_app/data/repositories/radio_repository.dart';
import 'package:radio_stations_app/data/models/radio_station.dart';

class MockRadioRepository extends Mock implements RadioRepository {}

void main() {
  late RadioViewModel viewModel;
  late MockRadioRepository mockRepo;

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
    mockRepo = MockRadioRepository();
    viewModel = RadioViewModel(repository: mockRepo);
  });

  test('fetchStations sets stations', () async {
    when(() => mockRepo.getStations()).thenAnswer((_) async => [
      RadioStation(url: 'url1', name: 'Station 1', favicon: 'icon1', country: 'Country 1')
    ]);

    await viewModel.fetchStations();

    expect(viewModel.stations.length, 1);
    expect(viewModel.stations.first.name, 'Station 1');
  });

  test('Should toggle favorite given a station', () async {
    final RadioStation station = RadioStation(url: 'url1', name: 'Station 1', favicon: 'icon1', country: 'Country 1');
    when(() => mockRepo.toggleFavorite(any())).thenAnswer((_) async => {});
    await viewModel.toggleFavorite(station);
    verify(() => mockRepo.toggleFavorite(station)).called(1);
  });
}