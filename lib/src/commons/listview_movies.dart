import 'package:cinerv/src/models/movie.dart';
import 'package:cinerv/src/commons/poster_widget.dart';
import 'package:flutter/material.dart';

class listview_movie extends StatelessWidget {
  const listview_movie({
    Key? key,
    required this.listMovies,
  }) : super(key: key);

  final List<Movie> listMovies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      addAutomaticKeepAlives: true,
      padding: const EdgeInsets.only(top: 20, left: 10),
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemCount: listMovies.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => poster_widget(movie: listMovies[index]),
    );
  }
}
