import 'package:asome/controller/url_token_controller.dart';
import 'package:asome/service/api_initial_service.dart';
import 'package:asome/ui/bar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  late UrlTokenController _urlTokenController;
  late ApiInitialService apiService;

  @override
  void initState() {
    super.initState();
    _urlTokenController= Get.find<UrlTokenController>();
    print('access: ${_urlTokenController.accessToken.value}');
    apiService = ApiInitialService(_urlTokenController);
    _initialize();
  }
  Future<void> _initialize() async {
    await apiService.checkApiAndNavigateToMainPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(themeData: Theme.of(context),),
      body:  Obx(() {
        if (_urlTokenController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Center(
            child: ElevatedButton(
              onPressed: () async {
                await apiService.checkApiAndNavigateToMainPage(context);
              },
              child: const Text('네트워크 요청 재시도'),
            ),
          );
        }
      }),
    );
  }

}