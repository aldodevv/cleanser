import 'dart:async';
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum SocketChannelType { chat, call, notification }

@lazySingleton
class SocketManager {
  final Map<SocketChannelType, WebSocketChannel> _channels = {};
  final Map<SocketChannelType, StreamSubscription> _subscriptions = {};

  // For specific feature listeners
  final _chatStreamController = StreamController<dynamic>.broadcast();
  final _callStreamController = StreamController<dynamic>.broadcast();

  Stream<dynamic> get chatStream => _chatStreamController.stream;
  Stream<dynamic> get callStream => _callStreamController.stream;

  void connect(SocketChannelType type, String url) {
    if (_channels.containsKey(type)) {
      disconnect(type);
    }
    
    final uri = Uri.parse(url);
    final channel = WebSocketChannel.connect(uri);
    _channels[type] = channel;

    _subscriptions[type] = channel.stream.listen(
      (data) {
        // Broadcast based on type
        final decoded = jsonDecode(data);
        if (type == SocketChannelType.chat) {
          _chatStreamController.add(decoded);
        } else if (type == SocketChannelType.call) {
          _callStreamController.add(decoded);
        }
      },
      onError: (error) {
        // Attempt reconnection, handle error
      },
      onDone: () {
        // Socket closed
        disconnect(type);
      },
    );
  }

  void send(SocketChannelType type, Map<String, dynamic> data) {
    if (_channels.containsKey(type)) {
      _channels[type]?.sink.add(jsonEncode(data));
    }
  }

  void disconnect(SocketChannelType type) {
    _subscriptions[type]?.cancel();
    _subscriptions.remove(type);
    
    _channels[type]?.sink.close();
    _channels.remove(type);
  }

  void disconnectAll() {
    for (var type in _channels.keys.toList()) {
      disconnect(type);
    }
  }
}
