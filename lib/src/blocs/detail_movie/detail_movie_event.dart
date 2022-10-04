part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();

  @override
  List<Object> get props => [];
}

class GetDetailMovie extends DetailMovieEvent {
  final int movieID;
  const GetDetailMovie({required this.movieID});
  @override
  List<Object> get props => [movieID];
}

class GetReviewsMovie extends DetailMovieEvent {
  final int movieID;
  const GetReviewsMovie({required this.movieID});

  @override
  List<Object> get props => [movieID];
}
