import 'package:bloc/bloc.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:cinerv/src/network/dio_client.dart';
import 'package:cinerv/src/resources/themoviedb_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  DetailMovieBloc() : super(DetailMovieLoading()) {
    final _dio = DioClient();
    final _theMovieDBApi = TheMovieDBApi(_dio);
    on<GetDetailMovie>((event, emit) async {
      emit(DetailMovieLoading());
      final movie = await compute(_theMovieDBApi.getDetailMovieByID, event.movieID);
      emit(DetailMovieLoaded(movie: movie));
    });
  }
}
