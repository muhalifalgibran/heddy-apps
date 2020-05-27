import 'package:equatable/equatable.dart';
import 'package:fit_app/core/response/base_data.dart';
import 'package:fit_app/core/tools/data_parser_factory.dart';

class Status {
  static const String success = "success";
  static const String failed = "failed";
}

class BaseResponse<T extends Data> extends Equatable implements Data {
  final Map<String, dynamic> rawResponse;
  final String status;
  final String message;
  final T data;

  BaseResponse(this.rawResponse, this.status, this.message, this.data);

  factory BaseResponse.fromPref(T data) {
    return BaseResponse({}, Status.success, 'loaded', data);
  }

  factory BaseResponse.error(
    String message, {
    Map<String, dynamic> rawResponse,
  }) {
    return BaseResponse(rawResponse, Status.failed, message, null);
  }

  bool isSuccess() => status == Status.success;

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data.toMap(),
    };
  }

  static BaseResponse<T> fromMap<T extends Data>(Map<dynamic, dynamic> map) {
    return BaseResponse(
      map,
      map['status'],
      map['message'],
      DataParserFactory.get().decode(map['data']),
    );
  }

  @override
  List<Object> get props => [rawResponse, status, message, data];
}
