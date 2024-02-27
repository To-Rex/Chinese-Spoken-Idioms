import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';
import 'package:document_viewer/document_viewer.dart';
import 'package:flutter_text_viewer/flutter_text_viewer.dart';

class ImportPage extends StatelessWidget {
  ImportPage({super.key});


  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextViewerPage(
        textViewer: TextViewer.asset(
          'assets/test.txt',
          highLightColor: Colors.yellow,
          focusColor: Colors.orange,
          ignoreCase: true,
        ),
        showSearchAppBar: false,
      ),
    );
  }
}