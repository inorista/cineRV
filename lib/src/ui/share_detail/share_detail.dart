import 'dart:io';
import 'dart:ui';

import 'package:cinerv/src/blocs/cast_movie/cast_movie_bloc.dart';
import 'package:cinerv/src/commons/formedCachedNetwork.dart';
import 'package:cinerv/src/constants/path_constants.dart';
import 'package:cinerv/src/constants/style_constants.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class ShareDetailScreen extends StatelessWidget {
  final Movie movie;
  const ShareDetailScreen({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    final controller1 = ScreenshotController();
    final controller2 = ScreenshotController();
    return Scaffold(
      body: GestureDetector(
        onTap: () async {
          await shareToInsta(movie, controller1, controller2);
        },
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Screenshot(
                controller: controller1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: formedCachedImage(
                        imageUrl: "$IMAGE_PATH_BACKDROP_POPULAR${movie.backdropPath ?? movie.posterPath}",
                      ),
                    ),
                    Positioned.fill(
                      child: SizedBox(
                        height: 1.sh,
                        width: 1.sw,
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                            child: Container(
                              color: Colors.white.withOpacity(
                                0.01,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Screenshot(
                controller: controller2,
                key: Key(movie.id.toString()),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.14.sw),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 1.sw,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 0.7.sw,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  offset: const Offset(2, 0),
                                  spreadRadius: 3,
                                  color: Colors.black.withOpacity(0.25),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: formedCachedImage(
                                imageUrl: "$IMAGE_PATH_BACKDROP_POPULAR${movie.posterPath ?? movie.backdropPath}",
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "${movie.title}",
                            style: kStyleStickName,
                          ),
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              const Icon(
                                Iconsax.clock,
                                size: 15,
                                color: Colors.black,
                              ),
                              Container(width: 4),
                              Flexible(
                                child: Text(
                                  "Thời lượng: ${movie.runtime == 0 ? "Chưa rõ" : "${movie.runtime} phút"}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          BlocBuilder<CastMovieBloc, CastMovieState>(
                            builder: (context, state) {
                              if (state is CastMovieLoaded) {
                                final listCast = state.castLoaded.cast!.length > 5
                                    ? state.castLoaded.cast!.sublist(0, 5)
                                    : state.castLoaded.cast!;
                                return Wrap(
                                  spacing: 3,
                                  runSpacing: 3,
                                  children: listCast.map((e) {
                                    if (e.profilePath == null) {
                                      return Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: const Color(0xff545454),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            EvaIcons.questionMark,
                                            size: 25,
                                          ),
                                        ),
                                      );
                                    }
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: formedCachedImage(
                                        imageUrl: "$IMAGE_PATH_CASTER${e.profilePath}",
                                        height: 40,
                                        width: 40,
                                        errorWidget: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: const Color(0xff545454),
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              EvaIcons.questionMark,
                                              size: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/imdb_logo.png",
                                width: 40,
                              ),
                              Text(
                                "  ${movie.voteAverage?.toStringAsFixed(1) ?? 0}/10",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> shareToInsta(Movie movie, ScreenshotController controller1, ScreenshotController controller2) async {
    const channel = MethodChannel('cineRV/share');
    final tempDir = await getTemporaryDirectory();
    final backgroundFile = await File('${tempDir.path}/${movie.id}_bg.jpg').create(recursive: true);
    final stickFile = await File('${tempDir.path}/${movie.id}_stick.jpg').create(recursive: true);

    await controller1.capture().then((value) {
      if (value != null) {
        backgroundFile.writeAsBytesSync(value);
      }
    });

    await controller2.capture().then((value) {
      if (value != null) {
        stickFile.writeAsBytesSync(value);
      }
    });

    final Map<String, dynamic> data = {
      "backgroundPath": "${movie.id}_bg.jpg",
      "imagePath": "${movie.id}_stick.jpg",
    };

    channel.invokeMethod('shareFile', data);
  }
}
