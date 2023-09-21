import 'dart:ui';

import 'package:cinerv/src/blocs/popular_movie/popular_movie_bloc.dart';
import 'package:cinerv/src/commons/formed_cached_network.dart';
import 'package:cinerv/src/constants/path_constants.dart';
import 'package:cinerv/src/constants/style_constants.dart';
import 'package:cinerv/src/ui/home/components/most_view.dart';
import 'package:cinerv/src/ui/home/components/swiper_carousel.dart';
import 'package:cinerv/src/ui/home/components/top_rated.dart';
import 'package:cinerv/src/ui/home/components/up_coming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            SizedBox(
              height: deviceHeight / 2,
              child: BlocBuilder<PopularMovieBloc, PopularMovieState>(
                builder: (context, popularState) {
                  if (popularState is PopularMovieLoaded) {
                    final firstPopular = popularState.popularMovies[3];
                    return FormedCachedImage(
                      imageUrl:
                          "$IMAGE_PATH_BACKDROP${firstPopular.backdropPath ?? firstPopular.posterPath}",
                    );
                  }
                  return Container();
                },
              ),
            ),
            SizedBox(
              height: deviceHeight / 2,
              width: deviceWidth,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
            CustomScrollView(
              primary: false,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverToBoxAdapter(child: Container(height: 60)),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: Text(
                      "Home",
                      style: kStyleDiscover,
                    ),
                  ),
                ),
                const SwiperCarousel(),
                SliverToBoxAdapter(child: Container(height: 20)),
                const MostView(),
                const TopRated(),
                const UpComing(),
                SliverToBoxAdapter(child: Container(height: 100)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
