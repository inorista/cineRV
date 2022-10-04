import 'package:bloc/bloc.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:cinerv/src/network/dio_client.dart';
import 'package:cinerv/src/resources/themoviedb_api.dart';
import 'package:equatable/equatable.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  PopularMovieBloc() : super(PopularMovieLoading()) {
    final _dio = DioClient();
    final _theMovieDBApi = TheMovieDBApi(_dio);
    on<GetPopularMovie>((event, emit) async {
      emit(PopularMovieLoading());
      final popularMoviesLoaded = await _theMovieDBApi.getPopularMovie();
      emit(PopularMovieLoaded(popularMovies: popularMoviesLoaded));
    });
  }
}
