part of 'search_field_bloc.dart';

// ignore: must_be_immutable
class SearchFieldState extends Equatable {
  late TextEditingController textController = TextEditingController();
  SearchFieldState({required this.textController});

  @override
  List<Object> get props => [textController];
}
