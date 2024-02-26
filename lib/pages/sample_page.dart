import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';

class SamplePage extends StatelessWidget {
  SamplePage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.changeWidgetOptions();
    _getController.getData();
    _getController.getDataFromInternet();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        title: Obx(() => _getController.index.value == 0
            ? Container(
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
              suffixIcon: Icon(Icons.search,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
        )
            : _getController.index.value == 1
            ? Text('Import Page',
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground))
            : _getController.index.value == 2
            ?Text('Collection Page', style: TextStyle(color: Theme.of(context).colorScheme.onBackground))
            : Text('Info Page', style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
        )
      ),
      body: Obx(() => _getController.widgetOptions.elementAt(_getController.index.value)),
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
              leading: Icon(Icons.book,
                  color: Theme.of(context).colorScheme.onBackground),
              title: Text('Dictionary',
                  style: TextStyle(fontSize: _getController.width * 0.04)),
              onTap: () {
                _getController.index.value = 0;
              },
            ),
            ListTile(
              leading: Icon(Icons.computer,
                  color: Theme.of(context).colorScheme.onBackground),
              title: Text('Created',
                  style: TextStyle(fontSize: _getController.width * 0.04)),
              onTap: () {
                _getController.index.value = 1;
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark, color: Theme.of(context).colorScheme.onBackground),
              title: Text('Collection', style: TextStyle(fontSize: _getController.width * 0.04)),
              onTap: () {
                _getController.index.value = 2;
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Theme.of(context).colorScheme.onBackground),
              title: Text('Info', style: TextStyle(fontSize: _getController.width * 0.04)),
              onTap: () {
                _getController.index.value = 3;
              },
            ),
          ],
        ),
      ),
    );
  }
}
