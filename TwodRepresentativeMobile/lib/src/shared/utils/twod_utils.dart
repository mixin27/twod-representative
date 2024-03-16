import 'package:twod_representative/src/features/home/domain/twod_live_result.dart';

String getLatestTwodResultIfEmpty(String twod, List<TwodOtherResult> others) {
  if (twod == '--') {
    return others.isEmpty ? twod : others.last.twod;
  } else {
    return twod;
  }
}
