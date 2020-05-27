import 'package:fit_app/core/blocs/scroll_fragment_bloc.dart';
import 'package:fit_app/core/firebase/f_daily_repository.dart';
import 'package:fit_app/entities/daily_mission.dart';
import 'package:fit_app/repository/daily_m_repository.dart';
import 'package:fit_app/usecases/get_todo_usecase.dart';

class ProfileBloc extends ScrollFragmentBloc<DailyMission> {
  final GetTodoUsecase getTodoList;

  ProfileBloc({DailyMRepository dailyMRepository})
      : this.getTodoList = GetTodoUsecase(dailyMRepository ?? DailyRepository);

  @override
  ScrollFragmentState<DailyMission> get initialState =>
      ScrollFragmentState(items);

  @override
  Stream<ScrollFragmentState<DailyMission>> mapEventToState(
      ScrollFragmentEvent event) async* {
    print("hai");
    if (event is Init) {
      print("wkwk");
      final result = await getTodoList.start();
      if (result.isSuccess()) {
        items.addAll(result.data.dailyMission);
      } else {
        print("nul");
      }
      yield ScrollFragmentState(items);
    } else if (event is Add<DailyMission>) {
      print("hai");
      items..add(event.item);
      yield ScrollFragmentState(items);
    }
  }
}
