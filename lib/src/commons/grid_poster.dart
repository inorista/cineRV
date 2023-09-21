import 'package:cinerv/src/blocs/all_loved_movies/all_loved_movies_bloc.dart';
import 'package:cinerv/src/blocs/cast_movie/cast_movie_bloc.dart';
import 'package:cinerv/src/blocs/detail_movie/detail_movie_bloc.dart';
import 'package:cinerv/src/blocs/review_movie/review_movie_bloc.dart';
import 'package:cinerv/src/constants/path_constants.dart';
import 'package:cinerv/src/constants/style_constants.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:cinerv/src/ui/detail_movie/detail_movie_screen.dart';
import 'package:cinerv/src/commons/formed_cached_network.dart';
import 'package:cinerv/src/ui/lovelist/components/alert_dialog_confirm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:iconsax/iconsax.dart';

class GridPoster extends StatelessWidget {
  const GridPoster({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () async {
          HapticFeedback.heavyImpact();
          context
              .read<DetailMovieBloc>()
              .add(GetDetailMovie(movieID: movie.id!));
          context.read<CastMovieBloc>().add(GetCastEvent(movieID: movie.id!));
          context
              .read<ReviewMovieBloc>()
              .add(GetReviewMovie(movieID: movie.id!));
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => const DetailMovieScreen()));
        },
        child: Stack(
          children: [
            movie.posterPath == null
                ? Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        "NO POSTER",
                        style: kStyleNoPoster,
                      ),
                    ),
                  )
                : Positioned.fill(
                    child: FormedCachedImage(
                      imageUrl:
                          "$IMAGE_PATH_POSTER${movie.posterPath ?? movie.backdropPath}",
                    ),
                  ),
            BlocBuilder<AllLovedMoviesBloc, AllLovedMoviesState>(
              builder: (context, state) {
                if (state is AllLovedMoviesLoaded) {
                  final listLovedMovies = state.listAllLovedMovies;
                  final bool isLoved = listLovedMovies.indexWhere(
                              (element) => element.id == movie.id) !=
                          -1
                      ? true
                      : false;
                  if (isLoved) {
                    return Positioned(
                      top: 20,
                      right: 20,
                      child: Bounceable(
                        onTap: () async {
                          HapticFeedback.vibrate();
                          showDialog(
                            context: context,
                            builder: (context) => ConfirmBox(
                              content:
                                  """Bạn muốn gỡ bộ phim "${movie.title}" khỏi danh sách ưu thích?""",
                              movieID: movie.id!,
                            ),
                          );
                        },
                        child: const Icon(
                          Iconsax.heart5,
                          color: Color(0xffff375f),
                          size: 25,
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
