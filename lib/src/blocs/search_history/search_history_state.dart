part of 'search_history_bloc.dart';

abstract class SearchHistoryState extends Equatable {
  const SearchHistoryState();

  @override
  List<Object> get props => [];
}

class SearchHistoryInitial extends SearchHistoryState {}

class SearchHistoryLoading extends SearchHistoryState {}

class SearchHistoryLoaded extends SearchHistoryState {
  final List<String> searchHistory;
  const SearchHistoryLoaded({required this.searchHistory});

  @override
  List<Object> get props => [searchHistory];
}
