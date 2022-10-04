part of 'trending_movie_bloc.dart';

abstract class TrendingMovieState extends Equatable {
  const TrendingMovieState();

  @override
  List<Object> get props => [];
}

class TrendingMovieLoading extends TrendingMovieState {}

class TrendingMovieLoaded extends TrendingMovieState {
  final List<Movie> movies_loaded;
  const TrendingMovieLoaded({this.movies_loaded = const <Movie>[]});

  @override
  List<Object> get props => [movies_loaded];
}
