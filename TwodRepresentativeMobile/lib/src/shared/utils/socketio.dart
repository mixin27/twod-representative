import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:twod_representative/src/env/env.dart';

// ignore: library_prefixes

class SocketService {
  IO.Socket socket = IO.io(
    // 'http://192.168.1.112:7777',
    Env.twodApiUrl,
    IO.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build(),
  );

  initConnection() {
    socket.connect();
    socket.onConnect((_) {
      log('socketio connect');
    });

    socket.onerror((_) {
      log('Error Is ${_.toString()}');
    });
  }
}
