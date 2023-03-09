import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinerv/src/blocs/cast_movie/cast_movie_bloc.dart';
import 'package:cinerv/src/blocs/detail_movie/detail_movie_bloc.dart';
import 'package:cinerv/src/blocs/review_movie/review_movie_bloc.dart';
import 'package:cinerv/src/constants/path_constants.dart';
import 'package:cinerv/src/constants/style_constants.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:cinerv/src/ui/detail_movie/detail_movie_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class swiper_item extends StatelessWidget {
  const swiper_item({
    Key? key,
    required this.moviePopular,
  }) : super(key: key);

  final Movie moviePopular;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        context.read<DetailMovieBloc>().add(GetDetailMovie(movieID: moviePopular.id!));
        context.read<CastMovieBloc>().add(GetCastEvent(movieID: moviePopular.id!));
        context.read<ReviewMovieBloc>().add(GetReviewMovie(movieID: moviePopular.id!));
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 120,
                width: 120,
                fit: BoxFit.cover,
                imageUrl: "$IMAGE_PATH_BACKDROP_POPULAR${moviePopular.backdropPath ?? moviePopular.posterPath}",
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 20,
            child: SizedBox(
              height: 80,
              width: MediaQuery.of(context).size.width / 1.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      "${moviePopular.title}",
                      maxLines: 3,
                      softWrap: true,
                      style: kStyleTitleMovieSwiper,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                color: const Color(0xffff375f).withOpacity(0.6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Row(
                children: [
                  const Icon(
                    EvaIcons.trendingUp,
                    size: 20,
                  ),
                  Container(width: 5),
                  const Text("Nổi bật"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
