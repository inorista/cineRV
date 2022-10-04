import 'package:bloc/bloc.dart';
import 'package:cinerv/src/models/review.dart';
import 'package:cinerv/src/network/dio_client.dart';
import 'package:cinerv/src/resources/themoviedb_api.dart';
import 'package:equatable/equatable.dart';

part 'review_movie_event.dart';
part 'review_movie_state.dart';

class ReviewMovieBloc extends Bloc<ReviewMovieEvent, ReviewMovieState> {
  ReviewMovieBloc() : super(ReviewMovieLoading()) {
    final _dio = DioClient();
    final _theMovieDBApi = TheMovieDBApi(_dio);
    var _currentReviewsPage = 1;
    on<GetReviewMovie>((event, emit) async {
      emit(ReviewMovieLoading());
      final listReviews = await _theMovieDBApi.getReviewsMovieByID(event.movieID);
      emit(ReviewMovieLoaded(listReviews: listReviews));
    });
  }
}
