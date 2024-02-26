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
      body: Center(
        child: Obx(() {
          if (_getController.dataModelList.isEmpty) {
            return Center(
              child: Text('No data', style: TextStyle(fontSize: _getController.width * 0.04)),
            );
          } else {
            return ListView.builder(
              itemCount: _getController.dataModelList.length,
              itemBuilder: (context, index) {
                if (_getController.dataModelList[index].id == id) {
                  return ListTile(
                    leading: Text(_getController.dataModelList[index].character.toString()),
                    title: Text(_getController.dataModelList[index].character2.toString()),
                    subtitle: Text(_getController.dataModelList[index].pinyin.toString()),
                    trailing: Text(_getController.dataModelList[index].id.toString()),
                  );
                } else {
                  return Container();
                }
              },
            );
          }
        }),
      ),
    );
  }
}