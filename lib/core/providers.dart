import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:radio_stations_app/data/dao/favorite_dao.dart';
import 'package:radio_stations_app/data/repositories/radio_repository.dart';
import 'package:radio_stations_app/data/services/audio_player_service.dart';
import 'package:radio_stations_app/data/services/radio_service.dart';
import 'package:radio_stations_app/view_models/favorite_view_model.dart';
import 'package:radio_stations_app/view_models/radio_view_model.dart';
import '../data/app_database.dart';

List<SingleChildWidget> buildProviders(AppDatabase database) => [
  Provider<AppDatabase>.value(value: database),
  Provider<FavoriteDao>(
    create: (context) => database.favoriteDao,
  ),
  Provider<RadioService>(
    create: (_) => RadioService(),
  ),
  Provider<RadioRepository>(
    create: (context) => RadioRepository(
      service: context.read<RadioService>(),
      favoriteDao: context.read<FavoriteDao>(),
    ),
  ),
  Provider<AudioPlayerService>(
    create: (_) => AudioPlayerService(),
    dispose: (_, playerService) => playerService.dispose(),
  ),
  ChangeNotifierProvider<RadioViewModel>(
    create: (context) => RadioViewModel(
      repository: context.read<RadioRepository>(),
    )..fetchStations(),
  ),
  ChangeNotifierProvider<FavoriteViewModel>(
    create: (context) => FavoriteViewModel(
      repository: context.read<RadioRepository>(),
    ),
  ),
];