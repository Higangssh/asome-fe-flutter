import 'package:asome/model/dto/Post_request_dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../controller/category_controller.dart';
import '../../model/dto/category_dto.dart';

class WritePostPage extends StatefulWidget {
  @override
  _WritePostPageState createState() => _WritePostPageState();
}

class _WritePostPageState extends State<WritePostPage> {
  final CategoryController categoryController = Get.put(CategoryController());

  final List<Color> categoryColors = [
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.grey,
    Colors.purple,
  ];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  int? selectedCategoryId;
  String selectedCategoryName = "게시글의 주제를 선택해주세요.";

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              _submitPost(context);
            },
            child: Text(
              "완료",
              style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold), // 진하게 표시
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: 1, color: Colors.grey[300]),
                ListTile(
                  title: Text(
                    selectedCategoryName,
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  onTap: () {
                    _showCategorySelection(context);
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
                        controller: titleController,
                        maxLines: null,
                        minLines: 1,
                        expands: false,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: "멋진 제목을 건내 주세요",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: Colors.grey[300]),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: contentController,
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
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                color: Colors.white,
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
            ),
          ),
        ],
      ),
    );
  }

  void _showCategorySelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          if (categoryController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (categoryController.errorMessage.isNotEmpty) {
            return Center(child: Text(categoryController.errorMessage.value));
          } else {
            return Container(
              padding: const EdgeInsets.all(16.0),
              height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "게시글 주제를 선택해주세요.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: List.generate(categoryController.categories.length, (index) {
                          return _buildCategoryChip(
                            context,
                            categoryController.categories[index],
                            categoryColors[index % categoryColors.length],
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        });
      },
    );
  }

  Widget _buildCategoryChip(BuildContext context, CategoryDto category, Color color) {
    return ActionChip(
      label: Text(category.boardName, style: TextStyle(color: Colors.white)),
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      onPressed: () {
        Navigator.pop(context);
        setState(() {
          selectedCategoryId = category.categoryId;
          selectedCategoryName = category.boardName; // 선택된 카테고리 이름 설정
        });
        // 선택된 주제 처리 로직
        print("${category.boardName} 선택됨");
      },
    );
  }

  void _submitPost(BuildContext context) async {
    if (selectedCategoryId == null || titleController.text.isEmpty || contentController.text.isEmpty) {
      _showAlertDialog(context, "실패", "주제,제목,내용을 입력 여부를 확인해 주세요!");
      return;
    }

    PostRequestDto postRequestDto = PostRequestDto(
      commonId: selectedCategoryId!,
      title: titleController.text,
      content: contentController.text,
    );

    bool success = await categoryController.addPost(postRequestDto);

    if (success) {
      _showAlertDialog(context, "성공", "게시물 생성에 성공했습니다!");
    } else {
      _showAlertDialog(context, "실패", "게시물 생성에 실패했습니다!");
    }
  }

  void _showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(title)),
          content: Text(message),
          actions: [
            TextButton(
              child: const Center(child: Text("OK")),
              onPressed: () {
                Navigator.of(context).pop();
                if (title == "성공") {
                  Navigator.of(context).pop(); // PostPage 닫기
                }
              },
            ),
          ],
        );
      },
    );
  }
}






