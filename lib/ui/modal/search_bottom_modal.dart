import 'package:flutter/material.dart';

class SearchBottomModal extends StatelessWidget {
  const SearchBottomModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      '친구 초대하기',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Example data, replace with your actual data source
                    UserList(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // This is just a placeholder since this class is not meant to be instantiated directly.
  }
}

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example data, replace with your actual data source
    final List<String> users = ['udada', 'cloudchamb3r', 'tack', '김은혁', '김동현', '권기범'];

    return Column(
      children: users
          .map((user) => ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(user),
        trailing: ElevatedButton(
          onPressed: () {
            // Invite functionality here
          },
          child: const Text('초대하기'),
        ),
      ))
          .toList(),
    );
  }
}

