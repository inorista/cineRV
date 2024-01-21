import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinerv/src/blocs/popular_movie/popular_movie_bloc.dart';
import 'package:cinerv/src/blocs/search_field/search_field_bloc.dart';
import 'package:cinerv/src/blocs/search_history/search_history_bloc.dart';
import 'package:cinerv/src/blocs/search_result/search_result_bloc.dart';
import 'package:cinerv/src/commons/formedCachedNetwork.dart';
import 'package:cinerv/src/commons/listview_poster_with_backdrop.dart';
import 'package:cinerv/src/commons/search_textfield.dart';
import 'package:cinerv/src/constants/path_constants.dart';
import 'package:cinerv/src/constants/style_constants.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector(
        onTap: () async {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Stack(
          children: [
            BlocBuilder<PopularMovieBloc, PopularMovieState>(
              builder: (context, popularState) {
                if (popularState is PopularMovieLoaded) {
                  final backdrop_blur_movie = popularState.popularMovies[1];
                  return SizedBox(
                    height: deviceHeight / 5,
                    width: deviceWidth,
                    child: formedCachedImage(
                      imageUrl:
                          "$IMAGE_PATH_BACKDROP${backdrop_blur_movie.backdropPath ?? backdrop_blur_movie.posterPath}",
                      errorWidget: Container(),
                    ),
                  );
                }
                return Container(
                  height: deviceHeight / 5,
                  width: deviceWidth,
                  color: Colors.white24,
                );
              },
            ),
            SizedBox(
              height: deviceHeight / 5,
              width: deviceWidth,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 30,
                  sigmaY: 30,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0),
                ),
              ),
            ),
            NotificationListener<ScrollEndNotification>(
              onNotification: (scrollEnd) {
                final metrics = scrollEnd.metrics;
                if (metrics.atEdge) {
                  bool isBottom = metrics.pixels == 0;

                  if (!isBottom) {
                    context.read<SearchResultBloc>()..add(const GetMoreMovieByKeyword());
                  }
                }
                return true;
              },
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  SliverAppBar(
                    elevation: 0,
                    leadingWidth: 50,
                    automaticallyImplyLeading: true,
                    toolbarHeight: 80,
                    backgroundColor: Colors.transparent,
                    pinned: true,
                    leading: GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        context.read<SearchResultBloc>().add(ClearSearch());
                        context.read<SearchFieldBloc>().add(ClearSearchField());
                      },
                      child: const Icon(
                        EvaIcons.arrowBack,
                        size: 30,
                      ),
                    ),
                    actions: [
                      SizedBox(
                        height: 80,
                        width: deviceWidth / 1.1,
                        child: const search_textfield(),
                      )
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: BlocBuilder<SearchResultBloc, SearchResultState>(
                        builder: (context, searchState) {
                          if (searchState is SearchMoviesLoaded) {
                            final listAllMovies = searchState.listMoviesLoaded;
                            if (listAllMovies.isEmpty) {
                              return const Center(
                                child: Text("Không có kết quả cho từ khóa trên"),
                              );
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    "Các kết quả trùng khớp",
                                    style: kStyleLoveListTitle,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                listview_poster_with_backdrop(listMovieData: listAllMovies),
                              ],
                            );
                          } else if (searchState is SearchResultInitial) {
                            return BlocBuilder<SearchHistoryBloc, SearchHistoryState>(
                              builder: (context, searchState) {
                                if (searchState is SearchHistoryLoaded) {
                                  final listHistory = searchState.searchHistory;
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Tìm kiếm gần đây",
                                              style: kStyleFeature,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                context.read<SearchHistoryBloc>().add(ClearSearchHistory());
                                              },
                                              child: const Icon(
                                                EvaIcons.trash2,
                                                size: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: Wrap(
                                          children: [
                                            ...List.generate(
                                              listHistory.length,
                                              (index) => GestureDetector(
                                                onTap: () async {
                                                  context
                                                      .read<SearchResultBloc>()
                                                      .add(SearchMovieByKeyWord(keyword: listHistory[index]));
                                                  context
                                                      .read<SearchFieldBloc>()
                                                      .add(SearchByHistoryKeyword(keyword: listHistory[index]));
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xff545454),
                                                      borderRadius: BorderRadius.circular(5),
                                                    ),
                                                    child: Text(
                                                      "${listHistory[index]}",
                                                      style: kStyeHistoryItem,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return const SizedBox();
                              },
                            );
                          } else {
                            return const Center(
                              child: CupertinoActivityIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
