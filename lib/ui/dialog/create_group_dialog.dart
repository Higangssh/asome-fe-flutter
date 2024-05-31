import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/group_controller.dart';

class CreateGroupDialog extends StatelessWidget {
  final List<String> locations = [
    '서울', '경기', '인천', '강원', '충북', '충남', '대전', '세종', '경북', '경남', '대구', '부산', '울산', '전북', '전남', '광주', '제주'
  ];

  @override
  Widget build(BuildContext context) {
    final CreateGroupController createGroupController = Get.find<CreateGroupController>();
    final TextEditingController locationController = TextEditingController();

    // locationController에 초기 값 설정
    locationController.text = createGroupController.groupLocation.value;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         TextField(
            onChanged: (value) {
              createGroupController.setGroupName(value);
            },
            decoration: const InputDecoration(
              labelText: '그룹 이름',
              hintText: '그룹 이름을 입력하세요',
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => _showLocationPicker(context, createGroupController, locationController),
            child: AbsorbPointer(
              child: TextFormField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: '그룹 위치를 선택하세요',
                  hintText: '그룹 위치를 선택하세요',
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  createGroupController.createGroup();
                  locationController.dispose();
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                },
                child: const Text('그룹 만들기'),
              ),
              ElevatedButton(
                onPressed: () {
                  locationController.dispose();
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                child: const Text('취소'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLocationPicker(BuildContext context, CreateGroupController controller, TextEditingController locationController) {
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

