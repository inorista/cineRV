import 'package:bloc/bloc.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:cinerv/src/network/dio_client.dart';
import 'package:cinerv/src/resources/themoviedb_api.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  TopRatedMovieBloc() : super(TopRatedMovieLoading()) {
    final dio = DioClient();
    final theMovieDBApi = TheMovieDBApi(dio);
    on<GetTopRatedMovies>((event, emit) async {
      emit(TopRatedMovieLoading());
      final topRated_movies = await theMovieDBApi.getTopRatedMovies();
      emit(TopRatedMovieLoaded(topRated_movies: topRated_movies));
    });
  }
}
