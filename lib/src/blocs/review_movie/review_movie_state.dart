part of 'review_movie_bloc.dart';

abstract class ReviewMovieState extends Equatable {
  const ReviewMovieState();

  @override
  List<Object> get props => [];
}

class ReviewMovieLoading extends ReviewMovieState {}

class ReviewMovieLoaded extends ReviewMovieState {
  final List<Review> listReviews;
  const ReviewMovieLoaded({this.listReviews = const <Review>[]});

  @override
  List<Object> get props => [listReviews];
}
