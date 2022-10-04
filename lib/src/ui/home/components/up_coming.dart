import 'package:cinerv/src/blocs/upcoming_movie/upcoming_movie_bloc.dart';
import 'package:cinerv/src/commons/listview_movies.dart';
import 'package:cinerv/src/commons/page_transition.dart';
import 'package:cinerv/src/constants/style_constants.dart';
import 'package:cinerv/src/ui/detail_category/detail_category_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class up_coming extends StatelessWidget {
  const up_coming({
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
              padding: const EdgeInsets.only(left: 18, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Ra Mắt Trong Thời Gian Tới",
                    style: kStyleCategoryTitle,
                  ),
                  BlocBuilder<UpcomingMovieBloc, UpcomingMovieState>(
                    builder: (context, state) {
                      if (state is UpcomingMovieLoaded) {
                        final lisUpcomingMovie = state.upcoming_movies;

                        return GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              SlideRoute(
                                page: DetailCategoryScreen(
                                  movieFromCategory: lisUpcomingMovie,
                                  title: "Ra Mắt Trong Thời Gian Tới",
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
              child: BlocBuilder<UpcomingMovieBloc, UpcomingMovieState>(
                builder: (context, state) {
                  if (state is UpcomingMovieLoading) {
                    return const Center(child: CupertinoActivityIndicator());
                  } else if (state is UpcomingMovieLoaded) {
                    final listUpcomingMovies = state.upcoming_movies;
                    return listview_movie(listMovies: listUpcomingMovies);
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
