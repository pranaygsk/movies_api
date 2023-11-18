import 'package:flutter/material.dart';
import 'package:movies_api/models/movie_model.dart';
import 'package:movies_api/provider/movies_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies API'),
      ),
      body: FutureBuilder(
        future: Provider.of<MoviesProvider>(context, listen: false).fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Consumer<MoviesProvider>(
              builder: (context, moviesProvider, child) => ListView.builder(
                itemCount: moviesProvider.movies.length,
                itemBuilder: (context, index) {
                  final movie = moviesProvider.movies[index];
                  return ListTile(
                    title: Text(movie.title),
                    subtitle: Text(movie.overview),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
