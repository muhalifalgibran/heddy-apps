import 'package:fit_app/core/response/base_response.dart';
import 'package:fit_app/entities/daily_mission.dart';
import 'package:fit_app/repository/daily_m_repository.dart';

class GetTodoUsecase {
  final DailyMRepository _dailyMRepository;

  GetTodoUsecase(this._dailyMRepository);

  Future<BaseResponse<DailyMissionList>> start() async {
    return _dailyMRepository.getTodoList();
  }
}
