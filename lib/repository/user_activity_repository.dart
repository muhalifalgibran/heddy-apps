import 'package:fit_app/core/response/base_response.dart';
import 'package:fit_app/entities/daily_mission.dart';

abstract class DailyMRepository {
  Future<BaseResponse<DailyMissionList>> getTodoList();
}
