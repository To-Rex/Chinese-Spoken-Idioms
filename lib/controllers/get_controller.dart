import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/data_model.dart';
import '../pages/sample_page.dart';

class GetController extends GetxController {
  var height = 0.0.obs;
  var width = 0.0.obs;
  var fullName = 'Dilshodjon Haydarov'.obs;

  var isLoading = false.obs;
  var fileUrl = ''.obs;

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
  }

  //search data by character, return List<DataModel> with character contains search string
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
}
