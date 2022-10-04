part of 'genres_discover_bloc.dart';

abstract class GenresDiscoverState extends Equatable {
  const GenresDiscoverState();

  @override
  List<Object> get props => [];
}

class GenresDiscoverInitial extends GenresDiscoverState {}

class GenresDiscoverLoading extends GenresDiscoverState {}

class GenreDiscoverLoaded extends GenresDiscoverState {
  final List<Genre> listGenres;
  const GenreDiscoverLoaded(this.listGenres);

  @override
  List<Object> get props => [listGenres];
}
