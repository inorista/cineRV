part of 'upcoming_movie_bloc.dart';

abstract class UpcomingMovieState extends Equatable {
  const UpcomingMovieState();

  @override
  List<Object> get props => [];
}

class UpcomingMovieLoading extends UpcomingMovieState {}

class UpcomingMovieLoaded extends UpcomingMovieState {
  final List<Movie> upComingMovies;
  const UpcomingMovieLoaded({required this.upComingMovies});

  @override
  List<Object> get props => [upComingMovies];
}
