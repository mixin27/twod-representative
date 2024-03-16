// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:twod_representative/src/features/home/domain/twod_live.dart';

part 'twod_live_result.g.dart';

@JsonSerializable()
class TwodLiveResult extends Equatable {
  @JsonKey(name: 'server_time')
  final String serverTime;

  final TwodLive live;

  @JsonKey(name: 'result')
  final List<TwodOtherResult> others;

  const TwodLiveResult(
      {required this.serverTime, required this.live, required this.others});

  factory TwodLiveResult.fromJson(Map<String, dynamic> json) =>
      _$TwodLiveResultFromJson(json);

  TwodLiveResult copyWith({
    String? serverTime,
    TwodLive? live,
    List<TwodOtherResult>? others,
  }) {
    return TwodLiveResult(
      serverTime: serverTime ?? this.serverTime,
      live: live ?? this.live,
      others: others ?? this.others,
    );
  }

  @override
  String toString() => 'TwodLiveResult(serverTime: $serverTime, live: $live)';

  @override
  List<Object?> get props => [serverTime, live, others];

  @override
  bool get stringify => true;
}

// {"set":"1391.78","value":"14923.50","open_time":"11:00:00","twod":"83","stock_date":"2024-03-15","stock_datetime":"2024-03-15 11:00:01","history_id":"1354609"}
@JsonSerializable()
class TwodOtherResult extends Equatable {
  final String set;
  final String value;

  @JsonKey(name: 'open_time')
  final String openTime;

  final String twod;

  @JsonKey(name: 'stock_date')
  final String stockDate;

  @JsonKey(name: 'stock_datetime')
  final String stockDateTime;

  @JsonKey(name: 'history_id')
  final String historyId;

  const TwodOtherResult({
    required this.set,
    required this.value,
    required this.openTime,
    required this.twod,
    required this.stockDate,
    required this.stockDateTime,
    required this.historyId,
  });

  factory TwodOtherResult.fromJson(Map<String, dynamic> json) =>
      _$TwodOtherResultFromJson(json);

  @override
  List<Object?> get props => [
        set,
        value,
        openTime,
        twod,
        stockDate,
        stockDateTime,
        historyId,
      ];

  TwodOtherResult copyWith({
    String? set,
    String? value,
    String? openTime,
    String? twod,
    String? stockDate,
    String? stockDateTime,
    String? historyId,
  }) {
    return TwodOtherResult(
      set: set ?? this.set,
      value: value ?? this.value,
      openTime: openTime ?? this.openTime,
      twod: twod ?? this.twod,
      stockDate: stockDate ?? this.stockDate,
      stockDateTime: stockDateTime ?? this.stockDateTime,
      historyId: historyId ?? this.historyId,
    );
  }

  @override
  bool get stringify => true;
}
