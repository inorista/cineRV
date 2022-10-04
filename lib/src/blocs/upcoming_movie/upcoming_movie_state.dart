part of 'upcoming_movie_bloc.dart';

abstract class UpcomingMovieState extends Equatable {
  const UpcomingMovieState();

  @override
  List<Object> get props => [];
}

class UpcomingMovieLoading extends UpcomingMovieState {}

class UpcomingMovieLoaded extends UpcomingMovieState {
  final List<Movie> upcoming_movies;
  const UpcomingMovieLoaded({required this.upcoming_movies});

  @override
  List<Object> get props => [upcoming_movies];
}
