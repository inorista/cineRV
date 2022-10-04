import 'package:card_swiper/card_swiper.dart';
import 'package:cinerv/src/blocs/popular_movie/popular_movie_bloc.dart';
import 'package:cinerv/src/ui/home/components/swiper_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class swiper_carousel extends StatelessWidget {
  const swiper_carousel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return SliverToBoxAdapter(
      child: BlocBuilder<PopularMovieBloc, PopularMovieState>(
        builder: (context, popularState) {
          if (popularState is PopularMovieLoaded) {
            final listPopular = popularState.popularMovies;
            return SizedBox(
              width: double.infinity,
              height: deviceHeight / 2.5,
              child: Swiper(
                onIndexChanged: (value) {
                  HapticFeedback.vibrate();
                },
                index: 0,
                loop: false,
                scale: 0.95,
                viewportFraction: 0.9,
                layout: SwiperLayout.DEFAULT,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                duration: 200,
                itemBuilder: (BuildContext context, int index) {
                  return swiper_item(moviePopular: listPopular[index]);
                },
                itemCount: listPopular.length,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
