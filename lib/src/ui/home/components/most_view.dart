import 'package:cinerv/src/blocs/trending_movie/trending_movie_bloc.dart';
import 'package:cinerv/src/commons/listview_movies.dart';
import 'package:cinerv/src/commons/page_transition.dart';
import 'package:cinerv/src/constants/style_constants.dart';
import 'package:cinerv/src/ui/detail_category/detail_category_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class most_view extends StatelessWidget {
  const most_view({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: const Color(0xff181818),
        width: double.infinity,
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Lượt Xem Khủng Nhât",
                    style: kStyleCategoryTitle,
                  ),
                  BlocBuilder<TrendingMovieBloc, TrendingMovieState>(
                    builder: (context, state) {
                      if (state is TrendingMovieLoaded) {
                        final listTrendingMovie = state.movies_loaded;

                        return GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => DetailCategoryScreen(
                                  movieFromCategory: listTrendingMovie,
                                  title: "Top 20 Lượt Xem Khủng Nhât",
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Xem tất cả",
                            style: kStyleSeeAll,
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<TrendingMovieBloc, TrendingMovieState>(
                builder: (context, state) {
                  if (state is TrendingMovieLoading) {
                    return const Center(child: CupertinoActivityIndicator());
                  } else if (state is TrendingMovieLoaded) {
                    final listTrendingMovies = state.movies_loaded;
                    return listview_movie(listMovies: listTrendingMovies);
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
