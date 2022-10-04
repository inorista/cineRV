import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'search_field_event.dart';
part 'search_field_state.dart';

TextEditingController textController = TextEditingController();

class SearchFieldBloc extends Bloc<SearchFieldEvent, SearchFieldState> {
  SearchFieldBloc() : super(SearchFieldState(textController: textController)) {
    on<SearchByHistoryKeyword>((event, emit) async {
      state.textController.text = event.keyword;
    });

    on<ClearSearchField>((event, emit) {
      state.textController.clear();
    });
  }
}
