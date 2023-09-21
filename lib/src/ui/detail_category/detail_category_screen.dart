import 'package:cinerv/src/commons/listview_poster_with_backdrop.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class DetailCategoryScreen extends StatelessWidget {
  const DetailCategoryScreen({
    required this.movieFromCategory,
    required this.title,
    super.key,
  });
  final List<Movie> movieFromCategory;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        title: Text(title),
        leading: GestureDetector(
          onTap: () async {
            Navigator.pop(context);
          },
          child: const Icon(
            EvaIcons.arrowIosBack,
            size: 25,
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: ListViewPosterWithBackdrop(listMovieData: movieFromCategory),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
