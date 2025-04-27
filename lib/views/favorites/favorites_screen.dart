import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_stations_app/view_models/favorite_view_model.dart';
import 'package:radio_stations_app/views/favorites/widgets/favorite_empty.dart';
import '../../widgets/custom_player_controls.dart';
import '../home/widgets/station_card.dart';
import '../../data/models/favorite_station.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FavoriteViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: StreamBuilder<List<FavoriteStation>>(
        stream: viewModel.favoritesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final favorites = snapshot.data ?? [];

          if (favorites.isEmpty) {
            return const FavoriteEmptyWidget();
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final fav = favorites[index];
              final station = fav.toRadioStation();

              return StationCard(
                station: station,
                isFavorite: true,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => CustomPlayerControls(station: station),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                  );
                },
                onFavoriteToggle: () async {
                  await viewModel.toggleFavorite(fav);
                },
              );
            },
          );
        },
      ),
    );
  }
}