import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_stations_app/views/home/widgets/search_widget.dart';
import '../../../view_models/radio_view_model.dart';
import '../../data/models/favorite_station.dart';
import 'widgets/station_card.dart';
import '../../../widgets/custom_player_controls.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RadioViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio Stations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchWidget(viewModel: viewModel),
            const SizedBox(height: 12),
            Expanded(
              child: viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : StreamBuilder<List<FavoriteStation>>(
                stream: viewModel.favoritesStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final favorites = snapshot.data ?? [];

                  if (viewModel.stations.isEmpty) {
                    return const Center(child: Text('No stations found'));
                  }

                  return ListView.builder(
                    itemCount: viewModel.stations.length,
                    itemBuilder: (context, index) {
                      final station = viewModel.stations[index];
                      final isFav = favorites.any((fav) => fav.url == station.url);

                      return StationCard(
                        station: station,
                        isFavorite: isFav,
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
                          await viewModel.toggleFavorite(station);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

