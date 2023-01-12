// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:cinerv/src/network/dio_client.dart';
import 'package:cinerv/src/resources/themoviedb_api.dart';
import 'package:equatable/equatable.dart';

part 'detail_genre_event.dart';
part 'detail_genre_state.dart';

class DetailGenreBloc extends Bloc<DetailGenreEvent, DetailGenreState> {
  DetailGenreBloc() : super(DetailGenreLoading()) {
    var currentPage = 1;
    final dio = DioClient();
    final theMovieDBApi = TheMovieDBApi(dio);
    on<GetMovieByGenre>((event, emit) async {
      emit(DetailGenreLoading());
      final moviesByGenre = await theMovieDBApi.getMoviesByGenre(event.genreID);
      emit(DetailGenreLoaded(moviesGenre: moviesByGenre));
    });

    on<GetMoreMovieByGenre>((event, emit) async {
      final state = this.state;
      if (state is DetailGenreLoaded) {
        currentPage += 1;
        final moviesByGenre = await theMovieDBApi.getMoviesByGenre(event.genreID, page: currentPage);
        emit(
          DetailGenreLoaded(
            moviesGenre: List.from(state.moviesGenre)..addAll(moviesByGenre),
          ),
        );
      }
    });
  }
}
