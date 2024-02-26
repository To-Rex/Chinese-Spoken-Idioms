import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_controller.dart';
import 'import_page.dart';

class SamplePage extends StatelessWidget {
  SamplePage({super.key});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.getData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        title: Container(
          padding: EdgeInsets.only(left: _getController.width * 0.03),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: _getController.searchController,
            keyboardType: TextInputType.text,
            onChanged: (value) {
              _getController.searchByCharacter(value);
            },
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Search',
              border: InputBorder.none,
              suffixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
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
                return ListTile(
                  leading: Text(_getController.dataModelList[index].character.toString()),
                  title: Text(_getController.dataModelList[index].character2.toString()),
                  subtitle: Text(_getController.dataModelList[index].pinyin.toString()),
                  trailing: Text(_getController.dataModelList[index].id.toString()),
                );
              },
            );
          }
        }),
      ),
      drawer: Drawer(
        //logo and name
        child: Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.onSecondary,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: _getController.height * 0.04),
                    Row(
                      children: [
                        Container(
                          height: _getController.height * 0.1,
                          width: _getController.height * 0.1,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/logo.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: _getController.width * 0.03),
                        Text(
                          'Chinese Spoken Idioms',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: _getController.width * 0.04,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: _getController.width * 0.03),
                        Text(
                          '汉语口语习惯用浯',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: _getController.width * 0.04,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: _getController.height * 0.01),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.book, color: Theme.of(context).colorScheme.onBackground),
              title: Text('Dictionary', style: TextStyle(fontSize: _getController.width * 0.04)),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.computer, color: Theme.of(context).colorScheme.onBackground),
              title: Text('Created', style: TextStyle(fontSize: _getController.width * 0.04)),
              onTap: () {
                Get.back();
                Get.to(() => ImportPage());
              },
            ),
            ListTile(
              leading: Icon(Icons.collections_bookmark, color: Theme.of(context).colorScheme.onBackground),
              title: Text('Reminder', style: TextStyle(fontSize: _getController.width * 0.04)),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Theme.of(context).colorScheme.onBackground),
              title: Text('Info', style: TextStyle(fontSize: _getController.width * 0.04)),
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}