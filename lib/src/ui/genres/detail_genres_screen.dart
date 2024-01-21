import 'dart:ui';
import 'package:screenshot/screenshot.dart';
import 'package:cinerv/src/blocs/detail_genre/detail_genre_bloc.dart';
import 'package:cinerv/src/commons/grid_poster.dart';
import 'package:cinerv/src/commons/gridview_movie.dart';
import 'package:cinerv/src/commons/listview_movies.dart';
import 'package:cinerv/src/constants/style_constants.dart';
import 'package:cinerv/src/models/genre.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../commons/listview_poster_with_backdrop.dart';

class DetailGenresScreen extends StatelessWidget {
  const DetailGenresScreen({
    super.key,
    required this.genre,
    required this.backdrop_image,
  });
  final Genre genre;
  final String backdrop_image;
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () async {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: SizedBox(
                height: deviceHeight / 3,
                width: deviceWidth,
                child: Image.asset(
                  backdrop_image,
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
                    sigmaX: 20,
                    sigmaY: 20,
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              ),
            ),
            NotificationListener<ScrollEndNotification>(
              onNotification: (scrollEnd) {
                final metrics = scrollEnd.metrics;
                if (metrics.atEdge) {
                  bool isBottom = metrics.pixels == 0;

                  if (!isBottom) {
                    context.read<DetailGenreBloc>().add(
                          GetMoreMovieByGenre(
                            genreID: genre.id.toString(),
                          ),
                        );
                  }
                }
                return true;
              },
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        EvaIcons.arrowBack,
                        size: 30,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "${genre.name}",
                            style: kStyleDiscover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverFillRemaining(
                    child: BlocBuilder<DetailGenreBloc, DetailGenreState>(
                      builder: (context, state) {
                        if (state is DetailGenreLoaded) {
                          final listDetailGenreMovie = state.moviesGenre;
                          return listview_poster_with_backdrop(listMovieData: listDetailGenreMovie);
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
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
