import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_controller.dart';
import 'detail_page.dart';

class CollectionPage extends StatelessWidget {
  CollectionPage({super.key});
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
          //get all collection data from dataModelList
          List collectionList = [];
          for (var i = 0; i < _getController.dataModelList.length; i++) {
            if (_getController.checkCollection(
                int.parse(_getController.dataModelList[i].id.toString()))) {
              collectionList.add(_getController.dataModelList[i]);
            }
          }
          if (collectionList.isEmpty) {
            return Center(
              child: Text('No collection',
                  style: TextStyle(fontSize: _getController.width * 0.04)),
            );
          }
          return ListView.builder(
            itemCount: collectionList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Get.to(() => DetailPage(
                    id: collectionList[index].id,
                    character: collectionList[index].character,
                    character2: collectionList[index].character2,
                    pinyin: collectionList[index].pinyin,
                    comment: collectionList[index].comment,
                    reminder: collectionList[index].reminder,
                    examples: collectionList[index].examples,
                  ),
                  );
                },
                leading: Text(collectionList[index].character.toString()),
                title: Text(collectionList[index].character2.toString()),
                subtitle: Text(collectionList[index].pinyin.toString()),
                trailing: IconButton(
                  icon: Icon(
                      Icons.bookmark,
                      color: Theme.of(context).colorScheme.error),
                  onPressed: () {
                    _getController.addCollection(int.parse(collectionList[index].id.toString()));
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