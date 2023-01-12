// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navigator_event.dart';
part 'bottom_navigator_state.dart';

class BottomNavigatorBloc extends Bloc<BottomNavigatorEvent, BottomNavigatorState> {
  BottomNavigatorBloc() : super(const BottomNavigatorState()) {
    on<ChangeIndexEvent>((event, emit) {
      emit(BottomNavigatorState(index: event.index));
    });
  }
}
