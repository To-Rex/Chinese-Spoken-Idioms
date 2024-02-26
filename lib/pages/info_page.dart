import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GetController _getController = Get.put(GetController());
    return  Scaffold(
      body: Center(
        child: Text(_getController.fullName.value,
          style: TextStyle(fontSize: _getController.width * 0.05),
        )
      ),
    );
  }
}