import 'package:bloc/bloc.dart';
import 'package:cinerv/src/models/genre.dart';
import 'package:cinerv/src/network/dio_client.dart';
import 'package:cinerv/src/resources/themoviedb_api.dart';
import 'package:equatable/equatable.dart';

part 'genres_discover_event.dart';
part 'genres_discover_state.dart';

class GenresDiscoverBloc extends Bloc<GenresDiscoverEvent, GenresDiscoverState> {
  GenresDiscoverBloc() : super(GenresDiscoverLoading()) {
    final _dio = DioClient();
    final _theMovieDBApi = TheMovieDBApi(_dio);
    on<GetAllGenres>((event, emit) async {
      final getListGenres = await _theMovieDBApi.getAllGenresMovie();
      emit(GenreDiscoverLoaded(getListGenres));
    });
  }
}
