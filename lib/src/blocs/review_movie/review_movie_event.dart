part of 'review_movie_bloc.dart';

abstract class ReviewMovieEvent extends Equatable {
  const ReviewMovieEvent();

  @override
  List<Object> get props => [];
}

class GetReviewMovie extends ReviewMovieEvent {
  final int movieID;
  const GetReviewMovie({required this.movieID});

  @override
  List<Object> get props => [movieID];
}

class GetMoreReviewsMovie extends ReviewMovieEvent {
  final List<Review> listReviews;
  const GetMoreReviewsMovie({required this.listReviews});

  @override
  List<Object> get props => [listReviews];
}
