import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart' as socketio;

import 'package:twod_representative/src/features/home/domain/twod_live_result.dart';
import 'package:twod_representative/src/shared/utils/socketio.dart';

part 'home_page_controller.g.dart';

@riverpod
Stream<TwodLiveResult?> twodLive(TwodLiveRef ref) async* {
  StreamController stream = StreamController();

  SocketService().socket.onError((err) => log(err.toString()));
  SocketService().socket.onDisconnect((_) => log('socketio disconnect'));
  SocketService().socket.on('fromServer', (data) => log(data));

  SocketService().socket.onerror((_) {
    log('Error IS ${_.toString()}');
  });

  ref.onDispose(() {
    stream.close();
    SocketService().socket.dispose();
  });

  SocketService().socket.on('twod_live', (data) {
    log('data: $data');
    final liveData = TwodLiveResult.fromJson(data);
    log('liveData: $liveData');
    stream.add(liveData);
  });

  await for (final value in stream.stream) {
    log('stream value => ${value.toString()}');
    yield value;
  }
}

@riverpod
FutureOr<void> initialTwodLiveRequest(InitialTwodLiveRequestRef ref) async {
  // https://twod-representative-api-2bdb79ae65e9.herokuapp.com/twod/live
  final dio = Dio();
  await dio.get(
      'https://twod-representative-api-2bdb79ae65e9.herokuapp.com/twod/live');
  // return response.data;
}
