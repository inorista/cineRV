part of 'detail_genre_bloc.dart';

abstract class DetailGenreState extends Equatable {
  const DetailGenreState();

  @override
  List<Object> get props => [];
}

class DetailGenreInitial extends DetailGenreState {}

class DetailGenreLoading extends DetailGenreState {}

class DetailGenreLoaded extends DetailGenreState {
  final List<Movie> moviesGenre;
  const DetailGenreLoaded({this.moviesGenre = const <Movie>[]});
  @override
  List<Object> get props => [moviesGenre];
}
