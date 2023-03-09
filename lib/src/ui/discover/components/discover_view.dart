import 'package:cinerv/src/blocs/genres_discover/genres_discover_bloc.dart';
import 'package:cinerv/src/blocs/search_result/search_result_bloc.dart';
import 'package:cinerv/src/commons/page_transition.dart';
import 'package:cinerv/src/constants/style_constants.dart';
import 'package:cinerv/src/commons/listview_genres.dart';
import 'package:cinerv/src/ui/search/search_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class discover_view extends StatelessWidget {
  const discover_view({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollEnd) {
        final metrics = scrollEnd.metrics;
        if (metrics.atEdge) {
          bool isBottom = metrics.pixels == 0;

          if (!isBottom) {
            context.read<SearchResultBloc>().add(const GetMoreMovieByKeyword());
          }
        }
        return true;
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80, bottom: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Khám Phá",
                          style: kStyleDiscover,
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => const SearchScreen()));
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color(0xff414141),
                            ),
                            child: const Center(
                              child: Icon(
                                EvaIcons.search,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              constraints: BoxConstraints(minHeight: deviceHeight),
              child: BlocConsumer<GenresDiscoverBloc, GenresDiscoverState>(
                listenWhen: (previous, current) {
                  if (previous != current) {
                    return true;
                  }
                  return false;
                },
                listener: (context, state) {},
                buildWhen: (previous, current) {
                  return previous != current;
                },
                builder: (context, genreState) {
                  if (genreState is GenresDiscoverLoading) {
                    return const CupertinoActivityIndicator();
                  }
                  if (genreState is GenreDiscoverLoaded) {
                    final listAllGenres = genreState.listGenres;
                    return listview_genres(listAllGenres: listAllGenres);
                  }

                  return Container();
                },
              ),
            ),
          ),
          SliverToBoxAdapter(child: Container(height: 100)),
        ],
      ),
    );
  }
}
