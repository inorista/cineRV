part of 'trending_movie_bloc.dart';

abstract class TrendingMovieEvent extends Equatable {
  const TrendingMovieEvent();

  @override
  List<Object> get props => [];
}

class GetTrendingMovies extends TrendingMovieEvent {
  const GetTrendingMovies();

  @override
  List<Object> get props => [];
}
