import 'package:go_router/go_router.dart';
import 'package:radio_stations_app/views/home/home_screen.dart';
import 'package:radio_stations_app/views/favorites/favorites_screen.dart';
import 'package:radio_stations_app/views/main_shell.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/stations',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/stations',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) => const FavoritesScreen(),
        ),
      ],
    ),
  ],
);