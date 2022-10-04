part of 'cast_movie_bloc.dart';

abstract class CastMovieEvent extends Equatable {
  const CastMovieEvent();

  @override
  List<Object> get props => [];
}

class GetCastEvent extends CastMovieEvent {
  final int movieID;
  const GetCastEvent({required this.movieID});

  @override
  List<Object> get props => [movieID];
}
