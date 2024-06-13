import 'dart:async';  // Timer 클래스를 사용하기 위해 추가
import 'package:asome/controller/url_token_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchBottomModal extends StatefulWidget {
  SearchBottomModal({super.key});

  static void show(BuildContext context , int groupId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          minChildSize: 0.4,
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    '친구 초대하기',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: UserSearchList(groupId:  groupId,),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  _SearchBottomModalState createState() => _SearchBottomModalState();
}

class _SearchBottomModalState extends State<SearchBottomModal> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class UserSearchList extends StatefulWidget {
  final int groupId;
  const UserSearchList({required this.groupId, super.key});

  @override
  _UserSearchListState createState() => _UserSearchListState();
}

class _UserSearchListState extends State<UserSearchList> with WidgetsBindingObserver {
  UrlTokenController urlTokenController = Get.find<UrlTokenController>();
  List<String> _nickNames = [];
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _searchController.addListener(() {
      _onSearchChanged(widget.groupId);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _searchController.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(int groupId) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchNick(_searchController.text,groupId);
    });
  }

  void _searchNick(String nick, int groupId) async {
    if (nick.isEmpty) {
      setState(() {
        _nickNames = [];
      });
      return;
    }
    final encodedNick = Uri.encodeComponent(nick);
    final requestUrl = "${urlTokenController.url.value}/api/member/search/$encodedNick/$groupId";
    final response = await http.get(Uri.parse(requestUrl), headers: urlTokenController.createHeaders());

    if (response.statusCode == 200) {
      print("response.statusCode: ${response.statusCode}");
      print(response.body);
      setState(() {
        _nickNames = List<String>.from(jsonDecode(utf8.decode(response.bodyBytes)));
      });

      // 스크롤을 끝으로 이동
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    } else {
      print("response.statusCode: ${response.statusCode}");
      setState(() {
        _nickNames = [];
      });
    }
  }


  Future<void> _inviteUser(int groupId, String nick) async {
    final encodedNick = Uri.encodeComponent(nick);
    final requestUrl = "${urlTokenController.url.value}/api/join/request?groupId=$groupId&nick=$encodedNick";
    final response = await http.get(Uri.parse(requestUrl), headers: urlTokenController.createHeaders());

    if (response.statusCode == 200) {
      final isSuccess = jsonDecode(response.body);
      if (isSuccess) {
        print("성공");
      }
      Get.back();
    }

  }


  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = View.of(context).viewInsets.bottom; // 변경된 부분
    if (bottomInset > 0.0) {
      // 키보드가 올라올 때 스크롤을 끝으로 이동
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: '닉네임으로 검색 해주세요',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: HexColor("#00E8C1"),
            prefixIcon: const Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: _nickNames.length,
            itemBuilder: (context, index) {
              final nick = _nickNames[index];
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(nick),
                trailing: ElevatedButton(
                  onPressed: () {
                    _inviteUser(widget.groupId, nick);
                  },
                  child: const Text('초대하기'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}


