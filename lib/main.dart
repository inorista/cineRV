import 'package:cinerv/src/blocs/all_loved_movies/all_loved_movies_bloc.dart';
import 'package:cinerv/src/blocs/bottom_navigator/bottom_navigator_bloc.dart';
import 'package:cinerv/src/blocs/cast_movie/cast_movie_bloc.dart';
import 'package:cinerv/src/blocs/detail_genre/detail_genre_bloc.dart';
import 'package:cinerv/src/blocs/detail_movie/detail_movie_bloc.dart';
import 'package:cinerv/src/blocs/genres_discover/genres_discover_bloc.dart';
import 'package:cinerv/src/blocs/popular_movie/popular_movie_bloc.dart';
import 'package:cinerv/src/blocs/review_movie/review_movie_bloc.dart';
import 'package:cinerv/src/blocs/search_field/search_field_bloc.dart';
import 'package:cinerv/src/blocs/search_history/search_history_bloc.dart';
import 'package:cinerv/src/blocs/search_result/search_result_bloc.dart';
import 'package:cinerv/src/blocs/settings/settings_bloc.dart';
import 'package:cinerv/src/blocs/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:cinerv/src/blocs/trending_movie/trending_movie_bloc.dart';
import 'package:cinerv/src/blocs/upcoming_movie/upcoming_movie_bloc.dart';
import 'package:cinerv/src/ui/login/login_screen_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final lovelist = prefs.getStringList("lovelist");
  final searchHistory = prefs.getStringList("searchHistory");
  if (lovelist == null) {
    await prefs.setStringList("lovelist", <String>[]);
  }
  if (searchHistory == null) {
    await prefs.setStringList("searchHistory", <String>[]);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PopularMovieBloc()..add(GetPopularMovie())),
        BlocProvider(create: (context) => SearchHistoryBloc()..add(GetAllSearchHistory())),
        BlocProvider(create: (context) => BottomNavigatorBloc()),
        BlocProvider(create: (context) => GenresDiscoverBloc()..add(GetAllGenres())),
        BlocProvider(create: (context) => TrendingMovieBloc()..add(const GetTrendingMovies())),
        BlocProvider(create: (context) => TopRatedMovieBloc()..add(const GetTopRatedMovies())),
        BlocProvider(create: (context) => UpcomingMovieBloc()..add(const GetUpcomingMovie())),
        BlocProvider(create: (context) => ReviewMovieBloc()),
        BlocProvider(create: (context) => DetailMovieBloc()),
        BlocProvider(create: (context) => CastMovieBloc()),
        BlocProvider(create: (context) => AllLovedMoviesBloc()),
        BlocProvider(create: (context) => SearchResultBloc()),
        BlocProvider(create: (context) => SearchFieldBloc()),
        BlocProvider(create: (context) => DetailGenreBloc()),
        BlocProvider(create: (context) => SettingsBloc())
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            home: const LoginScreen1(),
            debugShowCheckedModeBanner: false,
            title: 'CineRV',
            theme: state.themes,
          );
        },
      ),
    );
  }
}
