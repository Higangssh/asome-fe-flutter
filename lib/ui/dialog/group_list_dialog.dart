import 'package:asome/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../model/dto/group_dto.dart';

class GroupListDialog extends StatelessWidget {
  final List<GroupDto> groups;

  GroupListDialog({super.key, required this.groups});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        height: 400, // 원하는 높이로 설정
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('그룹 목록', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 16.0,
                  ),),
                  const SizedBox(width: 10,),
                  Icon(Icons.group_add ,color: HexColor("#00E8C1") ,),
                ],
              )
            ),
            Expanded(
              child: Scrollbar(
                thumbVisibility: true, // 항상 스크롤바를 표시
                child: ListView.separated(
                  itemCount: groups.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(Icons.group, color: HexColor("#00E8C1") ),
                      title: Text(groups[index].groupName ?? 'N/A'),
                      subtitle: Text('참여 수: ${groups[index].total?.toString() ?? 'N/A'}'),
                      trailing: const FaIcon(FontAwesomeIcons.fileSignature, color: Colors.grey),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.toNamed(MainRoute.groupDetailRoot, arguments: groups[index].id);
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent
                ),
                child: const Text('닫기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

