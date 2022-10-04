import 'package:cinerv/src/blocs/detail_genre/detail_genre_bloc.dart';
import 'package:cinerv/src/commons/page_transition.dart';
import 'package:cinerv/src/constants/genre_constants.dart';
import 'package:cinerv/src/constants/style_constants.dart';
import 'package:cinerv/src/models/genre.dart';
import 'package:cinerv/src/ui/genres/detail_genres_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class listview_genres extends StatelessWidget {
  const listview_genres({
    Key? key,
    required this.listAllGenres,
  }) : super(key: key);

  final List<Genre> listAllGenres;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      addAutomaticKeepAlives: true,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listAllGenres.length,
      itemBuilder: (context, index) {
        final image_path_genre = getStringGenre(listAllGenres[index].name!);
        return GestureDetector(
          onTap: () async {
            context.read<DetailGenreBloc>()
              ..add(
                GetMovieByGenre(
                  genreID: listAllGenres[index].id.toString(),
                ),
              );
            Navigator.push(
              context,
              SlideRoute(
                page: DetailGenresScreen(genre: listAllGenres[index], backdrop_image: image_path_genre.toString()),
                x: 1,
                y: 0,
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: deviceWidth * 0.14,
                  width: deviceWidth * 0.14,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      image_path_genre,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(width: 20),
                Text(
                  "${listAllGenres[index].name}",
                  style: kStyleGenreName,
                ),
                const Spacer(),
                const Icon(
                  EvaIcons.arrowIosForward,
                  size: 25,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
