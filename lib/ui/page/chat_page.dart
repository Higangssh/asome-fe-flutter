import 'package:asome/controller/bottom_bar_controller.dart';
import 'package:asome/controller/url_token_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../controller/web_socket_controller.dart';
import '../../model/dto/chat_list_dto.dart';
import '../../model/dto/chat_message_dto.dart';

class ChatPage extends StatefulWidget {
  final ChatListDto chatRoom;

  ChatPage({required this.chatRoom});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  late WebSocketController _webSocketController;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  late UrlTokenController urlTokenController;
  late BottomBarController bottomAppBar;

  @override
  void initState() {
    super.initState();
    bottomAppBar = Get.find<BottomBarController>();
    urlTokenController = Get.find<UrlTokenController>();
    _webSocketController = Get.put(WebSocketController());
    _webSocketController.connect(widget.chatRoom);

    // Add observer to listen to keyboard events
    WidgetsBinding.instance.addObserver(this);

    // Scroll to bottom when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    // Scroll to bottom when the text field gains focus
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _scrollToBottom();
      }
    });

    // Scroll to bottom when new messages arrive
    _webSocketController.messages.listen((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _webSocketController.disconnect();
    _scrollController.dispose();
    _focusNode.dispose();
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomInset > 0.0) {
      // Keyboard is visible
      Future.delayed(Duration(milliseconds: 300), () {
        _scrollToBottom();
      });
    }
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      final message = MessageDto(
        id: 0, // id는 서버에서 생성될 것이므로 임시로 0 설정
        content: _controller.text,
        createAt: DateTime.now().toIso8601String(), // 현재 시간을 설정
        nick: urlTokenController.nick.value, // 사용자 닉네임 설정
      );
      _webSocketController.sendMessage(widget.chatRoom.chatId.toString(), message);
      _controller.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            bottomAppBar.changePage(2);
            Navigator.pop(context);
          },
        ),
        title: Text(widget.chatRoom.chatName ?? 'Chat Room' ,style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),),
        backgroundColor: HexColor("#00E8C1"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                // Scroll to bottom whenever messages change
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom();
                });

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: _webSocketController.messages.length,
                  itemBuilder: (context, index) {
                    final message = _webSocketController.messages[index];
                    bool isMe = message.nick == urlTokenController.nick.value;
                    final displayNick = message.nick ?? "유령유저"; // Assign "유령유저" if nick is null

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        crossAxisAlignment:
                        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          if (!isMe)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center, // Center align icon and message bubble
                              children: [
                                Icon(
                                  Icons.person,
                                  color: HexColor("#00E8C1"), // 원하는 아이콘으로 변경 가능
                                  size: 40, // 아이콘 크기
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      displayNick, // Display nickname
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 12, // Reduced font size
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context).size.width * 0.7),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            message.content,
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            message.createAt!,
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          if (isMe)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * 0.7),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        message.content,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        message.createAt!,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: '메시지를 입력하세요',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}







