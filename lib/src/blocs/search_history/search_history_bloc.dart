import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_history_event.dart';
part 'search_history_state.dart';

class SearchHistoryBloc extends Bloc<SearchHistoryEvent, SearchHistoryState> {
  SearchHistoryBloc() : super(SearchHistoryLoading()) {
    on<GetAllSearchHistory>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final listSearchHistory = prefs.getStringList("searchHistory");
      if (listSearchHistory!.isNotEmpty) {
        emit(
          SearchHistoryLoaded(
            searchHistory: listSearchHistory,
          ),
        );
      }
    });

    on<AddKeywordToHistoryList>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final oldListSearchHistory = prefs.getStringList("searchHistory");
      if (oldListSearchHistory?.indexOf(event.keyword) == -1 && event.keyword != "") {
        oldListSearchHistory?..add(event.keyword);
        await prefs.setStringList("searchHistory", oldListSearchHistory!);

        final listSearchHistory = prefs.getStringList("searchHistory");
        emit(SearchHistoryLoaded(searchHistory: listSearchHistory!));
      }
    });

    on<ClearSearchHistory>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList('searchHistory', []);
      final newHistory = prefs.getStringList('searchHistory');
      emit(SearchHistoryLoaded(searchHistory: newHistory!));
    });
  }
}
