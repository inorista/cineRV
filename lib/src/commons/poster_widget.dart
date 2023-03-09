import 'package:cinerv/src/blocs/all_loved_movies/all_loved_movies_bloc.dart';
import 'package:cinerv/src/blocs/cast_movie/cast_movie_bloc.dart';
import 'package:cinerv/src/blocs/detail_movie/detail_movie_bloc.dart';
import 'package:cinerv/src/blocs/review_movie/review_movie_bloc.dart';
import 'package:cinerv/src/commons/formedCachedNetwork.dart';
import 'package:cinerv/src/constants/path_constants.dart';
import 'package:cinerv/src/constants/style_constants.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:cinerv/src/ui/detail_movie/detail_movie_screen.dart';
import 'package:cinerv/src/commons/page_transition.dart';
import 'package:cinerv/src/ui/lovelist/components/alert_dialog_confirm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:iconsax/iconsax.dart';

class poster_widget extends StatelessWidget {
  const poster_widget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        HapticFeedback.heavyImpact();
        context.read<DetailMovieBloc>().add(GetDetailMovie(movieID: movie.id!));
        context.read<CastMovieBloc>().add(GetCastEvent(movieID: movie.id!));
        context.read<ReviewMovieBloc>().add(GetReviewMovie(movieID: movie.id!));
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) =>  const DetailMovieScreen(),
            
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          padding: const EdgeInsets.only(bottom: 5),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: formedCachedImage(
                    imageUrl: "$IMAGE_PATH_BACKDROP${movie.posterPath}",
                    errorWidget: Container(
                      color: Colors.white,
                      child: const Center(
                        child: Text(
                          "NO POSTER",
                          style: kStyleNoPoster,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              BlocBuilder<AllLovedMoviesBloc, AllLovedMoviesState>(
                builder: (context, state) {
                  if (state is AllLovedMoviesLoaded) {
                    final listLovedMovies = state.listAllLovedMovies;
                    final bool isLoved =
                        listLovedMovies.indexWhere((element) => element.id == movie.id) != -1 ? true : false;
                    if (isLoved) {
                      return Positioned(
                        top: 20,
                        right: 20,
                        child: Bounceable(
                          onTap: () async {
                            HapticFeedback.vibrate();
                            showDialog(
                              context: context,
                              builder: (context) => confirm_box(
                                content: """Bạn muốn gỡ bộ phim "${movie.title}" khỏi danh sách ưu thích?""",
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
          ), /*ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: movie.posterPath == null
                ? Container(
                    color: const Color(0xffffffff),
                    child: const Center(
                      child: Text(
                        "NO POSTER",
                        style: kStyleNoPoster,
                      ),
                    ),
                  )
                : CachedNetworkImage(
                    imageUrl: "$IMAGE_PATH_POSTER${movie.posterPath}",
                    fadeInDuration: const Duration(milliseconds: 50),
                    fadeOutDuration: const Duration(milliseconds: 50),
                    placeholder: (context, url) => const CupertinoActivityIndicator(),
                    fit: BoxFit.fill,
                  ),
          ),*/
        ),
      ),
    );
  }
}
