part of 'search_result_bloc.dart';

abstract class SearchResultState extends Equatable {
  const SearchResultState();

  @override
  List<Object> get props => [];
}

class SearchResultInitial extends SearchResultState {}

class SearchLoading extends SearchResultState {}

class SearchMoviesLoaded extends SearchResultState {
  final List<Movie> listMoviesLoaded;
  const SearchMoviesLoaded({this.listMoviesLoaded = const <Movie>[]});
  @override
  List<Object> get props => [listMoviesLoaded];
}
