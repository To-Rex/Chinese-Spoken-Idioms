import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';

class InfoPage extends StatelessWidget {
  InfoPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          Center(
            child: Text(_getController.fullName.value,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: _getController.width * 0.04,
                )
            ),
          ),
      ),
    );
  }
}