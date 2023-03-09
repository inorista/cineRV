import 'package:cinerv/src/blocs/cast_movie/cast_movie_bloc.dart';
import 'package:cinerv/src/blocs/detail_movie/detail_movie_bloc.dart';
import 'package:cinerv/src/blocs/review_movie/review_movie_bloc.dart';
import 'package:cinerv/src/constants/path_constants.dart';
import 'package:cinerv/src/constants/style_constants.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:cinerv/src/ui/detail_movie/detail_movie_screen.dart';
import 'package:cinerv/src/commons/formedCachedNetwork.dart';
import 'package:cinerv/src/commons/page_transition.dart';
import 'package:cinerv/src/ui/lovelist/components/alert_dialog_confirm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:iconsax/iconsax.dart';

class grid_poster_loved extends StatelessWidget {
  const grid_poster_loved({
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
          context.read<DetailMovieBloc>().add(GetDetailMovie(movieID: movie.id!));
          context.read<CastMovieBloc>().add(GetCastEvent(movieID: movie.id!));
          context.read<ReviewMovieBloc>().add(GetReviewMovie(movieID: movie.id!));
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const DetailMovieScreen(),
            ),
          );
        },
        child: Stack(
          children: [
            Positioned.fill(
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
            Positioned(
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
            ),
          ],
        ),
      ),
    );
  }
}
