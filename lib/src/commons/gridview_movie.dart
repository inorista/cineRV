import 'package:cinerv/src/blocs/all_loved_movies/all_loved_movies_bloc.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:cinerv/src/commons/grid_poster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class gridview_movie extends StatelessWidget {
  const gridview_movie({
    Key? key,
    required this.listAllMovies,
  }) : super(key: key);

  final List<Movie> listAllMovies;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllLovedMoviesBloc, AllLovedMoviesState>(
      builder: (context, state) {
        if (state is AllLovedMoviesLoaded) {
          return GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            addAutomaticKeepAlives: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listAllMovies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (BuildContext context, int index) {
              final movie = listAllMovies[index];
              return grid_poster(
                movie: movie,
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
