import 'package:cinerv/src/blocs/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:cinerv/src/commons/listview_movies.dart';
import 'package:cinerv/src/commons/page_transition.dart';
import 'package:cinerv/src/constants/style_constants.dart';
import 'package:cinerv/src/ui/detail_category/detail_category_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class top_rated extends StatelessWidget {
  const top_rated({
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
                    "Đánh Giá Cao Nhất",
                    style: kStyleCategoryTitle,
                  ),
                  BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
                    builder: (context, state) {
                      if (state is TopRatedMovieLoaded) {
                        final listTopRatedMovie = state.topRated_movies;

                        return GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              SlideRoute(
                                page: DetailCategoryScreen(
                                  movieFromCategory: listTopRatedMovie,
                                  title: "Phim Có Đánh Giá Cao Nhất",
                                ),
                                x: 0,
                                y: 1,
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
              child: BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
                builder: (context, state) {
                  if (state is TopRatedMovieLoading) {
                    return const Center(child: CupertinoActivityIndicator());
                  } else if (state is TopRatedMovieLoaded) {
                    final listTopRatedMovies = state.topRated_movies;
                    return listview_movie(listMovies: listTopRatedMovies);
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
