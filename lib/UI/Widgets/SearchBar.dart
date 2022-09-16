import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sizer/sizer.dart';
import 'package:wallpix/controllers/SearchController.dart';
import '../../controllers/SearchedWallpaperComtroller.dart';
import './../../../Utility/Constants.dart';

class SearchBar extends GetView<SearchedWallpaperController> {
  SearchBar({
    Key? key,
  }) : super(key: key);
  final SearchController Searchcontroller =
      Get.put(SearchController(), permanent: false);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2.h, bottom: 2.h, left: 4.w, right: 4.w),
      height: 6.h,
      width: 80.w,
      decoration: BoxDecoration(
          color: theme.secondaryColor,
          borderRadius: BorderRadius.circular(12.sp)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: TextFormField(
          onChanged: (value) {
            controller.page = 1;

            controller.getwalls(value.toString());
            controller.paginateTask(value.toString());
            print(controller.page);
          },
          controller: Searchcontroller.searchController,
          //initialValue: ,
          style: const TextStyle(color: Colors.white),

          keyboardType: TextInputType.text,
          //  maxLength: 10,
          textAlign: TextAlign.left,
          autofocus: false,
          // initialValue: '',
          decoration: InputDecoration(
            // fillColor: Colors.white,
            prefixIcon: const Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
            hintText: 'Search',
            hintStyle: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.white.withOpacity(0.5)),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            counterText: "",
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ),
        ),
      ),
    );
  }
}
