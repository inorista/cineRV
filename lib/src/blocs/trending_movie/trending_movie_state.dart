part of 'trending_movie_bloc.dart';

abstract class TrendingMovieState extends Equatable {
  const TrendingMovieState();

  @override
  List<Object> get props => [];
}

class TrendingMovieLoading extends TrendingMovieState {}

class TrendingMovieLoaded extends TrendingMovieState {
  final List<Movie> moviesLoaded;
  const TrendingMovieLoaded({this.moviesLoaded = const <Movie>[]});

  @override
  List<Object> get props => [moviesLoaded];
}
