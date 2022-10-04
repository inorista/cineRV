part of 'search_history_bloc.dart';

abstract class SearchHistoryEvent extends Equatable {
  const SearchHistoryEvent();

  @override
  List<Object> get props => [];
}

class GetAllSearchHistory extends SearchHistoryEvent {}

class AddKeywordToHistoryList extends SearchHistoryEvent {
  final String keyword;
  const AddKeywordToHistoryList({required this.keyword});
  @override
  List<Object> get props => [keyword];
}

class ClearSearchHistory extends SearchHistoryEvent {}
