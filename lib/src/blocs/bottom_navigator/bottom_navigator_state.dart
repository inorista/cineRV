part of 'bottom_navigator_bloc.dart';

class BottomNavigatorState extends Equatable {
  final int index;
  const BottomNavigatorState({this.index = 0});

  @override
  List<Object> get props => [index];
}
