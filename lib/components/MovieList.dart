import 'package:flutter/material.dart';
import 'package:moviesapp/components/MovieItem.dart';
import 'package:moviesapp/models/Movie.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList({this.movies});

  @override
  Widget build(context) {
    return 
    new Container(
      //decoration: BoxDecoration(color: Colors.grey),
      child: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        addAutomaticKeepAlives: true,

        itemCount: this.movies.length,
        itemBuilder: (BuildContext context, int index) {
          return
              MovieItem(movie: this.movies[index]);
        },
      ),
    );
  }
}
