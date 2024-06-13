import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../controller/group_controller.dart';


class GroupRequestPage extends StatelessWidget {
  final GroupController groupController = Get.find<GroupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('그룹 초대'),
        actions: [
          TextButton(
            onPressed: () {
              // 관리 버튼 클릭 시 동작
            },
            child: const Text(
              '관리',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Column(
            children: [
              Divider(height: 1, color: Colors.grey),
              SizedBox(height: 10), // 구분선과 리스트 사이의 간격 추가
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (groupController.invitedGroupList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: groupController.invitedGroupList.length,
            itemBuilder: (context, index) {
              final request = groupController.invitedGroupList[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: HexColor("#00E8C1"),
                  child: const Icon(Icons.group), // 그룹 아이콘으로 변경
                ),
                title: Text(request.groupName ?? ''),
                subtitle: Text('Total: ${request.total}'),
                trailing: Wrap(
                  spacing: 12, // 두 아이콘 사이의 간격
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue
                      ),
                      onPressed: () async {
                        bool isSuccess = await groupController.acceptRequest(request.id!);
                        if (isSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Group request accepted')),
                          );
                          groupController.getInvitedGroupList(); // 리스트를 다시 로드합니다.
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to accept group request')),
                          );
                        }
                      },
                      child: const Text('확인', style: TextStyle(
                          color: Colors.white
                      ),),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        // 닫기 버튼 클릭 시 동작
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}

