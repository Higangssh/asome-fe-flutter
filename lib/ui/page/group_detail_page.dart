import 'package:asome/ui/bar/custom_bottombar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../controller/group_detail_controller.dart';
import '../modal/search_bottom_modal.dart';

class GroupDetailPage extends StatelessWidget {
  const GroupDetailPage({super.key, required groupId});

  @override
  Widget build(BuildContext context) {
    final int groupId = Get.arguments;
    final GroupDetailController controller = Get.find<GroupDetailController>();
    // 요청 메소드 받기
    controller.fetchGroupDetails(groupId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('그룹 상세 정보'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
      body: Obx(() {
        if (controller.group.value.id == 0) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView( 
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${controller.group.value.groupName}',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: HexColor("#00E8C1")),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '맴버 ${controller.group.value.total}명 • 선호 지역 : ${controller.group.value.groupLoc}',
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '그룹 멤버',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.exit_to_app, size: 25, color: Colors.black54),
                            onPressed: () {
                              // 나가기 기능을 여기에 구현
                            },
                          ),
                          const SizedBox(width: 5),
                          IconButton(
                            icon: const Icon(FontAwesomeIcons.userPlus, size: 20, color: Colors.black54),
                            onPressed: () {
                              // 그룹 추가 기능을 여기에 구현
                              SearchBottomModal.show(context , groupId);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true, // 변경된 부분: shrinkWrap을 true로 설정
                    physics: NeverScrollableScrollPhysics(), // 변경된 부분: 내부 스크롤 비활성화
                    itemCount: controller.group.value.members!.length,
                    itemBuilder: (context, index) {
                      final member = controller.group.value.members![index];
                      final isHost = member.id == controller.group.value.hostId!;
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(member.nick!),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('성별: ${member.gender}'),
                            Text(member.universityName!),
                            Text('생년월일: ${controller.formatDate(member.birth!)}'),
                          ],
                        ),
                        trailing: isHost
                            ? const Icon(FontAwesomeIcons.crown, color: Colors.amber)
                            : const Icon(FontAwesomeIcons.users, color: Colors.black),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
