import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/meal_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteProvider with ChangeNotifier {
  // Map menyimpan daftar favorit per user ID (uid)
  final Map<String, List<Meal>> _userFavorites = {};

  // Getter untuk mengambil daftar favorit user saat ini
  List<Meal> get favorites {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null && _userFavorites.containsKey(userId)) {
      return _userFavorites[userId]!;
    }
    return [];
  }

  // Cek apakah user sudah login
  bool get isLoggedIn => FirebaseAuth.instance.currentUser != null;

  // Konstruktor: secara otomatis memuat data favorit saat provider dibuat
  FavoriteProvider() {
    loadFavorites();
  }

  // Cek apakah meal sudah termasuk ke dalam favorit user
  bool isFavorite(Meal meal) {
    return favorites.any((fav) => fav.id == meal.id);
  }

  // Tambah atau hapus meal dari daftar favorit
  void toggleFavorite(Meal meal) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final list = _userFavorites[userId] ?? [];
    if (list.any((m) => m.id == meal.id)) {
      list.removeWhere((m) => m.id == meal.id); // Hapus dari favorit
    } else {
      list.add(meal); // Tambah ke favorit
    }
    _userFavorites[userId] = list;
    notifyListeners();
    await _saveFavorites(userId); // Simpan ke SharedPreferences
  }

  // Muat data favorit dari SharedPreferences berdasarkan user ID
  Future<void> loadFavorites() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('favorites_$userId');
    if (data != null) {
      final List decoded = json.decode(data);
      _userFavorites[userId] = decoded.map((item) => Meal.fromJson(item)).toList();
      notifyListeners();
    }
  }

  // Simpan data favorit user ke SharedPreferences
  Future<void> _saveFavorites(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = json.encode(_userFavorites[userId]!.map((m) => m.toJson()).toList());
    await prefs.setString('favorites_$userId', encoded);
  }

  // Hapus semua favorit user (dipanggil saat logout atau reset)
  void clearFavorites() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      _userFavorites[userId] = [];
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('favorites_$userId');
      notifyListeners();
    }
  }
}
