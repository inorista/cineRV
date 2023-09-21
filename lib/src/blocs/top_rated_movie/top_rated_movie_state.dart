part of 'top_rated_movie_bloc.dart';

abstract class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  @override
  List<Object> get props => [];
}

class TopRatedMovieLoading extends TopRatedMovieState {}

class TopRatedMovieLoaded extends TopRatedMovieState {
  final List<Movie> topRatedMovies;
  const TopRatedMovieLoaded({required this.topRatedMovies});
  @override
  List<Object> get props => [topRatedMovies];
}
