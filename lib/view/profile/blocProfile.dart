import 'package:fit_app/models/user_activity.dart';
import 'package:fit_app/repository/user_activity_repo.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc {
  final _repository = UserActivityRepository();
  final _userActFetcher = PublishSubject<UserActivity>();

  Stream<UserActivity> get userAct => _userActFetcher.stream;

  fetchUserActivity() async {
    UserActivity userActivity = await _repository.fetchUserActivity();
    _userActFetcher.sink.add(userActivity);
  }

  dispose() {
    _userActFetcher.close();
  }
}

final bloc = ProfileBloc();
