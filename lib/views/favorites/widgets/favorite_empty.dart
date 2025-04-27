import 'package:flutter/material.dart';

class FavoriteEmptyWidget extends StatelessWidget {
  const FavoriteEmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('No favorites yet',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10,),
              Text(
                'Start adding your first favorite by tapping the heart of any radio station',
                textAlign: TextAlign.center,
              )
            ],
          ),
        )
    );
  }
}