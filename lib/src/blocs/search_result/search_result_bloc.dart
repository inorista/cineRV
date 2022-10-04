import 'package:bloc/bloc.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:cinerv/src/network/dio_client.dart';
import 'package:cinerv/src/resources/themoviedb_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'search_result_event.dart';
part 'search_result_state.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  SearchResultBloc() : super(SearchResultInitial()) {
    final _dio = DioClient();
    final _theMovieDBApi = TheMovieDBApi(_dio);
    int _currentPage = 1;
    String _query = "";
    on<SearchMovieByKeyWord>((event, emit) async {
      emit(SearchLoading());
      final listSearchedMovies = await compute(_theMovieDBApi.searchMoviesByKeyword, event.keyword);
      emit(SearchMoviesLoaded(listMoviesLoaded: listSearchedMovies));
      _query = event.keyword;
    });

    on<GetMoreMovieByKeyword>((event, emit) async {
      final state = this.state;
      if (state is SearchMoviesLoaded) {
        _currentPage += 1;

        final Map<String, String> mapQuery = {
          "query": _query,
          "page": _currentPage.toString(),
        };
        final moreMovieLoaded = await compute(_theMovieDBApi.getMoreMoviesByKeyword, mapQuery);
        emit(SearchMoviesLoaded(listMoviesLoaded: List.from(state.listMoviesLoaded)..addAll(moreMovieLoaded)));
      }
    });

    on<ClearSearch>((event, emit) {
      emit(SearchResultInitial());
    });
  }
}
