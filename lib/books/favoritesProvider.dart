import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider with ChangeNotifier {
  List<String> _favoriteIds = [];

  List<String> get favoriteIds => _favoriteIds;

  FavoritesProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favoriteIds = prefs.getStringList('favoriteBooks') ?? [];
    notifyListeners();
  }

  Future<void> addFavorite(String bookId) async {
    if (!_favoriteIds.contains(bookId)) {
      _favoriteIds.add(bookId);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favoriteBooks', _favoriteIds);
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String bookId) async {
    if (_favoriteIds.contains(bookId)) {
      _favoriteIds.remove(bookId);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favoriteBooks', _favoriteIds);
      notifyListeners();
    }
  }
}
