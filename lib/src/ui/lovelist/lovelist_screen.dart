import 'dart:math';

import 'package:cinerv/src/blocs/all_loved_movies/all_loved_movies_bloc.dart';
import 'package:cinerv/src/commons/listview_poster_with_backdrop.dart';
import 'package:cinerv/src/commons/sliver_persistent.dart';
import 'package:cinerv/src/constants/path_constants.dart';
import 'package:cinerv/src/constants/style_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension ColorExtension on String {
  toColor(String opacity) {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = opacity + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

class LoveListScreen extends StatelessWidget {
  const LoveListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;

    Future<List<String>> getAllMovieID() async {
      final prefs = await SharedPreferences.getInstance();
      final listStringMovieID = prefs.getStringList('lovelist');
      context
          .read<AllLovedMoviesBloc>()
          .add(GetAllLovedMovies(listStringID: listStringMovieID ?? []));
      return listStringMovieID ?? [];
    }

    final futureGetID = getAllMovieID();

    return Scaffold(
      extendBodyBehindAppBar: false,
      extendBody: true,
      body: SafeArea(
        child: Container(
          height: deviceHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                "594e3f".toColor("FF"),
                "594e3f".toColor("CC"),
                "594e3f".toColor("4D"),
                "594e3f".toColor("33"),
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
              ],
            ),
          ),
          child: FutureBuilder(
            future: futureGetID,
            builder: (context, snapshot) {
              Random rd = Random();
              if (!snapshot.hasData) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              return BlocBuilder<AllLovedMoviesBloc, AllLovedMoviesState>(
                builder: (context, movieState) {
                  if (movieState is AllLovedMoviesLoaded) {
                    final listMovieData = movieState.listAllLovedMovies;
                    final rdItem = listMovieData.isEmpty
                        ? null
                        : listMovieData[rd.nextInt(listMovieData.length)];
                    if (listMovieData.isEmpty) {
                      return SizedBox(
                        height: deviceHeight,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "${ASSET_IMAGE_PATH}icon.png",
                                scale: 3,
                              ),
                              Container(height: 20),
                              const Text(
                                "Mục ưu thích của bạn đang rỗng.",
                                style: kStyleEmpty,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return CustomScrollView(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        slivers: [
                          SliverPersistentHeader(
                            floating: false,
                            pinned: true,
                            delegate: HeaderPersistent(
                              movie: rdItem!,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bộ phim ưu thích của bạn",
                                    style: kStyleLoveListTitle,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Bao gồm ${listMovieData.length} bộ phim",
                                    style: kStyleTotalLovedMovie,
                                  ),
                                  const SizedBox(height: 5),
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Container(
                              color: const Color(0xff181818),
                              child: ListViewPosterWithBackdrop(
                                listMovieData: listMovieData,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }
                  return Container();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
