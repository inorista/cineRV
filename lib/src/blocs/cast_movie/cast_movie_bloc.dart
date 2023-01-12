// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cinerv/src/models/credit.dart';
import 'package:cinerv/src/network/dio_client.dart';
import 'package:cinerv/src/resources/themoviedb_api.dart';
import 'package:equatable/equatable.dart';

part 'cast_movie_event.dart';
part 'cast_movie_state.dart';

class CastMovieBloc extends Bloc<CastMovieEvent, CastMovieState> {
  CastMovieBloc() : super(CastMovieLoading()) {
    final dio = DioClient();
    final theMovieDBApi = TheMovieDBApi(dio);
    on<GetCastEvent>((event, emit) async {
      emit(CastMovieLoading());
      final creditMovie = await theMovieDBApi.getCreditMovieByID(event.movieID);
      emit(CastMovieLoaded(castLoaded: creditMovie));
    });
  }
}
