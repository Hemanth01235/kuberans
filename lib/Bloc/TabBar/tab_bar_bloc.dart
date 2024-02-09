import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tab_bar_event.dart';

part 'tab_bar_state.dart';

class TabBarBloc extends Bloc<TabBarEvent, TabBarState> {
  TabBarBloc() : super(TabBarInitial()) {
    on<TabBarChanged>((event, emit) {
      emit(TabBarUpdated(event.selectedIndex));
        });
  }

  Stream<TabBarState> mapEventToState(TabBarEvent event) async* {
    if (event is TabBarChanged) {
      yield TabBarUpdated(event.selectedIndex);
    }
  }
}

