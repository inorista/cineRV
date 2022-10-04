part of 'search_field_bloc.dart';

class SearchFieldState extends Equatable {
  late TextEditingController textController = TextEditingController();
  SearchFieldState({required this.textController});

  @override
  List<Object> get props => [textController];
}
