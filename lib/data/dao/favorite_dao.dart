import 'package:floor/floor.dart';
import '../models/favorite_station.dart';

@dao
abstract class FavoriteDao {
  @Query('SELECT * FROM FavoriteStation')
  Future<List<FavoriteStation>> getAllFavorites();

  @Query('SELECT * FROM FavoriteStation')
  Stream<List<FavoriteStation>> watchAllFavorites();

  @insert
  Future<void> insertFavorite(FavoriteStation station);

  @delete
  Future<void> deleteFavorite(FavoriteStation station);

  @Query('SELECT EXISTS(SELECT 1 FROM FavoriteStation WHERE url = :url)')
  Future<bool?> isFavorite(String url);
}