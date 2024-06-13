import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../controller/group_controller.dart';

class CreateGroupDialog extends StatelessWidget {
  final List<String> locations = [
    '서울', '경기', '인천', '강원', '충북', '충남', '대전', '세종', '경북', '경남', '대구', '부산', '울산', '전북', '전남', '광주', '제주'
  ];

  CreateGroupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final GroupController groupController = Get.put(GroupController());
    final TextEditingController locationController = TextEditingController();

    // locationController에 초기 값 설정
    locationController.text = groupController.groupLocation.value;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         TextField(
            cursorColor: Colors.black54 ,
            onChanged: (value) {
              groupController.setGroupName(value);
            },
            decoration: const InputDecoration(
              labelText: '그룹 이름',
              labelStyle: TextStyle(color: Colors.black45),
              hintText: '그룹 이름을 입력하세요',
              hintStyle: TextStyle(color: Colors.black45),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black87), // 포커스된 상태에서의 언더라인 색상 지정
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey), // 기본 언더라인 색상 지정
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => _showLocationPicker(context, groupController, locationController),
            child: AbsorbPointer(
              child: TextFormField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: '그룹 위치',
                  labelStyle: TextStyle(color: Colors.black45),
                  hintText: '그룹 위치를 선택하세요',
                  hintStyle: TextStyle(color: Colors.black45),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87), // 포커스된 상태에서의 언더라인 색상 지정
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // 기본 언더라인 색상 지정
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  locationController.dispose();
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent
                ),
                child: const Text('취소', style: TextStyle(
                  color: Colors.white
                ),),
              ),
              ElevatedButton(
                onPressed: () {
                  groupController.createGroup();
                  locationController.dispose();
                  groupController.dispose();
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor("#00E8C1")
                ),
                child: const Text('그룹 생성', style: TextStyle(
                    color: Colors.white,
                ),),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLocationPicker(BuildContext context, GroupController controller, TextEditingController locationController) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300, // 원하는 높이로 설정
          child: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(locations[index]),
                onTap: () {
                  controller.setGroupLocation(locations[index]);
                  locationController.text = locations[index];
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        );
      },
    );
  }
}

