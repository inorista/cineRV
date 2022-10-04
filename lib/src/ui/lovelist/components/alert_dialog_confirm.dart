import 'dart:ui';
import 'package:cinerv/src/blocs/all_loved_movies/all_loved_movies_bloc.dart';
import 'package:cinerv/src/constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class confirm_box extends StatelessWidget {
  final String content;
  final int movieID;

  const confirm_box({super.key, required this.content, required this.movieID});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        content: Text(
          content,
          style: kStyleContentAlert,
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    autofocus: false,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red.withOpacity(0.85),
                    ),
                    onPressed: () {
                      context.read<AllLovedMoviesBloc>().add(RemoveMovieFromList(movieID: movieID.toString()));
                      Navigator.pop(context);
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                    child: const Text(
                      "Xác Nhận",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    autofocus: false,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red.withOpacity(0.85),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                    child: const Text(
                      "Hủy",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
