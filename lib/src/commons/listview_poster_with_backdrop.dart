import 'dart:ui';

import 'package:cinerv/src/blocs/all_loved_movies/all_loved_movies_bloc.dart';
import 'package:cinerv/src/blocs/cast_movie/cast_movie_bloc.dart';
import 'package:cinerv/src/blocs/detail_movie/detail_movie_bloc.dart';
import 'package:cinerv/src/blocs/review_movie/review_movie_bloc.dart';
import 'package:cinerv/src/commons/formedCachedNetwork.dart';
import 'package:cinerv/src/commons/page_transition.dart';
import 'package:cinerv/src/constants/path_constants.dart';
import 'package:cinerv/src/constants/style_constants.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:cinerv/src/ui/detail_movie/detail_movie_screen.dart';
import 'package:cinerv/src/ui/lovelist/components/alert_dialog_confirm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:iconsax/iconsax.dart';

class listview_poster_with_backdrop extends StatelessWidget {
  const listview_poster_with_backdrop({
    Key? key,
    required this.listMovieData,
  }) : super(key: key);

  final List<Movie> listMovieData;

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      physics: const NeverScrollableScrollPhysics(),
      addAutomaticKeepAlives: true,
      shrinkWrap: true,
      itemCount: listMovieData.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            HapticFeedback.heavyImpact();
            context.read<DetailMovieBloc>().add(GetDetailMovie(movieID: listMovieData[index].id!));
            context.read<CastMovieBloc>().add(GetCastEvent(movieID: listMovieData[index].id!));
            context.read<ReviewMovieBloc>().add(GetReviewMovie(movieID: listMovieData[index].id!));
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const DetailMovieScreen(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: deviceHeight / 3.5,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    SizedBox(
                      height: deviceHeight / 3.5,
                      width: deviceWidth,
                      child: formedCachedImage(
                        imageUrl:
                            "$IMAGE_PATH_BACKDROP${listMovieData[index].backdropPath ?? listMovieData[index].posterPath}",
                        errorWidget: Container(),
                      ),
                    ),
                    ClipRRect(
                      child: SizedBox(
                        height: deviceHeight / 3.5,
                        width: deviceWidth,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 50,
                            sigmaY: 50,
                          ),
                          child: Container(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                            width: deviceWidth / 2.5,
                            height: deviceHeight / 3.5,
                            child: formedCachedImage(
                              imageUrl: "${IMAGE_PATH_POSTER}${listMovieData[index].posterPath}",
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
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${listMovieData[index].title == listMovieData[index].originalTitle ? listMovieData[index].title : "${listMovieData[index].title}\n(${listMovieData[index].originalTitle})"}",
                                style: kStyleTitleLoved,
                              ),
                              const SizedBox(height: 20),
                              listMovieData[index].status == null
                                  ? Text("Tổng lượt vote: ${listMovieData[index].voteCount}")
                                  : Text(listMovieData[index].status == "Released" ? "Đã hoàn thành" : "Chưa ra mắt"),
                              const SizedBox(height: 10),
                              listMovieData[index].runtime == null
                                  ? Text("${listMovieData[index].releaseDate}")
                                  : Text(
                                      "Thời lượng: ${listMovieData[index].runtime == 0 ? "Chưa rõ" : "${listMovieData[index].runtime} phút"}",
                                    ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/imdb_logo.png",
                                    width: 40,
                                  ),
                                  Text(
                                    "  ${listMovieData[index].voteAverage?.toStringAsFixed(1) ?? 0}/10",
                                    style: kSoftInfo,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    BlocBuilder<AllLovedMoviesBloc, AllLovedMoviesState>(
                      builder: (context, state) {
                        if (state is AllLovedMoviesLoaded) {
                          final isLoved =
                              state.listAllLovedMovies.indexWhere((element) => element.id == listMovieData[index].id) !=
                                      -1
                                  ? true
                                  : false;
                          if (isLoved) {
                            return Positioned(
                              top: 10,
                              left: 10,
                              child: Bounceable(
                                onTap: () async {
                                  HapticFeedback.vibrate();
                                  showDialog(
                                    context: context,
                                    builder: (context) => confirm_box(
                                      content:
                                          """Bạn muốn gỡ bộ phim "${listMovieData[index].title}" khỏi danh sách ưu thích?""",
                                      movieID: listMovieData[index].id!,
                                    ),
                                  );
                                },
                                child: Icon(
                                  Iconsax.heart5,
                                  color: Colors.red.withOpacity(0.85),
                                  size: 30,
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
            ),
          ),
        );
      },
    );
  }
}
