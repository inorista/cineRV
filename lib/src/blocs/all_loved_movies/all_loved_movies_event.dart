part of 'all_loved_movies_bloc.dart';

abstract class AllLovedMoviesEvent extends Equatable {
  const AllLovedMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetAllLovedMovies extends AllLovedMoviesEvent {
  final List<String> listStringID;
  const GetAllLovedMovies({required this.listStringID});

  @override
  List<Object> get props => [listStringID];
}

class RemoveMovieFromList extends AllLovedMoviesEvent {
  final String movieID;
  const RemoveMovieFromList({required this.movieID});

  @override
  List<Object> get props => [movieID];
}

class AddMovieToList extends AllLovedMoviesEvent {
  final String movieID;
  const AddMovieToList({required this.movieID});

  @override
  List<Object> get props => [movieID];
}
