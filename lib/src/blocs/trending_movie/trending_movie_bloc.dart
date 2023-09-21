import 'package:bloc/bloc.dart';

import 'package:cinerv/src/network/dio_client.dart';
import 'package:cinerv/src/resources/themoviedb_api.dart';
import 'package:equatable/equatable.dart';

import '../../models/movie.dart';

part 'trending_movie_event.dart';
part 'trending_movie_state.dart';

class TrendingMovieBloc extends Bloc<TrendingMovieEvent, TrendingMovieState> {
  var _currentPage = 1;

  TrendingMovieBloc() : super(TrendingMovieLoading()) {
    final _dio = DioClient();
    final _theMovieDBApi = TheMovieDBApi(_dio);
    on<GetTrendingMovies>((event, emit) async {
      emit(TrendingMovieLoading());
      final movies = await _theMovieDBApi.getTrendingMovies();
      emit(TrendingMovieLoaded(moviesLoaded: movies));
    });
  }
}
