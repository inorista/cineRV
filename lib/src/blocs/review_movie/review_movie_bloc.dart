import 'package:bloc/bloc.dart';
import 'package:cinerv/src/models/review.dart';
import 'package:cinerv/src/network/dio_client.dart';
import 'package:cinerv/src/resources/themoviedb_api.dart';
import 'package:equatable/equatable.dart';

part 'review_movie_event.dart';
part 'review_movie_state.dart';

class ReviewMovieBloc extends Bloc<ReviewMovieEvent, ReviewMovieState> {
  ReviewMovieBloc() : super(ReviewMovieLoading()) {
    final dio = DioClient();
    final theMovieDBApi = TheMovieDBApi(dio);
    on<GetReviewMovie>((event, emit) async {
      emit(ReviewMovieLoading());
      final listReviews = await theMovieDBApi.getReviewsMovieByID(event.movieID);
      emit(ReviewMovieLoaded(listReviews: listReviews));
    });
  }
}
