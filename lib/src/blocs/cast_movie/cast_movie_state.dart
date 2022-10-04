part of 'cast_movie_bloc.dart';

abstract class CastMovieState extends Equatable {
  const CastMovieState();

  @override
  List<Object> get props => [];
}

class CastMovieLoading extends CastMovieState {}

class CastMovieLoaded extends CastMovieState {
  final Credit castLoaded;
  const CastMovieLoaded({required this.castLoaded});

  @override
  List<Object> get props => [castLoaded];
}
