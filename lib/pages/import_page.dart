import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';

class ImportPage extends StatelessWidget {
  ImportPage({super.key});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Import Page', style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
      ),
      body: Obx(() =>
          Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: _getController.height * 0.02),
              if(_getController.dataModelList.isNotEmpty)
                SizedBox(
                  height: _getController.height * 0.06,
                  width: _getController.width * 0.95,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                    },
                    child: Text('Export to file', style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
                  ),
                ),
              SizedBox(height: _getController.height * 0.02),
              Container(
                width: _getController.width * 0.95,
                padding: EdgeInsets.only(left: _getController.width * 0.03),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _getController.importController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 13,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(color: Theme.of(context).colorScheme.surface),
                  decoration: InputDecoration(
                    hintText: 'json file text',
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.surface.withOpacity(0.7)),
                    border: InputBorder.none,
                    //suffixIcon: Icon(Icons.file_upload, color: Theme.of(context).colorScheme.surface),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.file_upload, color: Theme.of(context).colorScheme.surface),
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['json'],
                        );
                        if (result != null) {
                          String? filePath = result.files.single.path;
                          if (filePath != null) {
                            _getController.importController.text = File(filePath).readAsStringSync();
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              if(_getController.dataModelList.isNotEmpty)
                SizedBox(
                  height: _getController.height * 0.02,
                ),
              if(_getController.dataModelList.isNotEmpty)
                SizedBox(
                  height: _getController.height * 0.06,
                  width: _getController.width * 0.95,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      _getController.dataModelList.clear();
                      _getController.importController.clear();
                    },
                    child: Text('Clear', style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
                  ),
                ),
              const Spacer(),
              SizedBox(
                height: _getController.height * 0.06,
                width: _getController.width * 0.95,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (_getController.importController.text.isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Please enter the json file text',
                        snackStyle: SnackStyle.FLOATING,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Theme.of(context).colorScheme.error,
                        colorText: Theme.of(context).colorScheme.onError,
                        icon: Icon(Icons.error, color: Theme.of(context).colorScheme.onError),
                        titleText: Text('Error', style: TextStyle(color: Theme.of(context).colorScheme.onError)),
                        margin: EdgeInsets.symmetric(horizontal: _getController.width * 0.03, vertical: _getController.height * 0.02),
                        padding: EdgeInsets.symmetric(horizontal: _getController.width * 0.03, vertical: _getController.height * 0.02),
                      );
                      return;
                    }
                    try {
                      _getController.saveData(_getController.importController.text);
                      Get.snackbar(
                        'Success',
                        'Data saved successfully',
                        snackStyle: SnackStyle.FLOATING,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        colorText: Theme.of(context).colorScheme.onSecondary,
                        icon: Icon(Icons.check, color: Theme.of(context).colorScheme.onSecondary),
                        titleText: Text('Success', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary)),
                        margin: EdgeInsets.symmetric(horizontal: _getController.width * 0.03, vertical: _getController.height * 0.02),
                        padding: EdgeInsets.symmetric(horizontal: _getController.width * 0.03, vertical: _getController.height * 0.02),
                      );
                    } catch (e) {
                      print(e);
                      Get.snackbar(
                        'Error',
                        'Invalid JSON format ${e.toString()}',
                        snackStyle: SnackStyle.FLOATING,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Theme.of(context).colorScheme.error,
                        colorText: Theme.of(context).colorScheme.onError,
                        icon: Icon(Icons.error, color: Theme.of(context).colorScheme.onError),
                        titleText: Text('Error', style: TextStyle(color: Theme.of(context).colorScheme.onError)),
                        margin: EdgeInsets.symmetric(horizontal: _getController.width * 0.03, vertical: _getController.height * 0.02),
                        padding: EdgeInsets.symmetric(horizontal: _getController.width * 0.03, vertical: _getController.height * 0.02),
                      );
                      return;
                    }

                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: _getController.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}