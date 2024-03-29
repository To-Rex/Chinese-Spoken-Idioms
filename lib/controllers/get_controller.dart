import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:chinese_spoken_idioms/pages/info_page.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:chinese_spoken_idioms/pages/collection_page.dart';
import 'package:chinese_spoken_idioms/pages/home_page.dart';
import 'package:chinese_spoken_idioms/pages/import_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/data_model.dart';

class GetController extends GetxController {
  var bottomBarHeight = 0.0.obs;
  var height = 0.0.obs;
  var width = 0.0.obs;
  var fullName = 'Hello World'.obs;
  var index = 0.obs;
  var isLoading = false.obs;
  var fileUrl = ''.obs;
  var widgetOptions = <Widget>[];

  void changeWidgetOptions() {
    bottomBarHeight.value = height.value * 0.08;
    widgetOptions.add(HomePage());
    widgetOptions.add(ImportPage());
    widgetOptions.add(CollectionPage());
    widgetOptions.add(InfoPage());
  }

  void changeIndex(int i) {
    index.value = i;
  }

  void setHeightWidth(BuildContext context) {
    height.value = MediaQuery.of(context).size.height;
    width.value = MediaQuery.of(context).size.width;
  }

  final TextEditingController searchController = TextEditingController();
  final TextEditingController importController = TextEditingController();

  var dataModel = DataModel().obs;
  var dataModelList = <DataModel>[].obs;

  void setDataModel(DataModel data) {
    dataModel.value = data;
  }

  void setDataModelList(List<DataModel> data) {
    dataModelList.value = data;
  }

  List<DataModel> getData() {
    GetStorage box = GetStorage();
    String text = box.read('json') ?? '';
    if (text.isEmpty) {
      return List<DataModel>.empty();
    } else {
      List<DataModel> data = jsonDecode(text).map<DataModel>((json) => DataModel.fromJson(json)).toList();
      setDataModelList(data);
      return data;
    }
  }

  void saveData(String text) {
    GetStorage box = GetStorage();
    box.write('json', text);
    importController.clear();
    getData();
  }

  void clearData() {
    GetStorage box = GetStorage();
    box.remove('json');
    box.remove('collection');
    getData();
  }

  Future<void> getDataFromInternet() async {
    GetStorage box = GetStorage();
    var url = Uri.parse('https://raw.githubusercontent.com/To-Rex/Chinese-Spoken-Idioms/master/assets/Idoms.json');
    var response = await get(url);
    if (response.statusCode == 200) {
      if (box.read('json').toString().isEmpty||box.read('json').toString() != response.body.toString()){
        saveData(response.body);
      }
    } else {
      Get.snackbar(
        'Xatolik',
        'Ma\'lumotlar yuklanmadi',
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Theme.of(Get.context!).colorScheme.error,
        colorText: Theme.of(Get.context!).colorScheme.onError,
        icon: Icon(Icons.error, color: Theme.of(Get.context!).colorScheme.onError),
        titleText: Text('Error', style: TextStyle(color: Theme.of(Get.context!).colorScheme.onError)),
        margin: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
        padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
      );
    }
  }


  List<DataModel> searchByCharacter(String search) {
    List<DataModel> result = getData()
        .where((element) =>
        search.length == 1
            ? element.character!.toLowerCase().contains(search.toLowerCase())
            : element.character!.toLowerCase().contains(search.toLowerCase()) ||
            element.pinyin!.toLowerCase().contains(search.toLowerCase()) ||
            element.character2!.toLowerCase().contains(search.toLowerCase()))
        .toList();
    setDataModelList(result);
    return result;
  }

  void addCollection(int id) {
    GetStorage box = GetStorage();
    List<int> collection = List<int>.from(box.read('collection') ?? []);
    if (collection.contains(id)) {
      collection.remove(id);
      box.write('collection', collection);
      getData();
      Get.snackbar(
        'Eslatma',
        'Eslatmalarni o\'chirildi',
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade300,
        colorText: Theme.of(Get.context!).colorScheme.background,
        icon: Icon(Icons.delete, color: Theme.of(Get.context!).colorScheme.background),
        titleText: Text('Info', style: TextStyle(color: Theme.of(Get.context!).colorScheme.background)),
        margin: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
        padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
      );
    } else {
      collection.add(id);
      box.write('collection', collection);
      getData();
      Get.snackbar(
        'Eslatma',
        'Eslatmalarni qo\'shildi',
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade300,
        colorText: Theme.of(Get.context!).colorScheme.background,
        icon: Icon(Icons.add_circle, color: Theme.of(Get.context!).colorScheme.background),
        titleText: Text('Info', style: TextStyle(color: Theme.of(Get.context!).colorScheme.background)),
        margin: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
        padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
      );
    }
  }

  bool checkCollection(int id) {
    GetStorage box = GetStorage();
    List<int> collection = List<int>.from(box.read('collection') ?? []);
    return collection.contains(id);
  }

  void exportData() {
    GetStorage box = GetStorage();
    String text = box.read('json') ?? '';
    if (text.isEmpty) {
      Get.snackbar(
        'Xatolik',
        'Eksport qilinadigan ma\'lumotlar yo\'q',
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Theme.of(Get.context!).colorScheme.error,
        colorText: Theme.of(Get.context!).colorScheme.onError,
        icon: Icon(Icons.error, color: Theme.of(Get.context!).colorScheme.onError),
        titleText: Text('Error', style: TextStyle(color: Theme.of(Get.context!).colorScheme.onError)),
        margin: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
        padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
      );
      return;
    }
    final String dir = Directory.fromRawPath(Uint8List.fromList('/storage/emulated/0/Download'.codeUnits)).path;
    final File file = File('$dir/export.json');
    file.writeAsStringSync(text);
    fileUrl.value = file.path;
  }

}
