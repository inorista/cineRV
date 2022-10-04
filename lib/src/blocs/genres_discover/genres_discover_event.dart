part of 'genres_discover_bloc.dart';

abstract class GenresDiscoverEvent extends Equatable {
  const GenresDiscoverEvent();

  @override
  List<Object> get props => [];
}

class GetAllGenres extends GenresDiscoverEvent {}
