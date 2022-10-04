import 'dart:ui';

import 'package:cinerv/src/blocs/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:cinerv/src/constants/path_constants.dart';
import 'package:cinerv/src/ui/discover/components/discover_view.dart';
import 'package:cinerv/src/commons/formedCachedNetwork.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () async {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Stack(
          children: [
            BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
              buildWhen: (previous, current) {
                return previous != current;
              },
              builder: (context, topRatedState) {
                if (topRatedState is TopRatedMovieLoading) {
                  return const CupertinoActivityIndicator();
                } else if (topRatedState is TopRatedMovieLoaded) {
                  final backdrop_blur_movie = topRatedState.topRated_movies[0];
                  return Positioned(
                    top: 0,
                    child: SizedBox(
                      height: deviceHeight / 2,
                      width: deviceWidth,
                      child: formedCachedImage(
                        imageUrl:
                            "$IMAGE_PATH_BACKDROP${backdrop_blur_movie.backdropPath ?? backdrop_blur_movie.posterPath}",
                        errorWidget: Container(),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
            Positioned(
              top: 0,
              child: SizedBox(
                height: deviceHeight / 1.85,
                width: deviceWidth,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 20,
                    sigmaY: 20,
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0.05),
                  ),
                ),
              ),
            ),
            const discover_view(),
          ],
        ),
      ),
    );
  }
}
