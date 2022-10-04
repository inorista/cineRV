part of 'search_result_bloc.dart';

abstract class SearchResultEvent extends Equatable {
  const SearchResultEvent();

  @override
  List<Object> get props => [];
}

class SearchMovieByKeyWord extends SearchResultEvent {
  final String keyword;
  const SearchMovieByKeyWord({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class GetMoreMovieByKeyword extends SearchResultEvent {
  const GetMoreMovieByKeyword();

  @override
  List<Object> get props => [];
}

class ClearSearch extends SearchResultEvent {}
