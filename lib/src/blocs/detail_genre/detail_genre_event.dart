part of 'detail_genre_bloc.dart';

abstract class DetailGenreEvent extends Equatable {
  const DetailGenreEvent();

  @override
  List<Object> get props => [];
}

class GetMovieByGenre extends DetailGenreEvent {
  final String genreID;
  const GetMovieByGenre({required this.genreID});
  @override
  List<Object> get props => [genreID];
}

class GetMoreMovieByGenre extends DetailGenreEvent {
  final String genreID;
  const GetMoreMovieByGenre({required this.genreID});
  @override
  List<Object> get props => [genreID];
}
