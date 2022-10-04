part of 'search_field_bloc.dart';

abstract class SearchFieldEvent extends Equatable {
  const SearchFieldEvent();

  @override
  List<Object> get props => [];
}

class SearchByHistoryKeyword extends SearchFieldEvent {
  final String keyword;
  const SearchByHistoryKeyword({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class ClearSearchField extends SearchFieldEvent {}
