import 'dart:convert';
import 'package:asome/controller/url_token_controller.dart';
import 'package:get/get.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:http/http.dart' as http;
import '../model/dto/chat_list_dto.dart';
import '../model/dto/chat_message_dto.dart';

class WebSocketController extends GetxController {
  late StompClient stompClient;
  var messages = <MessageDto>[].obs;
  final UrlTokenController _controller = Get.find<UrlTokenController>();

  void connect(ChatListDto chatRoom) {
    final headers = _controller.createHeaders();
    print('Headers: $headers'); // 헤더가 올바른지 확인

    // 기존 메시지 불러오기
    fetchInitialMessages(chatRoom.chatId!);

    stompClient = StompClient(
      config: StompConfig(
        url: _controller.webSocketUrl.value, // 웹소켓 URL 형식 확인
        onConnect: (StompFrame frame) {
          print('Connected to WebSocket');
          stompClient.subscribe(
            destination: '/room/${chatRoom.chatId}',
            headers: headers,
            callback: (StompFrame frame) {
              if (frame.body != null) {
                var messageJson = json.decode(frame.body!);
                if (messageJson != null) {
                  var message = MessageDto.fromJson(messageJson);
                  messages.add(message);
                }
              }
            },
          );
        },
        onWebSocketError: (dynamic error) {
          print('WebSocket Error: $error');
        },
        onStompError: (dynamic error) {
          print('STOMP Error: $error');
        },
        beforeConnect: () async {
          print('waiting to connect...');
          await Future.delayed(const Duration(milliseconds: 200));
          print('connecting...');
        },
        stompConnectHeaders: headers, // STOMP 연결 설정 시 헤더 추가
        webSocketConnectHeaders: headers, // 초기 WebSocket 연결 설정 시 헤더 추가
      ),
    );
    stompClient.activate();
  }

  void sendMessage(String chatId, MessageDto? message) {
    if (message == null) {
      print('Cannot send a null message');
      return;
    }

    if (stompClient.connected) {
      print('Sending message to /send/$chatId: ${json.encode(message.toJson())}');
      stompClient.send(
        destination: '/send/$chatId',
        body: json.encode(message.toJson()), // 메시지를 JSON 형식으로 변환하여 전송
        headers: _controller.createHeaders(),
      );
    } else {
      print('WebSocket is not connected');
    }
  }

  void disconnect() {
    stompClient.deactivate();
  }

  Future<void> fetchInitialMessages(int chatId) async {
    final url = "${_controller.url.value}/api/chat/message/$chatId";
    print('Fetching initial messages from $url');
    final response = await http.get(Uri.parse(url), headers: _controller.createHeaders());
    if (response.statusCode == 200) {
      List<dynamic> messageJsonList = json.decode(utf8.decode(response.bodyBytes));
      List<MessageDto> initialMessages = messageJsonList.map((json) => MessageDto.fromJson(json)).toList();
      messages.addAll(initialMessages);
    } else {
      print('Failed to load initial messages');
    }
  }
}

