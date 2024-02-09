part of 'tab_bar_bloc.dart';

@immutable
abstract class TabBarEvent {}

class TabBarChanged extends TabBarEvent {
  final int selectedIndex;

  TabBarChanged(this.selectedIndex);

}