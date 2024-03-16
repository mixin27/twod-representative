// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'twod_live.g.dart';

@JsonSerializable()
class TwodLive extends Equatable {
  final String date;
  final String set;
  final String value;
  final String twod;

  const TwodLive({
    required this.date,
    required this.set,
    required this.value,
    required this.twod,
  });

  factory TwodLive.fromJson(Map<String, dynamic> json) =>
      _$TwodLiveFromJson(json);

  @override
  List<Object?> get props => [date, set, value, twod];

  TwodLive copyWith({
    String? date,
    String? set,
    String? value,
    String? twod,
    String? serverTime,
  }) {
    return TwodLive(
      date: date ?? this.date,
      set: set ?? this.set,
      value: value ?? this.value,
      twod: twod ?? this.twod,
    );
  }

  @override
  bool get stringify => true;
}
