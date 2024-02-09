part of 'tab_bar_bloc.dart';

@immutable
abstract class TabBarState {}

class TabBarInitial extends TabBarState {}

class TabBarUpdated extends TabBarState {
  final int selectedIndex;
  TabBarUpdated(this.selectedIndex);
}


