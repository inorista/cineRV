part of 'all_loved_movies_bloc.dart';

abstract class AllLovedMoviesState extends Equatable {
  const AllLovedMoviesState();

  @override
  List<Object> get props => [];
}

class AllLovedMoviesInitial extends AllLovedMoviesState {}

class AllLovedMoviesLoading extends AllLovedMoviesState {}

class AllLovedMoviesLoaded extends AllLovedMoviesState {
  final List<Movie> listAllLovedMovies;
  const AllLovedMoviesLoaded({this.listAllLovedMovies = const <Movie>[]});

  @override
  List<Object> get props => [listAllLovedMovies];
}
