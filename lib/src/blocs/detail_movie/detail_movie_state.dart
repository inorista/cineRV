part of 'detail_movie_bloc.dart';

abstract class DetailMovieState extends Equatable {
  const DetailMovieState();

  @override
  List<Object> get props => [];
}

class DetailMovieLoading extends DetailMovieState {}

class DetailMovieLoaded extends DetailMovieState {
  final Movie movie;

  const DetailMovieLoaded({
    required this.movie,
  });
  @override
  List<Object> get props => [movie];
}
