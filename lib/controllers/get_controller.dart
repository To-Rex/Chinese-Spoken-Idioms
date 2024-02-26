import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chinese_spoken_idioms/pages/home_page.dart';
import 'package:chinese_spoken_idioms/pages/import_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/data_model.dart';
import '../pages/sample_page.dart';

class GetController extends GetxController {
  var bottomBarHeight = 0.0.obs;
  var height = 0.0.obs;
  var width = 0.0.obs;
  var fullName = 'Dilshodjon Haydarov'.obs;
  var index = 0.obs;
  var isLoading = false.obs;
  var fileUrl = ''.obs;
  var widgetOptions = <Widget>[];

  void changeWidgetOptions() {
    bottomBarHeight.value = height.value * 0.08;
    widgetOptions.add(HomePage());
    widgetOptions.add(ImportPage());

    /*widgetOptions.add(LibraryPage());
    widgetOptions.add(BasketPage());
    widgetOptions.add(AccountPage());*/
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
    print(text);
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
    //get data from storage
    getData();
  }

  List<DataModel> searchByCharacter(String search) {
    List<DataModel> result = getData()
        .where((element) =>
            element.character!.toLowerCase().contains(search.toLowerCase()) ||
            element.pinyin!.toLowerCase().contains(search.toLowerCase()) ||
            element.character2!.toLowerCase().contains(search.toLowerCase()))
        .toList();
    setDataModelList(result);
    return result;
  }

  //add collection save getstore _getController.dataModelList[index].id
  void addCollection(int id) {
    GetStorage box = GetStorage();
    List<int> collection = box.read('collection') ?? [];
    if (collection.contains(id)) {
      collection.remove(id);
      getData();
    } else {
      collection.add(id);
      getData();
    }
  }

  //check collection id
  bool checkCollection(int id) {
    GetStorage box = GetStorage();
    List<int> collection = box.read('collection') ?? [];
    return collection.contains(id);
  }
}
