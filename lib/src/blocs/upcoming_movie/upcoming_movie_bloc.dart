import 'package:bloc/bloc.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:cinerv/src/network/dio_client.dart';
import 'package:cinerv/src/resources/themoviedb_api.dart';
import 'package:equatable/equatable.dart';

part 'upcoming_movie_event.dart';
part 'upcoming_movie_state.dart';

class UpcomingMovieBloc extends Bloc<UpcomingMovieEvent, UpcomingMovieState> {
  UpcomingMovieBloc() : super(UpcomingMovieLoading()) {
    final _dio = DioClient();
    final _theMovieDBApi = TheMovieDBApi(_dio);
    on<GetUpcomingMovie>((event, emit) async {
      emit(UpcomingMovieLoading());
      final upComingMovies = await _theMovieDBApi.getUpcomingMovies();
      emit(UpcomingMovieLoaded(upComingMovies: upComingMovies));
    });
  }
}
