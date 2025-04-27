import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../data/services/audio_player_service.dart';
import '../data/models/radio_station.dart';
import 'dart:async';

class CustomPlayerControls extends StatefulWidget {
  final RadioStation station;

  const CustomPlayerControls({super.key, required this.station});

  @override
  State<CustomPlayerControls> createState() => _CustomPlayerControlsState();
}

class _CustomPlayerControlsState extends State<CustomPlayerControls> {
  late StreamSubscription playerSubscription;
  bool isPlaying = false;
  double volume = 1.0;
  bool isBuffering = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final player = context.read<AudioPlayerService>();
      playerSubscription = player.playerStateStream.listen((state) {
        if (mounted) {
          setState(() {
            isPlaying = state.playing;
            isBuffering = (state.processingState == ProcessingState.buffering);
          });
        }
      });
    });

    _startStation();
  }

  Future<void> _startStation() async {
    final player = context.read<AudioPlayerService>();
    await player.setUrl(widget.station.url);
    player.play();
    player.setCurrentStation(widget.station);
  }

  @override
  void dispose() {
    playerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final player = context.read<AudioPlayerService>();
    final theme = Theme.of(context);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Station Name
            Text(
              widget.station.name,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Icon or Loading
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: child,
              ),
              child: isBuffering
                  ? SizedBox(
                key: const ValueKey('loading'),
                height: 120,
                width: 120,
                child: Lottie.asset('assets/lottie/loading_music.json'),
              )
                  : IconButton(
                key: const ValueKey('playPause'),
                icon: Icon(
                  isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                  size: 80,
                  color: theme.colorScheme.primary,
                ),
                onPressed: () {
                  isPlaying ? player.pause() : player.play();
                },
              ),
            ),

            const SizedBox(height: 32),

            // Volume Label + Slider
            Column(
              children: [
                Text(
                  'Volume',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Slider(
                  min: 0,
                  max: 1,
                  divisions: 10,
                  value: volume,
                  onChanged: (value) {
                    setState(() => volume = value);
                    player.setVolume(value);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}