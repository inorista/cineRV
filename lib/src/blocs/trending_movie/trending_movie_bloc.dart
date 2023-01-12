import 'package:bloc/bloc.dart';

import 'package:cinerv/src/network/dio_client.dart';
import 'package:cinerv/src/resources/themoviedb_api.dart';
import 'package:equatable/equatable.dart';

import '../../models/movie.dart';

part 'trending_movie_event.dart';
part 'trending_movie_state.dart';

class TrendingMovieBloc extends Bloc<TrendingMovieEvent, TrendingMovieState> {

  TrendingMovieBloc() : super(TrendingMovieLoading()) {
    final dio = DioClient();
    final theMovieDBApi = TheMovieDBApi(dio);
    on<GetTrendingMovies>((event, emit) async {
      emit(TrendingMovieLoading());
      final movies = await theMovieDBApi.getTrendingMovies();
      emit(TrendingMovieLoaded(movies_loaded: movies));
    });
  }
}
