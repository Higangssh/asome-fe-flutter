import 'package:asome/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/profile_controller.dart';
import '../../route/main_route.dart';
import 'my_post_list_page.dart';

class MyPage extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAndToNamed(MainRoute.mainRoot);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildProfileHeader(),
                SizedBox(height: 20),
                _buildMannerTemperature(),
                SizedBox(height: 20),
                _buildProfileDetails(),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey.shade300,
          child: Icon(Icons.person, size: 40, color: Colors.white),
        ),
        SizedBox(height: 10),
        Obx(() => Text(
          profileController.profile.value.nick,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // Handle profile edit
          },
          child: Text('프로필 수정'),
        ),
      ],
    );
  }

  Widget _buildMannerTemperature() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('매너온도', style: TextStyle(fontSize: 16)),
        SizedBox(height: 5),
        Row(
          children: [
            Text('첫 온도 36.5°C', style: TextStyle(color: Colors.grey)),
            Spacer(),
            Text('36.5°C', style: TextStyle(fontSize: 16)),
            SizedBox(width: 5),
            Icon(Icons.sentiment_satisfied, color: Colors.yellow, size: 20),
          ],
        ),
        SizedBox(height: 10),
        LinearProgressIndicator(
          value: 0.365,
          backgroundColor: Colors.grey.shade300,
          color: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildProfileDetails() {
    return Column(
      children: [
        ListTile(
          title: Text('내가 쓴글'),
          trailing: Icon(Icons.chevron_right),
          onTap: () async{
            await profileController.fetchMyPosts();
            Get.to(() => PostListPage(
              title: '내가 쓴 글',
              posts: profileController.myPosts,
            ));
          },
        ),
        ListTile(
          title: Text('내가 저장한 글'),
          trailing: Icon(Icons.chevron_right),
          onTap: ()  async {
            await profileController.fetchMyScraps();
            Get.to(() => PostListPage(
              title: '내가 저장한 글',
              posts: profileController.myScraps,
            ));
          },
        ),
        ListTile(
          title: Text('이용 약관'),
          trailing: Icon(Icons.chevron_right),
        ),
        ListTile(
          title: Text('로그 아웃'),
          trailing: Icon(Icons.chevron_right),
          onTap: () async{
            bool isSuccess=await profileController.fetchLogout();
            profileController.logoutProcess(isSuccess);
          },
        ),
        ListTile(
          title: Text('회원 탈퇴'),
          trailing: Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
