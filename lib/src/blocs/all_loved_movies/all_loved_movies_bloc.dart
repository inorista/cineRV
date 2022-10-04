import 'package:bloc/bloc.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:cinerv/src/network/dio_client.dart';
import 'package:cinerv/src/resources/themoviedb_api.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'all_loved_movies_event.dart';
part 'all_loved_movies_state.dart';

class AllLovedMoviesBloc extends Bloc<AllLovedMoviesEvent, AllLovedMoviesState> {
  AllLovedMoviesBloc() : super(AllLovedMoviesLoading()) {
    final _dio = DioClient();
    final _theMovieDBApi = TheMovieDBApi(_dio);

    on<GetAllLovedMovies>((event, emit) async {
      emit(AllLovedMoviesLoading());
      final prefs = await SharedPreferences.getInstance();
      final listAllLovedFromLocal = await prefs.getStringList("lovelist");

      if (listAllLovedFromLocal!.isNotEmpty) {
        final movie = await _theMovieDBApi.getAllLovedMovieByID(listAllLovedFromLocal);
        emit(AllLovedMoviesLoaded(listAllLovedMovies: movie));
      } else {
        emit(const AllLovedMoviesLoaded(listAllLovedMovies: []));
      }
    });

    on<RemoveMovieFromList>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();

      final movieID = event.movieID;
      final state = this.state;
      if (state is AllLovedMoviesLoaded) {
        final indexMovieFromList = state.listAllLovedMovies.indexWhere((elm) => elm.id.toString() == movieID);
        final oldListLovedMovie = prefs.getStringList("lovelist");
        final newListLovedMovie = oldListLovedMovie!..remove(movieID);
        prefs.setStringList("lovelist", newListLovedMovie);
        emit(
          AllLovedMoviesLoaded(
            listAllLovedMovies: List.from(state.listAllLovedMovies)..removeAt(indexMovieFromList),
          ),
        );
      }
    });

    on<AddMovieToList>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final movieID = event.movieID;
      final state = this.state;
      if (state is AllLovedMoviesLoaded) {
        final getMovie = await _theMovieDBApi.getDetailMovieByID(int.parse(movieID));
        final oldListLovedMovie = await prefs.getStringList("lovelist");
        final newListLovedMovie = oldListLovedMovie!..add(getMovie.id.toString());
        prefs.setStringList("lovelist", newListLovedMovie);
        emit(
          AllLovedMoviesLoaded(
            listAllLovedMovies: List.from(state.listAllLovedMovies)..add(getMovie),
          ),
        );
      }
    });
  }
}
