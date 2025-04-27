import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_stations_app/core/providers.dart';
import 'package:radio_stations_app/core/router.dart';
import 'package:radio_stations_app/core/theme.dart';
import 'package:radio_stations_app/data/app_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('favorites.db').build();
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: buildProviders(database),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Radio Stations App',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: appRouter,
      ),
    );
  }
}