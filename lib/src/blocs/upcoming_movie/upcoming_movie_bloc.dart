import 'package:bloc/bloc.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:cinerv/src/network/dio_client.dart';
import 'package:cinerv/src/resources/themoviedb_api.dart';
import 'package:equatable/equatable.dart';

part 'upcoming_movie_event.dart';
part 'upcoming_movie_state.dart';

class UpcomingMovieBloc extends Bloc<UpcomingMovieEvent, UpcomingMovieState> {
  UpcomingMovieBloc() : super(UpcomingMovieLoading()) {
    final dio = DioClient();
    final theMovieDBApi = TheMovieDBApi(dio);
    on<GetUpcomingMovie>((event, emit) async {
      emit(UpcomingMovieLoading());
      final upcoming_movies = await theMovieDBApi.getUpcomingMovies();
      emit(UpcomingMovieLoaded(upcoming_movies: upcoming_movies));
    });
  }
}
