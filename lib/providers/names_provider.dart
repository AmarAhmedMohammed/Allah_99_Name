import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/allah_name.dart';

class NamesProvider with ChangeNotifier {
  List<AllahName> _allNames = [];
  List<AllahName> _filteredNames = [];
  bool _isLoading = true;
  String _searchQuery = '';

  List<AllahName> get allNames => _allNames;
  List<AllahName> get filteredNames => _filteredNames;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  NamesProvider() {
    loadNames();
  }

  Future<void> loadNames() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Load JSON file from assets
      final String jsonString = await rootBundle.loadString(
        'assets/data/names.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> namesJson = jsonData['names'];

      _allNames = namesJson.map((json) => AllahName.fromJson(json)).toList();
      _filteredNames = List.from(_allNames);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error loading names: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchNames(String query) {
    _searchQuery = query.toLowerCase().trim();

    if (_searchQuery.isEmpty) {
      _filteredNames = List.from(_allNames);
    } else {
      _filteredNames = _allNames.where((name) {
        return name.transliteration.toLowerCase().contains(_searchQuery) ||
            name.meaningEn.toLowerCase().contains(_searchQuery) ||
            name.arabic.contains(_searchQuery);
      }).toList();
    }

    notifyListeners();
  }

  AllahName? getNameById(int id) {
    try {
      return _allNames.firstWhere((name) => name.id == id);
    } catch (e) {
      return null;
    }
  }

  int getIndexById(int id) {
    return _allNames.indexWhere((name) => name.id == id);
  }
}
