import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LocalCategoryController extends GetxController {
  var max = 20;
  var local_max_length = 100;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    // TODO: implement onInit
    //fetch();
    paginateTask();
    super.onInit();
  }

  void paginateTask() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // print("reached end");
        if (max < 160) {
          max = max + 20;
          print(max.toString() + "......................");
          update();
        }
      }
    });
  }
}
