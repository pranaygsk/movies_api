import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MoviesProvider extends ChangeNotifier{
  final String apiKey = "a744b5e1e98042a1137fa23ed03efec3";
  final String apiUrl = "https://api.themoviedb.org/3";

  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  Future<void> fetchData() async{
    try {
      final response = await http.get(
          Uri.parse("$apiUrl/movie/popular?language=en-US&page=1&api_key=$apiKey"));
      if (response.statusCode == 200) {
        final Map<String,dynamic> data = json.decode(response.body);
        final List<dynamic> moviesData = data['results'];

        _movies = moviesData.map((movie) => Movie.fromJson(movie)).toList();
        notifyListeners();
      } else {
        debugPrint("Error fetching API");
      }
    }catch(e){
      debugPrint("Exception caught $e");
    }
  }

}