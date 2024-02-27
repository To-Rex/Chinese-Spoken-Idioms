import 'dart:async';

import 'package:chinese_spoken_idioms/pages/sample_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/get_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.setHeightWidth(context);
    Timer(
      const Duration(seconds: 3),
      () => Get.off(() => SamplePage()),
    );
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: Column(
          children: [
            const Spacer(),
            Row(
              children: [
                const Spacer(),
                Image(image: const AssetImage('assets/logos.png'), width: _getController.width.value * 0.8, height: _getController.height.value * 0.3),
                const Spacer(),
              ],
            ),
            SizedBox(height: _getController.height.value * 0.02),
            Text('Chinese Spoken Idioms', style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.bold)),
            const Spacer(),
            Row(
              children: [
                const Spacer(),
                const CircularProgressIndicator(),
                SizedBox(width: _getController.width.value * 0.03),
                Text('Loading...', style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.bold)),
                const Spacer(),
              ],
            ),
            SizedBox(height: _getController.height.value * 0.04),
          ],
        ),
      )
    );
  }
}