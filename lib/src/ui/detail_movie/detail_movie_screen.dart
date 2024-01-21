import 'dart:ui';

import 'package:cinerv/src/blocs/all_loved_movies/all_loved_movies_bloc.dart';
import 'package:cinerv/src/blocs/cast_movie/cast_movie_bloc.dart';
import 'package:cinerv/src/blocs/detail_movie/detail_movie_bloc.dart';
import 'package:cinerv/src/blocs/review_movie/review_movie_bloc.dart';
import 'package:cinerv/src/constants/path_constants.dart';
import 'package:cinerv/src/constants/style_constants.dart';
import 'package:cinerv/src/models/credit.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:cinerv/src/ui/share_detail/share_detail.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:cinerv/src/commons/formedCachedNetwork.dart';
import 'package:screenshot/screenshot.dart';

class DetailMovieScreen extends StatelessWidget {
  const DetailMovieScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    List<Cast> listCastTemp = [];
    return Scaffold(
      backgroundColor: const Color(0xff181818),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<DetailMovieBloc, DetailMovieState>(
        buildWhen: (previous, current) {
          return previous != current;
        },
        builder: (context, detailState) {
          if (detailState is DetailMovieLoading) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (detailState is DetailMovieLoaded) {
            final movie = detailState.movie;
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  child: SizedBox(
                    height: deviceHeight / 3,
                    width: deviceWidth,
                    child: movie.backdropPath == null
                        ? Container()
                        : formedCachedImage(
                            imageUrl: "$IMAGE_PATH_BACKDROP${movie.backdropPath ?? movie.posterPath}",
                          ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: SizedBox(
                    height: deviceHeight / 3,
                    width: deviceWidth,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 8,
                        sigmaY: 8,
                      ),
                      child: Container(
                        color: Colors.black.withOpacity(0.01),
                      ),
                    ),
                  ),
                ),
                CustomScrollView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      actions: [
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ShareDetailScreen(
                                  movie: movie,
                                ),
                              ),
                            );
                          },
                          child: const Icon(
                            EvaIcons.shareOutline,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: BlocBuilder<DetailMovieBloc, DetailMovieState>(
                            builder: (context, detailState) {
                              return BlocBuilder<AllLovedMoviesBloc, AllLovedMoviesState>(
                                builder: (context, loveState) {
                                  if (detailState is DetailMovieLoaded) {
                                    if (loveState is AllLovedMoviesLoaded) {
                                      final bool isLoved = loveState.listAllLovedMovies
                                                  .indexWhere((e) => e.id == detailState.movie.id) !=
                                              -1
                                          ? true
                                          : false;

                                      if (isLoved) {
                                        return Bounceable(
                                          onTap: () async {
                                            HapticFeedback.heavyImpact();
                                            context
                                                .read<AllLovedMoviesBloc>()
                                                .add(RemoveMovieFromList(movieID: detailState.movie.id!.toString()));
                                          },
                                          child: Icon(
                                            Iconsax.heart5,
                                            color: Colors.red.withOpacity(0.85),
                                            size: 25,
                                          ),
                                        );
                                      } else {
                                        return Bounceable(
                                          onTap: () {
                                            HapticFeedback.heavyImpact();
                                            context.read<AllLovedMoviesBloc>().add(
                                                  AddMovieToList(
                                                    movieID: detailState.movie.id.toString(),
                                                  ),
                                                );
                                          },
                                          child: const Icon(
                                            Iconsax.heart,
                                            size: 25,
                                          ),
                                        );
                                      }
                                    }
                                  }
                                  return Container();
                                },
                              );
                            },
                          ),
                        )
                      ],
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      toolbarHeight: 80,
                      leading: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: const Icon(
                          EvaIcons.arrowIosBack,
                          size: 25,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: deviceHeight / 3,
                        width: double.infinity,
                        child: Row(
                          children: [
                            movie.posterPath == null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: deviceHeight / 3,
                                      width: deviceWidth / 2.2,
                                      color: const Color(0xffffffff),
                                      child: const Center(
                                        child: Text(
                                          "NO POSTER",
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: formedCachedImage(
                                      imageUrl: "$IMAGE_PATH_POSTER${movie.posterPath}",
                                    ),
                                  ),
                            Container(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    movie.status == "Released" ? "Đã hoàn thành" : "Phim chưa ra mắt",
                                    style: kStyleStatusMovie,
                                  ),
                                  Container(height: 10),
                                  Row(
                                    children: [
                                      const Icon(
                                        Iconsax.clock,
                                        size: 15,
                                      ),
                                      Container(width: 4),
                                      Flexible(
                                        child: Text(
                                          "Thời lượng: ${movie.runtime == 0 ? "Chưa rõ" : "${movie.runtime} phút"}",
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(height: 10),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        width: double.infinity,
                        color: const Color(0xff181818),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(height: 5),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "${movie.title == movie.originalTitle ? movie.title : "${movie.title}\n(${movie.originalTitle})"}",
                                style: kStyleSummaries,
                              ),
                            ),
                            Container(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/imdb_logo.png",
                                    width: 40,
                                  ),
                                  Text(
                                    "  ${movie.voteAverage?.toStringAsFixed(1) ?? 0}/10",
                                    style: kSoftInfo,
                                  ),
                                ],
                              ),
                            ),
                            Container(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Wrap(
                                children: [
                                  ...List.generate(
                                    movie.genres?.length ?? 0,
                                    (index) => Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: const Color(0xff545454),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          "${movie.genres?[index].name?.replaceAll("Phim", "")}",
                                          style: kStyleGenre,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(height: 20),
                            const customDivider(),
                            Container(height: 20),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Nội dung chính của phim:",
                                style: kStyleSummaries,
                              ),
                            ),
                            Container(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: ReadMoreText(
                                "${movie.overview == "" ? "Phim chưa cập nhật nội dung chính." : movie.overview}",
                                trimLines: 3,
                                colorClickableText: const Color(0xffe21221),
                                trimMode: TrimMode.Line,
                                trimCollapsedText: "xem thêm",
                                trimExpandedText: " rút gọn",
                                style: kStyleOverview,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: const Color(0xff181818),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: SizedBox(
                            height: 55,
                            child: BlocBuilder<CastMovieBloc, CastMovieState>(
                              builder: (context, state) {
                                if (state is CastMovieLoading) {
                                  return const CupertinoActivityIndicator();
                                } else if (state is CastMovieLoaded) {
                                  return ListView.builder(
                                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    itemCount: state.castLoaded.cast?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final listCast = state.castLoaded.cast;
                                      listCastTemp.clear();
                                      listCastTemp.addAll(listCast ?? []);
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: SizedBox(
                                          width: deviceWidth / 2.5,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              listCast![index].profilePath == null
                                                  ? Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(100),
                                                        color: const Color(0xff545454),
                                                      ),
                                                      child: const Center(
                                                        child: Icon(
                                                          EvaIcons.questionMark,
                                                          size: 25,
                                                        ),
                                                      ),
                                                    )
                                                  : ClipRRect(
                                                      borderRadius: BorderRadius.circular(50),
                                                      child: formedCachedImage(
                                                        imageUrl: "$IMAGE_PATH_CASTER${listCast[index].profilePath}",
                                                        height: 50,
                                                        width: 50,
                                                        errorWidget: Container(
                                                          height: 50,
                                                          width: 50,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(100),
                                                            color: const Color(0xff545454),
                                                          ),
                                                          child: const Center(
                                                            child: Icon(
                                                              EvaIcons.questionMark,
                                                              size: 25,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                              Container(width: 12),
                                              Flexible(
                                                  child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${listCast[index].originalName}",
                                                    style: kStyleCastName,
                                                  ),
                                                  Text(
                                                    "${listCast[index].knownForDepartment}",
                                                    style: kStyleCastDepartment,
                                                  ),
                                                ],
                                              )),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return const Text("Chưa cập nhật credit phim.");
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: const Color(0xff181818),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Bình luận:",
                            style: kStyleSummaries,
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: const Color(0xff181818),
                        child: BlocBuilder<ReviewMovieBloc, ReviewMovieState>(
                          builder: (context, reviewState) {
                            if (reviewState is ReviewMovieLoading) {
                              return const CupertinoActivityIndicator();
                            } else if (reviewState is ReviewMovieLoaded) {
                              final listReviews = reviewState.listReviews;
                              if (listReviews.isEmpty) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ),
                                  child: Text("Hiện chưa có bình luận nào..."),
                                );
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                addAutomaticKeepAlives: true,
                                itemCount: reviewState.listReviews.length,
                                itemBuilder: (context, index) => Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          listReviews[index].authorDetails?.avatarPath == null
                                              ? Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                                  child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(30),
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                )
                                              : Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(40),
                                                    child: formedCachedImage(
                                                      imageUrl:
                                                          "$IMAGE_PATH_CASTER${listReviews[index].authorDetails?.avatarPath}",
                                                      height: 30,
                                                      width: 30,
                                                    ),
                                                  ),
                                                ),
                                          Container(width: 10),
                                          Text(listReviews[index].authorDetails?.username ?? "Anonymous"),
                                        ],
                                      ),
                                      ReadMoreText(
                                        "${listReviews[index].content}",
                                        trimLines: 5,
                                        colorClickableText: const Color(0xffe21221),
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: "xem thêm",
                                        trimExpandedText: "...rút gọn",
                                        style: kStyleContentReview,
                                      ),
                                      Container(height: 20),
                                      const customDivider(),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const Text("Hiện chưa có bình luận nào...");
                            }
                          },
                        ),
                      ),
                    ),
                    // SliverToBoxAdapter(
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: 0.14.sw),
                    //     child: ClipRRect(
                    //       borderRadius: BorderRadius.circular(24),
                    //       child: Container(
                    //         padding: const EdgeInsets.all(20),
                    //         decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(20),
                    //         ),
                    //         height: 0.5.sh,
                    //         width: 1.sw,
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Container(
                    //               height: 0.6.sw,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(20),
                    //                 boxShadow: [
                    //                   BoxShadow(
                    //                     blurRadius: 10,
                    //                     offset: const Offset(2, 0),
                    //                     spreadRadius: 3,
                    //                     color: Colors.black.withOpacity(0.25),
                    //                   ),
                    //                 ],
                    //               ),
                    //               child: ClipRRect(
                    //                 borderRadius: BorderRadius.circular(20),
                    //                 child: formedCachedImage(
                    //                   imageUrl: "$IMAGE_PATH_BACKDROP_POPULAR${movie.backdropPath ?? movie.posterPath}",
                    //                   isCover: true,
                    //                 ),
                    //               ),
                    //             ),
                    //             const SizedBox(height: 15),
                    //             Text(
                    //               "${movie.title}",
                    //               style: kStyleStickName,
                    //             ),
                    //             const SizedBox(height: 7),
                    //             Row(
                    //               children: [
                    //                 const Icon(
                    //                   Iconsax.clock,
                    //                   size: 15,
                    //                   color: Colors.black,
                    //                 ),
                    //                 Container(width: 4),
                    //                 Flexible(
                    //                   child: Text(
                    //                     "Thời lượng: ${movie.runtime == 0 ? "Chưa rõ" : "${movie.runtime} phút"}",
                    //                     style: const TextStyle(
                    //                       fontSize: 16,
                    //                       color: Colors.black,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             const SizedBox(height: 15),
                    //             BlocBuilder<CastMovieBloc, CastMovieState>(
                    //               builder: (context, state) {
                    //                 if (state is CastMovieLoaded) {
                    //                   final listCast = state.castLoaded.cast!.length > 5
                    //                       ? state.castLoaded.cast!.sublist(0, 5)
                    //                       : state.castLoaded.cast!;
                    //                   return Wrap(
                    //                     spacing: 2,
                    //                     runSpacing: 2,
                    //                     children: listCast!.map((e) {
                    //                       if (e.profilePath == null) {
                    //                         return Container(
                    //                           height: 50,
                    //                           width: 50,
                    //                           decoration: BoxDecoration(
                    //                             borderRadius: BorderRadius.circular(100),
                    //                             color: const Color(0xff545454),
                    //                           ),
                    //                           child: const Center(
                    //                             child: Icon(
                    //                               EvaIcons.questionMark,
                    //                               size: 25,
                    //                             ),
                    //                           ),
                    //                         );
                    //                       }
                    //                       return ClipRRect(
                    //                         borderRadius: BorderRadius.circular(50),
                    //                         child: formedCachedImage(
                    //                           imageUrl: "$IMAGE_PATH_CASTER${e.profilePath}",
                    //                           height: 50,
                    //                           width: 50,
                    //                           errorWidget: Container(
                    //                             height: 50,
                    //                             width: 50,
                    //                             decoration: BoxDecoration(
                    //                               borderRadius: BorderRadius.circular(100),
                    //                               color: const Color(0xff545454),
                    //                             ),
                    //                             child: const Center(
                    //                               child: Icon(
                    //                                 EvaIcons.questionMark,
                    //                                 size: 25,
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       );
                    //                     }).toList(),
                    //                   );
                    //                 }
                    //                 return const SizedBox();
                    //               },
                    //             ),
                    //             const SizedBox(height: 15),
                    //             Row(
                    //               children: [
                    //                 Image.asset(
                    //                   "assets/images/imdb_logo.png",
                    //                   width: 40,
                    //                 ),
                    //                 Text(
                    //                   "  ${movie.voteAverage?.toStringAsFixed(1) ?? 0}/10",
                    //                   style: const TextStyle(
                    //                     fontSize: 16,
                    //                     color: Colors.black,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  bool get wantKeepAlive => true;
}

class customDivider extends StatelessWidget {
  const customDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Color(0xff9e9e9e),
      thickness: 0.1,
      height: 0,
    );
  }
}
