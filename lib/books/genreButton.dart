import 'package:flutter/material.dart';

class GenreButton extends StatelessWidget {
  final String genre;
  final bool isSelected;
  final VoidCallback onTap;

  GenreButton(this.genre, {required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSecondary,
        shape: StadiumBorder(),
        side: BorderSide(color: Colors.black),
      ),
      child: Text(
        genre,
        style: TextStyle(
          color: isSelected ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}