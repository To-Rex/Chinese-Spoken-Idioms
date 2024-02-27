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

  DetailPage(
      {super.key,
      required this.id,
      required this.character,
      required this.character2,
      required this.pinyin,
      required this.comment,
      required this.reminder,
      required this.examples});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Detail Page',
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground)),
          actions: [
            IconButton(
              icon: Icon(
                _getController.checkCollection(id)
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                color: Theme.of(context).colorScheme.error,
              ),
              onPressed: () {
                _getController.addCollection(id);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: _getController.height * 0.05,
                  width: _getController.width * 1),
              Text(character,
                  style: TextStyle(
                    fontSize: _getController.width * 0.13,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w900,
                  )),
              Container(
                width: _getController.width * 0.3,
                height: 2,
                padding: EdgeInsets.only(left: _getController.width * 0.05),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: _getController.height * 0.02),
              Text(character2,
                  style: TextStyle(
                    fontSize: _getController.width * 0.05,
                    color: Colors.green,
                    fontWeight: FontWeight.w900,
                  )),
              Text(pinyin,
                  style: TextStyle(fontSize: _getController.width * 0.05)),
              SizedBox(height: _getController.height * 0.05),
              if (comment != null && comment != '')
                Container(
                  width: _getController.width * 0.9,
                  padding: EdgeInsets.all(_getController.width * 0.03),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('Comment: $comment', style: TextStyle(fontSize: _getController.width * 0.045)),
                ),
              if (reminder != null && reminder != '')
                Container(
                    width: _getController.width * 0.9,
                    margin: EdgeInsets.only(top: _getController.height * 0.03),
                    padding: EdgeInsets.all(_getController.width * 0.03),
                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSecondary, borderRadius: BorderRadius.circular(10),),
                    child: Text('Reminder: $reminder', style: TextStyle(fontSize: _getController.width * 0.045))
                ),
              if (examples != null && examples != '')
                Container(
                    width: _getController.width * 0.9,
                    margin: EdgeInsets.only(top: _getController.height * 0.03, bottom: _getController.height * 0.03),
                    padding: EdgeInsets.all(_getController.width * 0.03),
                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSecondary, borderRadius: BorderRadius.circular(10)),
                    child: Text('Examples: $examples', style: TextStyle(fontSize: _getController.width * 0.045))
                ),
            ],
          ),
        )));
  }
}
