

import 'package:asome/ui/bar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(themeData: Theme.of(context),),
      body: Container(
        decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey,
                width: 1.0, // 보더의 두께
              ),
            ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.receipt, color: Colors.green),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '매칭을 진행해 보세요!',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],

                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        '현재 매칭 진행 현황',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: 0.6,
                        backgroundColor: Colors.red,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
            const SizedBox(height: 20),
              const SizedBox(height: 10),
              _buildGridItem(Icons.favorite, '매칭', '그룹과 매칭하세요'),
                const SizedBox(height: 10),
              _buildGridItem(Icons.group_add, '그룹 만들기', '새로운 그룹을 만드세요'),
              const SizedBox(height: 10),
              _buildGridItem(Icons.group, '그룹 조회', '기존 그룹을 조회하세요'),
              const SizedBox(height: 10),
              _buildGridItem(Icons.support_agent, '고객센터', '문의사항을 남기세요'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          Icon(icon, color:  HexColor("#A3FFD6"), size: 40),
        ],
      ),
    );
  }
}