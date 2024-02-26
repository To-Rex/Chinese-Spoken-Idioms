import 'package:chinese_spoken_idioms/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.getData();
    return Scaffold(
      body: Obx(() {
        if (_getController.dataModelList.isEmpty) {
          return Center(
            child: Text('No data',
                style: TextStyle(fontSize: _getController.width * 0.04)),
          );
        } else {
          return ListView.builder(
            itemCount: _getController.dataModelList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Get.to(() => DetailPage(
                    id: _getController.dataModelList[index].id,
                    character: _getController.dataModelList[index].character,
                    character2: _getController.dataModelList[index].character2,
                    pinyin: _getController.dataModelList[index].pinyin,
                    comment: _getController.dataModelList[index].comment,
                    reminder: _getController.dataModelList[index].reminder,
                    examples: _getController.dataModelList[index].examples,
                  ),
                  );
                },
                leading: Text(_getController.dataModelList[index].character.toString()),
                title: Text(_getController.dataModelList[index].character2.toString()),
                subtitle: Text(_getController.dataModelList[index].pinyin.toString()),
                //trailing: Text(_getController.dataModelList[index].id.toString()),
                trailing: IconButton(
                  icon: Icon(
                      Icons.bookmark,
                      color: _getController.checkCollection(_getController.dataModelList[index].id!.toInt()) ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onBackground),
                  onPressed: () {
                    _getController.addCollection(int.parse(_getController.dataModelList[index].id.toString()));
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
