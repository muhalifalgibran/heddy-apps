import 'package:fit_app/core/firebase/base_repo.dart';
import 'package:fit_app/core/response/base_response.dart';
import 'package:fit_app/entities/daily_mission.dart';
import 'package:fit_app/repository/daily_m_repository.dart';

class DailyRepository extends BaseFirestoreRepo implements DailyMRepository {
  @override
  Future<BaseResponse<DailyMissionList>> getTodoList() async {
    final snapshot = await firestore
        .collection('dailyMission')
        .orderBy('missinType')
        .getDocuments();

    final dailyMission = snapshot.documents
        .map((e) => parserFactory.decode<DailyMission>(e.data))
        .toList();

    return BaseResponse(null, Status.success, 'Load List Success',
        DailyMissionList(dailyMission));
  }
}
