// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinerv/src/constants/path_constants.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:flutter/material.dart';

class HeaderPersistent extends SliverPersistentHeaderDelegate {
  double minimumExtent;
  double maximumExtent;
  final Movie movie;
  HeaderPersistent({
    this.minimumExtent = 50,
    this.maximumExtent = 320,
    required this.movie,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = (shrinkOffset / maximumExtent).clamp(0.1, 1);

    var opacity = ((minimumExtent / shrinkOffset / 2)) < 0.135
        ? 0
        : ((minimumExtent / shrinkOffset / 2)).clamp(0, 1);

    var opacityColor = (shrinkOffset / maximumExtent).toDouble() < 0.8
        ? 0
        : (shrinkOffset / maximumExtent).clamp(0.7, 1) > 0.85
            ? 1
            : (shrinkOffset / maximumExtent).clamp(0.7, 1);

    var opacityTitle = (shrinkOffset / maximumExtent).toDouble() < 0.75
        ? 0
        : (shrinkOffset / maximumExtent).clamp(0.75, 1);

    return SafeArea(
      child: Container(
        color: const Color(0xff594e3f).withOpacity(opacityColor.toDouble()),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 10),
                opacity: opacityTitle.toDouble(),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: const Center(
                    child: Text(
                      "Bộ phim ưu thích của bạn",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: AnimatedOpacity(
                  opacity: opacity.toDouble(),
                  duration: const Duration(milliseconds: 0),
                  child: Container(
                    height: maximumExtent * (1 - percent),
                    width: maximumExtent * (1 - percent),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 7,
                          blurRadius: 10,
                          offset:
                              const Offset(4, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: CachedNetworkImage(
                      imageUrl: "$IMAGE_PATH_POSTER${movie.posterPath}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => maximumExtent;

  @override
  double get minExtent => minimumExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
