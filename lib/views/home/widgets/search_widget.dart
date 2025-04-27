import 'package:flutter/material.dart';
import '../../../view_models/radio_view_model.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.viewModel,
  });

  final RadioViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: TextField(
        onChanged: (value) {
          viewModel.filterStations(value);
        },
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          filled: true,
          fillColor: theme.colorScheme.surfaceContainerHighest,
          hintText: 'Search for a station...',
          hintStyle: TextStyle(color: theme.hintColor),
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: theme.colorScheme.onSurfaceVariant,
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}