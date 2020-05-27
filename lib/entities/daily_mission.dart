import 'package:equatable/equatable.dart';
import 'package:fit_app/core/response/base_data.dart';
import 'package:fit_app/core/tools/data_parser_factory.dart';

class DailyMission extends Equatable implements Data {
  final String id, idUser, mission, missionDesc, missionType, username;

  final bool isDone;

  DailyMission(
      {this.id,
      this.idUser,
      this.mission,
      this.missionDesc,
      this.missionType,
      this.username,
      this.isDone});

  DailyMission copyWith(
      {final String id, idUser, mission, missionDesc, missionType, username}) {
    return DailyMission(
        id: id ?? this.id,
        idUser: idUser ?? this.idUser,
        mission: mission ?? this.mission,
        missionDesc: missionDesc ?? this.missionDesc,
        missionType: missionType ?? this.missionType,
        username: username ?? this.username,
        isDone: isDone ?? this.isDone);
  }

  @override
  List<Object> get props => [
        this.id,
        this.idUser,
        this.mission,
        this.missionDesc,
        this.missionType,
        this.username,
        this.isDone
      ];

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'idUser': this.idUser,
      'mission': this.mission,
      'missionDesc': this.missionDesc,
      'missionType': this.missionType,
      'isDone': this.isDone,
    };
  }

  static DailyMission fromMap(Map<dynamic, dynamic> map) {
    return DailyMission(
        id: map['id'],
        idUser: map['idUser'],
        mission: map['mission'],
        missionDesc: map['missionDesc'],
        missionType: map['missionType'],
        isDone: map['isDone']);
  }
}

class DailyMissionList extends Equatable implements Data {
  final List<DailyMission> dailyMission;

  DailyMissionList(this.dailyMission);

  @override
  List<Object> get props => dailyMission;

  @override
  Map<String, dynamic> toMap() {
    return {dailyMissionKey: dailyMission.map((e) => e.toMap())};
  }

  static DailyMissionList fromMap(Map<dynamic, dynamic> map) {
    final rawList = map[dailyMissionKey] as List;
    final list = rawList
        .map((e) => DataParserFactory.get().decode<DailyMission>(e))
        .toList();

    return DailyMissionList(list);
  }

  static const String dailyMissionKey = 'dailyMission';
}
