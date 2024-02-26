import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_controller.dart';

class DetailPage extends StatelessWidget {
  var id;
  var character;
  var character2;
  var pinyin;
  var comment;
  var reminder;
  var examples;
  DetailPage({super.key, required this.id, required this.character, required this.character2, required this.pinyin, required this.comment, required this.reminder, required this.examples});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Detail Page', style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: $id', style: TextStyle(fontSize: _getController.width * 0.05)),
            Text('Character: $character', style: TextStyle(fontSize: _getController.width * 0.05)),
            Text('Character2: $character2', style: TextStyle(fontSize: _getController.width * 0.05)),
            Text('Pinyin: $pinyin', style: TextStyle(fontSize: _getController.width * 0.05)),
            Text('Comment: $comment', style: TextStyle(fontSize: _getController.width * 0.05)),
            Text('Reminder: $reminder', style: TextStyle(fontSize: _getController.width * 0.05)),
            Text('Examples: $examples', style: TextStyle(fontSize: _getController.width * 0.05)),
          ],
        ),
      )
    );
  }
}