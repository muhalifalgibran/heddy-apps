import 'package:bloc/bloc.dart';

class ScrollFragmentEvent {}

class Init extends ScrollFragmentEvent {}

class Scroll extends ScrollFragmentEvent {}

class Add<T> extends ScrollFragmentEvent {
  final T item;

  Add(this.item);
}

class Edit<T> extends ScrollFragmentEvent {
  final T item;

  Edit(this.item);
}

class Delete<T> extends ScrollFragmentEvent {
  final T item;

  Delete(this.item);
}
// endregion

// region state
class ScrollFragmentState<T> {
  final List<T> items;

  ScrollFragmentState(this.items);
}
// endregion

abstract class ScrollFragmentBloc<T>
    extends Bloc<ScrollFragmentEvent, ScrollFragmentState<T>> {
  final List<T> items = [];
}
