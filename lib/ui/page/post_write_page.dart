import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class WritePostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("어썸 글쓰기", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              // 완료 버튼 클릭 이벤트 처리
            },
            child: Text(
              "완료",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(height: 1, color: Colors.grey[300]),
          ListTile(
            title: Text(
              "게시글의 주제를 선택해주세요.",
              style: TextStyle(fontSize: 16),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onTap: () {
              // 주제 선택 클릭 이벤트 처리
            },
          ),
          Divider(height: 1, color: Colors.grey[300]),
          Container(
            color: HexColor("#FFF8E1"),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.orange),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "비방, 명예훼손, 글은 올리실 수 없어요.\n제제의 대상의 될수 있습니다.\nTeam Asome 운영정책",
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "제목을 입력하세요",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  maxLines: null,
                  minLines: 1,
                  expands: false,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "나의 이야기를 나눠보세요.",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),
          Spacer(),
          Divider(height: 1, color: Colors.grey[300]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.camera, color: Colors.grey),
                  onPressed: () {
                    // 사진 아이콘 클릭 이벤트 처리
                  },
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.mapMarkerAlt, color: Colors.grey),
                  onPressed: () {
                    // 장소 아이콘 클릭 이벤트 처리
                  },
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.poll, color: Colors.grey),
                  onPressed: () {
                    // 투표 아이콘 클릭 이벤트 처리
                  },
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.tags, color: Colors.grey),
                  onPressed: () {
                    // 태그 아이콘 클릭 이벤트 처리
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

