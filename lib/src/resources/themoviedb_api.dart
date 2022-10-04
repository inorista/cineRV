import 'dart:core';

import 'package:cinerv/src/models/credit.dart';
import 'package:cinerv/src/models/genre.dart';
import 'package:cinerv/src/models/movie.dart';
import 'package:cinerv/src/models/review.dart';
import 'package:cinerv/src/network/dio_client.dart';
import 'package:intl/intl.dart';

final formatter = new DateFormat('yyyy-MM-dd');
final currentDate = formatter.format(DateTime.now());

class TheMovieDBApi {
  TheMovieDBApi(this._DioClient);
  final DioClient _DioClient;
  static const API_KEY = "32608dccf06315f600b0393593f754aa";
  @override
  Future<List<Movie>> getTrendingMovies({
    int page = 1,
  }) async {
    final movies = await _DioClient.get('/discover/movie', queryParameters: {
      "page": page,
      "language": "vi-VN",
      "region": "VN",
      "api_key": API_KEY,
      "sort_by": "popularity.desc",
      "include_adult": true,
    });
    return (movies["results"] as List).map((elm) => Movie.fromJson(elm)).toList();
  }

  Future<List<Movie>> getTopRatedMovies({
    int page = 1,
  }) async {
    final movies = await _DioClient.get('/movie/top_rated', queryParameters: {
      "page": page,
      "language": "vi-VN",
      "region": "VN",
      "api_key": API_KEY,
    });
    return (movies["results"] as List).map((elm) => Movie.fromJson(elm)).toList();
  }

  Future<List<Movie>> getUpcomingMovies({
    int page = 1,
  }) async {
    final movies = await _DioClient.get('/discover/movie', queryParameters: {
      "page": page,
      "language": "vi-VN",
      "api_key": API_KEY,
      "sort_by": "release_date.desc",
      "include_adult": true,
      "primary_release_date.gte": currentDate.toString(),
    });
    return (movies["results"] as List).map((elm) => Movie.fromJson(elm)).toList();
  }

  Future<List<Genre>> getAllGenresMovie() async {
    final genres = await _DioClient.get('/genre/movie/list', queryParameters: {
      "language": "vi-VN",
      "api_key": API_KEY,
    });
    return (genres["genres"] as List).map((elm) => Genre.fromJson(elm)).toList();
  }

  Future<Movie> getDetailMovieByID(int movieID) async {
    final movie = await _DioClient.get('/movie/$movieID', queryParameters: {
      "language": "vi-VN",
      "api_key": API_KEY,
    });
    return Movie.fromJson(movie);
  }

  Future<List<Review>> getReviewsMovieByID(
    int movieID, {
    int page = 1,
  }) async {
    final reviews = await _DioClient.get('/movie/$movieID/reviews', queryParameters: {
      "page": page,
      "language": "en-US",
      "api_key": API_KEY,
    });

    return (reviews['results'] as List).map((e) => Review.fromJson(e)).toList();
  }

  Future<Credit> getCreditMovieByID(int movieID) async {
    final credit = await _DioClient.get('/movie/$movieID/credits', queryParameters: {
      "language": "en-US",
      "api_key": API_KEY,
    });
    return Credit.fromJson(credit);
  }

  Future<List<Movie>> searchMoviesByKeyword(
    String query, {
    int page = 1,
  }) async {
    final moviesSearched = await _DioClient.get('/search/movie', queryParameters: {
      "language": "vi-VN",
      "api_key": API_KEY,
      "query": query,
      "include_adult": true,
      "page": page,
    });
    return (moviesSearched['results'] as List).map((e) => Movie.fromJson(e)).toList();
  }

  Future<List<Movie>> getMoreMoviesByKeyword(Map<String, String> map) async {
    final query = map['query'];
    final page = map['page'];
    final moviesSearched = await _DioClient.get('/search/movie', queryParameters: {
      "language": "vi-VN",
      "api_key": API_KEY,
      "query": query,
      "include_adult": true,
      "page": int.parse(page!),
    });
    return (moviesSearched['results'] as List).map((e) => Movie.fromJson(e)).toList();
  }

  Future<List<Movie>> getAllLovedMovieByID(List<String> listID) async {
    final List<Movie> listMovies = [];
    for (int i = 0; i < listID.length; i++) {
      final movieID = listID[i];

      final movie = await _DioClient.get('/movie/$movieID', queryParameters: {
        "language": "vi-VN",
        "api_key": API_KEY,
      });

      final tempMovie = Movie.fromJson(movie);

      listMovies..add(tempMovie);
    }
    ;
    return listMovies;
  }

  Future<List<Movie>> getPopularMovie() async {
    final popularMovies = await _DioClient.get('/movie/popular', queryParameters: {
      "language": "vi-VN",
      "api_key": API_KEY,
      "page": 1,
    });
    return (popularMovies['results'] as List).map((e) => Movie.fromJson(e)).toList();
  }

  Future<List<Movie>> getMoviesByGenre(
    String genreID, {
    int page = 1,
  }) async {
    final moviesByGenre = await _DioClient.get('/discover/movie', queryParameters: {
      "language": "vi-VN",
      "api_key": API_KEY,
      "sort_by": "release_date.desc",
      "page": page,
      "include_adult": true,
      "with_genres": int.parse(genreID),
    });
    return (moviesByGenre['results'] as List).map((e) => Movie.fromJson(e)).toList();
  }
}
